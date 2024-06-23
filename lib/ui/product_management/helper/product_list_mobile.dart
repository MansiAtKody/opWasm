import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/product_management/product_management_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/repository/product_management/model/response_model/get_product_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/product_management/helper/customization_dialog.dart';
import 'package:kody_operator/ui/utils/anim/show_down_transition.dart';
import 'package:kody_operator/ui/utils/anim/slide_up_transition.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_cupertino_switch.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/dialog_progressbar.dart';
import 'package:kody_operator/ui/widgets/empty_state_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProductListMobile extends ConsumerStatefulWidget {
  final GestureTapCallback? onTap;

  const ProductListMobile({super.key, this.onTap});

  @override
  ConsumerState<ProductListMobile> createState() => _ProductListMobileState();
}

class _ProductListMobileState extends ConsumerState<ProductListMobile> with BaseConsumerStatefulWidget {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final productManagementWatch = ref.watch(productManagementController);

      /// for pagination
      scrollController.addListener(() async {
        if (productManagementWatch.getProductListState.success?.hasNextPage ?? false) {
          if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
            if (!productManagementWatch.getProductListState.isLoadMore) {
              await productManagementWatch.getProductListApi(context, isWeb: false);
            }
          }
        }
      });
    });
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final productManagementWatch = ref.watch(productManagementController);
        return ListView.builder(
          controller: scrollController,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          itemCount: productManagementWatch.productList.length + 1,
          itemBuilder: (BuildContext context, int productIndex) {
            if (productManagementWatch.productList.isEmpty) {
              return EmptyStateWidget(
                title: LocalizationStrings.keyNoDataFound.localized,
                titleColor: AppColors.black,
              ).paddingOnly(top: MediaQuery.of(context).size.height / 4);
            } else {
              if (productIndex != productManagementWatch.productList.length) {
                GetProductListResponseData productModel = productManagementWatch.productList[productIndex];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: AppColors.whiteF7F7FC,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ///Product Image
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText(
                            title: 'Product Image',
                            textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
                          ),
                          ClipOval(
                            child: CachedNetworkImage(height: 40.h, width: 40.h, imageUrl: productModel.imageUrl ?? staticImageURL),
                          )
                        ],
                      ).paddingOnly(bottom: 10.h),

                      ///Product Name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText(
                            title: LocalizationStrings.keyProductName.localized,
                            textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
                          ),
                          CommonText(
                            maxLines: 3,
                            title: productModel.productName ?? '',
                            textStyle: TextStyles.regular.copyWith(fontSize: 14.sp),
                          )
                        ],
                      ).paddingOnly(bottom: 10.h),

                      ///Category Name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText(
                            title: LocalizationStrings.keyCategories.localized,
                            textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
                          ),
                          CommonText(
                            maxLines: 3,
                            title: productModel.categoryName ?? '',
                            textStyle: TextStyles.regular.copyWith(fontSize: 14.sp),
                          )
                        ],
                      ).paddingOnly(bottom: 10.h),

                      ///Available and Unavailable
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText(
                            title: LocalizationStrings.keyProductStatus.localized,
                            textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
                          ),
                          productModel.isAvailable ?? false
                              ? ShowDownTransition(
                                  duration: 200,
                                  child: CommonText(
                                    textAlign: TextAlign.left,
                                    title: productManagementWatch.getOrderStatusTextColor(ProductStatusEnum.available).productStatus,
                                    textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: productManagementWatch.getOrderStatusTextColor(ProductStatusEnum.available).productStatusTextColor),
                                  ).paddingOnly(right: 5.w),
                                )
                              : SlideUpTransition(
                                  duration: 200,
                                  child: CommonText(
                                    textAlign: TextAlign.left,
                                    title: productManagementWatch.getOrderStatusTextColor(ProductStatusEnum.unAvailable).productStatus,
                                    textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: productManagementWatch.getOrderStatusTextColor(ProductStatusEnum.unAvailable).productStatusTextColor),
                                  ),
                                ),
                        ],
                      ).paddingOnly(bottom: 10.h),

                      ///Switch
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText(
                            title: LocalizationStrings.keyActiveInactive.localized,
                            textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.grey8D8C8C),
                          ),
                          (productManagementWatch.updateProductStatusState.isLoading && (productManagementWatch.selectedProductUuid == productModel.uuid))
                              ? LoadingAnimationWidget.waveDots(color: AppColors.black, size: 22.h).alignAtCenterLeft().paddingOnly(left: 5.w)
                              : Align(
                                  alignment: Alignment.centerLeft,
                                  child: CommonCupertinoSwitch(
                                    switchValue: productModel.isAvailable ?? false,
                                    onChanged: (val) async {
                                      await productManagementWatch.updateProductStatusApi(
                                        context,
                                        productUuid: productModel.uuid ?? '',
                                        isAvailable: val,
                                      );
                                    },
                                  ),
                                )
                        ],
                      ).paddingOnly(bottom: 10.h),

                      Visibility(visible: productModel.isAvailable ?? true, child: const Divider(color: AppColors.greyDCD9D9)),

                      ///Customization
                      Visibility(
                        visible: productModel.isAvailable ?? true,
                        child: InkWell(
                          onTap: () async {
                            await productManagementWatch.productDetailApi(context, productModel.uuid ?? '').then((value) {
                              if (productManagementWatch.productDetailState.success?.status == ApiEndPoints.apiStatus_200) {
                                /// Show Customization Widget
                                showCommonMobileDialog(
                                  height: context.height * 0.9,
                                  context: context,
                                  dialogBody: CustomizationDialog(productModel: productModel),
                                );
                              }
                            });
                            //productManagementWatch.updateExpandWidget(productModel: productModel, index: productIndex);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                constraints: BoxConstraints(maxWidth: context.width * 2),
                                child: CommonText(
                                  maxLines: 1,
                                  title: LocalizationStrings.keySeeCustomization.localized,
                                  textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.blue009AF1, decoration: TextDecoration.underline),
                                ),
                              ),

                              /// Trailing Icon
                              CommonSVG(
                                strIcon: AppAssets.svgRightArrow,
                                height: 16.h,
                                width: 16.h,
                                svgColor: AppColors.blue009AF1,
                              ).paddingOnly(top: 5.h),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ).paddingSymmetric(vertical: 15.h, horizontal: 20.w),
                ).paddingOnly(bottom: 20.h);
              } else {
                return DialogProgressBar(
                  isLoading: productManagementWatch.getProductListState.isLoadMore,
                  forPagination: true,
                ).paddingOnly(bottom: 20.h);
              }
            }
          },
        );
      },
    );
  }
}
