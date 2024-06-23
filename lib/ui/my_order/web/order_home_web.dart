
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/my_order/order_home_controller.dart';
import 'package:kody_operator/framework/repository/order/model/response/product_list_reponse_model.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_order/web/helper/order_status_bottom_widget_web.dart';
import 'package:kody_operator/ui/my_order/web/helper/product_item_tile_web.dart';
import 'package:kody_operator/ui/my_order/web/helper/select_product_type_button.dart';
import 'package:kody_operator/ui/my_order/web/shimmer/order_home_shimmer.dart';
import 'package:kody_operator/ui/utils/helpers/base_page_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/empty_state_widget.dart';

class OrderHomeWeb extends ConsumerStatefulWidget {
  const OrderHomeWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<OrderHomeWeb> createState() => _OrderHomeWebState();
}

class _OrderHomeWebState extends ConsumerState<OrderHomeWeb> with BaseConsumerStatefulWidget, BaseDrawerPageWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final orderHomeWatch = ref.read(orderHomeController);
      orderHomeWatch.disposeController(isNotify: true);
      orderHomeWatch.categoryListApi(context).then((value) async {
        await orderHomeWatch.productListApi(context);
      });
    });
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    final orderHomeWatch = ref.watch(orderHomeController);
    return Stack(
      children:[ Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                CommonText(
                  title: LocalizationStrings.keyOrder.localized,
                  textStyle: TextStyles.regular.copyWith(
                    fontSize: 20.sp,
                    color: AppColors.black,
                  ),
                ).paddingOnly(left: 20.w),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: context.height * 0.08,
                  child: const SelectCategoryWidget(),
                ).paddingOnly(bottom: 30.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),

                        /// Product List
                        (orderHomeWatch.productListState.isLoading) || (orderHomeWatch.categoryListState.isLoading)
                            ? const ShimmerHomeOrderWidget()
                            //
                            // /// Dialog bar
                            // const Center(
                            //     child: CircularProgressIndicator(color: AppColors.black),
                            //   )

                            ///Empty State
                            : (orderHomeWatch.productListState.success?.data?.isEmpty ?? true)
                                ? const EmptyStateWidget()

                                /// List widget
                                : GridView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount: orderHomeWatch.productListState.success?.data?.length ?? 0,
                                    itemBuilder: (BuildContext context, int index) {
                                      ProductList? productList = orderHomeWatch.productListState.success?.data?[index];
                                      return ProductItemTileWeb(
                                        product: productList,
                                      );
                                      // return const ProductItemTileWebShimmer();
                                    },
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisExtent: context.height * 0.4,
                                      mainAxisSpacing: 40.h,
                                      crossAxisSpacing: 25.w,
                                    ),
                                  ).paddingOnly(left: 35.w, right: context.width * 0.1)
                      ],
                    ),
                  ),
                ),
              ],
            ).paddingSymmetric(vertical: 10.h, horizontal: 10.w),
          ),

        ],
      ).paddingSymmetric(horizontal: 20.w, vertical: 30.h),


       const Align(alignment: Alignment.bottomCenter,child: OrderStatusBottomWidgetWeb()),
      ]
    );
  }
}

class SelectCategoryWidget extends ConsumerWidget {
  const SelectCategoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderHomeWatch = ref.watch(orderHomeController);
    return Row(
      children: [
        SelectProductTypeButton(
          svgAsset: AppAssets.svgProductTypeAll,
          title: LocalizationStrings.keyAllItems.localized,
          isSelected: orderHomeWatch.selectedCategory == null,
          onTap: () async {
            orderHomeWatch.changeSelectedCategoryIndex(null);
            await orderHomeWatch.productListApi(context, categoryUuid: null);
          },
        ).paddingOnly(right: 20.w),
        InkWell(
          onTap: () async {
            showCommonWebDialog(
              context: context,
              dialogBody: Consumer(builder: (context, ref, child) {
                final orderHomeDialogWatch = ref.watch(orderHomeController);
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                          title: LocalizationStrings.keyCategories.localized,
                          textStyle: TextStyles.regular.copyWith(
                            fontSize: 18.sp,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const CommonSVG(
                            strIcon: AppAssets.svgCrossRounded,
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          Wrap(
                            children: List.generate(
                              orderHomeWatch.categoryListState.success?.data?.length ?? 0,
                              (index) {
                                return SelectProductTypeButton(
                                  svgAsset: AppAssets.svgProductTypeSnacks,
                                  title: orderHomeWatch.categoryListState.success?.data?[index].name ?? '',
                                  isSelected: orderHomeWatch.categoryListState.success?.data?.elementAt(index) == orderHomeWatch.selectedCategory,
                                  onTap: () async {
                                    orderHomeWatch.changeSelectedCategoryIndex(orderHomeWatch.categoryListState.success?.data?[index]).then((value) {
                                      Navigator.pop(context);
                                      orderHomeDialogWatch.productListApi(context, categoryUuid: orderHomeWatch.categoryListState.success?.data?[index].uuid).then((value) {});
                                    });
                                  },
                                ).paddingOnly(right: 30.w, bottom: 10.w);
                              },
                            ),
                          ).paddingSymmetric(vertical: 30.h),
                        ],
                      ),
                    )
                  ],
                ).paddingSymmetric(vertical: 30.h, horizontal: 30.w);
              }),
            );
          },
          child: Container(
            height: 50.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.r),
              border: orderHomeWatch.selectedCategory != null ? null : Border.all(color: AppColors.greyD6D6D6, width: 1),
              color: orderHomeWatch.selectedCategory != null ? AppColors.black : AppColors.transparent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CommonSVG(
                  strIcon: AppAssets.svgProductTypeAll,
                  svgColor: AppColors.clr8F8F8F,
                ),
                CommonText(
                  title: 'Other Categories',
                  maxLines: 3,
                  textStyle: TextStyles.regular.copyWith(
                    color: orderHomeWatch.selectedCategory != null ? AppColors.white : AppColors.clr8F8F8F,
                    fontSize: 16.sp,
                  ),
                ).paddingOnly(left: 8.w),
              ],
            ).paddingSymmetric(horizontal: 15.w, vertical: 15.h),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
