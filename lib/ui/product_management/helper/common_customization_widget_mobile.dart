import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/product_management/product_management_controller.dart';
import 'package:kody_operator/framework/repository/product_management/model/response_model/product_detail_reponse_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_cupertino_switch.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CommonCustomizationWidgetMobile extends StatelessWidget with BaseStatelessWidget {
  final ProductAttribute? productAttribute;
  const CommonCustomizationWidgetMobile({
    super.key,
    required this.productAttribute,
  });

  @override
  Widget buildPage(BuildContext context) {
    print('Uvuvuv');
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final productManagementWatch = ref.watch(productManagementController);
        //List<SeeCustomizedItemModel> componentList = productManagementWatch.productList[productIndex].productComponentList[componentIndex];
        return Container(
          // width: MediaQuery.sizeOf(context).width * 0.2,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r), color: AppColors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText(
                    title: productAttribute?.attributeName ?? '',
                    textStyle: TextStyles.medium.copyWith(fontSize: 14.sp, color: AppColors.black171717),
                  ),
                  if (productManagementWatch.updateProductAttributeStatusState.isLoading &&
                      (productManagementWatch.updatingProductAttributeIndex == productManagementWatch.productDetailState.success?.data?.productAttributes?.indexWhere((attribute) => attribute.uuid == productAttribute?.uuid)))
                    LoadingAnimationWidget.waveDots(color: AppColors.black, size: 22.h)
                  else
                    CommonCupertinoSwitch(
                      switchValue: productAttribute?.isAvailable ?? false,
                      onChanged: (val) async {
                        await productManagementWatch.updateProductAttributeStatusApi(context, attributeUuid: productAttribute?.uuid ?? '', active: val,productUuid: productManagementWatch.productDetailState.success?.data?.uuid??'');
                      },
                    ),
                ],
              ).paddingOnly(bottom: 16.h),
              Container(
                padding: EdgeInsets.only(bottom: 15.h),
                child: ListView.separated(
                  itemCount: productAttribute?.productAttributeNames?.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int singleComponentIndex) {
                    ProductAttributeName? attributeName = productAttribute?.productAttributeNames?[singleComponentIndex];
                    return Row(
                      children: [
                        /// Icon
                        InkWell(
                          child: Container(
                            height: 50.h,
                            width: 50.h,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.whiteF7F7FC,
                            ),
                            child: attributeName?.attributeNameImage != null
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(100.r),
                              child: CacheImage(
                                imageURL: attributeName?.attributeNameImage ?? '',
                                height: 30.h,
                                width: 30.h,
                              ),
                            )
                                : const Offstage(),
                          ),
                        ).paddingOnly(right: 8.w),

                        /// Name
                        CommonText(
                          title: attributeName?.attributeNameName ?? '',
                          textStyle: TextStyles.regular.copyWith(color: AppColors.black),
                        ),
                        const Spacer(),

                        ///Status
                        if (productManagementWatch.updateProductAttributeNameStatusState.isLoading &&
                            productManagementWatch.updatingProductAttributeNameIndex == singleComponentIndex &&
                            (productManagementWatch.updatingProductAttributeIndex == productManagementWatch.productDetailState.success?.data?.productAttributes?.indexWhere((attribute) => attribute.uuid == productAttribute?.uuid)))
                          LoadingAnimationWidget.waveDots(color: AppColors.black, size: 22.h).alignAtCenterLeft().paddingOnly(left: 5.w)
                        else
                          Align(
                            alignment: Alignment.centerLeft,
                            child: CommonCupertinoSwitch(
                              switchValue: attributeName?.isAvailable ?? false,
                              onChanged: (val) async {
                                await productManagementWatch.updateProductAttributeNameStatusApi(context, attributeUuid: productAttribute?.uuid ?? '', attributeNameUuid: attributeName?.uuid ?? '', active: val, productUuid: productManagementWatch.productDetailState.success?.data?.uuid??'',isWeb:true);
                              },
                            ),
                          ),
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 10.h,
                    );
                  },
                ),
              ),
            ],
          ).paddingOnly(right: 10.w, top: 5.h, bottom: 5.h),
        );
      },
    );
  }
}
