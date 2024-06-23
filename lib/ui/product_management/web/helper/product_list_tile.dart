import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/product_management/product_management_controller.dart';
import 'package:kody_operator/framework/repository/product_management/model/response_model/get_product_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/product_management/web/helper/quantity_widget.dart';
import 'package:kody_operator/ui/utils/anim/slide_up_transition.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_cupertino_switch.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/empty_state_widget.dart';
import 'package:kody_operator/ui/widgets/pagination_bottom_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProductListTile extends ConsumerStatefulWidget {
  final GestureTapCallback? onTap;

  const ProductListTile({super.key, this.onTap});

  @override
  ConsumerState<ProductListTile> createState() => _ProductListTileState();
}

class _ProductListTileState extends ConsumerState<ProductListTile> with BaseConsumerStatefulWidget, TickerProviderStateMixin {
  List<AnimationController> expandController = [];
  List<Animation<double>> animation = [];
  ScrollController productListController = ScrollController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final productManagementWatch = ref.watch(productManagementController);
      int controllerIndex = 0;
      for (controllerIndex = 0; controllerIndex < productManagementWatch.productList.length; controllerIndex++) {
        expandController.add(AnimationController(vsync: this, duration: const Duration(milliseconds: 300)));
        animation.add(CurvedAnimation(parent: expandController[controllerIndex], curve: Curves.fastOutSlowIn));
      }
      productManagementWatch.notifyListeners();
    });
  }

  Future<void> _runExpandCheck(bool isExpand, int controllerIndex) async {
    final productManagementWatch = ref.watch(productManagementController);
    if (isExpand) {
      for (var controller in expandController) {
        if (controller != expandController[controllerIndex]) {
          if (controller.value != 0) {
            int productIndex = expandController.indexWhere((element) => element == controller);
            if (productIndex != -1) {
              await controller.reverse().then((value) {
                productManagementWatch.updateExpandWidget(productModel: productManagementWatch.productList[productIndex]);
              });
            }
          }
        }
      }
      await expandController[controllerIndex].forward();
    } else {
      await expandController[controllerIndex].reverse();
    }
  }

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final productManagementWatch = ref.watch(productManagementController);
        return animation.isNotEmpty
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: productManagementWatch.productList.length,
                      controller: productListController,
                      itemBuilder: (BuildContext context, int productIndex) {
                        if (productManagementWatch.productList.isEmpty) {
                          return EmptyStateWidget(
                            title: LocalizationStrings.keyNoDataFound.localized,
                            titleColor: AppColors.black,
                          ).paddingOnly(top: MediaQuery.of(context).size.height / 4);
                        } else {
                          GetProductListResponseData productModel = productManagementWatch.productList[productIndex];
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: AppColors.whiteF7F7FC,
                            ),
                            child: Column(
                              children: [
                                /// Product List Tile
                                Table(
                                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                  textDirection: TextDirection.ltr,
                                  columnWidths: {
                                    0: FlexColumnWidth(2.w), /// status
                                    1: FlexColumnWidth(3.w), /// product name
                                    2: FlexColumnWidth(3.w), /// categories
                                    3: FlexColumnWidth(6.5.w), ///  product status
                                    4: FlexColumnWidth(3.w), /// See customization
                                  },
                                  children: [
                                    TableRow(
                                        children: [
                                          /// Status Cupertino switch Active Or DeActive
                                          (productManagementWatch.updateProductStatusState.isLoading && (productManagementWatch.selectedProductUuid == productModel.uuid))
                                              ? LoadingAnimationWidget.waveDots(color: AppColors.black, size: 22.h).paddingOnly(left: 18.w).alignAtCenterLeft()
                                              : CommonCupertinoSwitch(
                                                switchValue: productModel.isAvailable ?? false,
                                                onChanged: (val) async {
                                                  await productManagementWatch.updateProductStatusApi(
                                                    context,
                                                    productUuid: productModel.uuid ?? '',
                                                    isAvailable: val,
                                                  );
                                                },
                                              ).paddingOnly(left: 8.w).alignAtCenterLeft(),

                                          /// Product Name
                                          Row(
                                            children: [
                                              /// Product Image
                                              ClipOval(
                                                child: CachedNetworkImage(height: 53.h, width: 53.h, imageUrl: productModel.imageUrl ?? staticImageURL),
                                              ).paddingOnly(right: 8.w),
                                              Expanded(
                                                child: CommonText(
                                                  maxLines: 3,
                                                  title: productModel.productName ?? '',
                                                  textStyle: TextStyles.regular.copyWith(fontSize: 14.sp),
                                                ).paddingOnly(right: 5.w),
                                              ),
                                            ],
                                          ),

                                          ///Category Name
                                          CommonText(
                                            maxLines: 3,
                                            title: productModel.categoryName ?? '',
                                            textStyle: TextStyles.regular.copyWith(fontSize: 14.sp),
                                          ),

                                          ///Available and Unavailable Text
                                          productModel.isAvailable ?? false
                                              ? CommonText(
                                            textAlign: TextAlign.left,
                                            title: productManagementWatch.getOrderStatusTextColor(ProductStatusEnum.available).productStatus,
                                            textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: productManagementWatch.getOrderStatusTextColor(ProductStatusEnum.available).productStatusTextColor),
                                          ).paddingOnly(right: 5.w)
                                              : CommonText(
                                            textAlign: TextAlign.left,
                                            title: productManagementWatch.getOrderStatusTextColor(ProductStatusEnum.unAvailable).productStatus,
                                            textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: productManagementWatch.getOrderStatusTextColor(ProductStatusEnum.unAvailable).productStatusTextColor),
                                          ),

                                          /// See customization text
                                          productManagementWatch.productDetailState.isLoading && (productIndex == productManagementWatch.updatingProductIndex)
                                              ? Row(
                                                children: [
                                                  const Spacer(),
                                                  LoadingAnimationWidget.waveDots(color: AppColors.blue, size: 22.h).paddingOnly(right: 10.w),
                                                  const Spacer(),
                                                ],
                                              )
                                              : Visibility(
                                            visible: productModel.isAvailable ?? true,
                                            child: InkWell(
                                              onTap: () async {
                                                /// To Expand/Show Customization Widget
                                                if (productModel.isExpanded == false) {
                                                  productManagementWatch.updateExpandWidget(productModel: productModel);
                                                  _runExpandCheck(true, productIndex);
                                                  await productManagementWatch.productDetailApi(context, productModel.uuid ?? '');
                                                } else {
                                                  _runExpandCheck(false, productIndex).then(
                                                        (value) {
                                                      productManagementWatch.updateExpandWidget(productModel: productModel);
                                                    },
                                                  );
                                                }
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    constraints: BoxConstraints(maxWidth: context.width * 2),
                                                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                                                    child: CommonText(
                                                      maxLines: 1,
                                                      title: LocalizationStrings.keySeeCustomization.localized,
                                                      textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.blue009AF1, decoration: TextDecoration.underline),
                                                    ),
                                                  ),

                                                  /// Trailing Icon
                                                  CommonSVG(
                                                    strIcon: productModel.isExpanded ?? false ? AppAssets.svgUpArrow : AppAssets.svgDownArrow,
                                                    height: 16.h,
                                                    width: 16.h,
                                                  ),
                                                ],
                                              ).paddingOnly(right: 5.w),
                                            ),
                                          ).paddingOnly(right: 10.w)



                                        ]),
                                  ],
                                ).paddingSymmetric(vertical: 6.h),

                                /// Customization Widget
                                SizeTransition(
                                  axisAlignment: 1.0,
                                  sizeFactor: animation[productIndex],
                                  child: productModel.isExpanded ?? false
                                      ? productManagementWatch.productDetailState.isLoading
                                          ? SizedBox(
                                              height: context.height * 0.1,
                                              child: const CircularProgressIndicator(color: AppColors.black).alignAtCenter(),
                                            )
                                          : Column(
                                              children: [
                                                /// Divider
                                                const Divider(color: AppColors.greyDCD9D9).paddingOnly(left: context.width * 0.012, right: context.width * 0.012, bottom: context.height * 0.016),
                                                GridView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: productManagementWatch.productDetailState.success?.data?.productAttributes?.length ?? 0,
                                                  itemBuilder: (BuildContext context, int componentIndex) {
                                                    return QuantityWidget(
                                                      productAttribute: productManagementWatch.productDetailState.success?.data?.productAttributes?[componentIndex],
                                                    ).paddingOnly(right: context.width * 0.012, bottom: context.height * 0.015);
                                                  },
                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 4,
                                                    mainAxisExtent: context.height * 0.32,
                                                    mainAxisSpacing: context.height * 0.03,
                                                    crossAxisSpacing: context.width * 0.005,
                                                  ),
                                                ).paddingOnly(left: context.width * 0.012),
                                              ],
                                            )
                                      : const Offstage(),
                                ),
                              ],
                            ),
                          ).paddingOnly(bottom: 20.h);
                        }
                      },
                    ).paddingOnly(top: 26.h, bottom: 20.h),
                  ),
                  productManagementWatch.getProductListState.success != null
                      ? SlideUpTransition(
                          child: PaginationBottomWidget(
                            hasNextPage: productManagementWatch.getProductListState.success
                                ?.hasNextPage ?? false,
                            hasPreviousPage: productManagementWatch.getProductListState.success
                                ?.hasPreviousPage ?? false,
                            totalEntries: productManagementWatch.getProductListState.success
                                ?.totalCount ?? 0,
                            totalPages: productManagementWatch.getProductListState.success
                                ?.totalPages ?? 0,
                            currentPage: productManagementWatch.getProductListState.success
                                ?.pageNumber ?? 0,
                            pageSize: pageSize,
                            onButtonTap: (int pageNumber) {
                              productManagementWatch.getProductListApi(
                                  context, pageNumber: pageNumber, isWeb: true);
                            },
                          ).paddingOnly(bottom: 20.h),
                        ).paddingSymmetric(horizontal: 30.w)
                      : const Offstage(),
                ],
              )
            : EmptyStateWidget(title: LocalizationStrings.keyNoDataFound.localized, titleColor: AppColors.black);
      },
    );
  }
}
