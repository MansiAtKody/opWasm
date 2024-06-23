import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_tray/order_customization_controller.dart';
import 'package:kody_operator/framework/repository/order/model/response/product_detail_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class CustomizationWidget extends ConsumerWidget with BaseConsumerWidget {
  const CustomizationWidget({
    this.customizationItems,
    required this.title,
    required this.isMandatory,
    this.onTap,
    super.key,
  });

  final List<ProductAttributeName>? customizationItems;
  final String title;
  final bool isMandatory;
  final void Function(int attributeNameIndex)? onTap;

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final orderCustomizationWatch = ref.watch(orderCustomizationController);
    return FadeBoxTransition(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: title,
                  style: TextStyles.medium.copyWith(
                    fontSize: 18.sp,
                    color: AppColors.black272727,
                  )),
              TextSpan(
                  text: isMandatory ? ' *' : '',
                  style: TextStyles.medium.copyWith(
                    fontSize: 18.sp,
                    color: AppColors.redE80202,
                  ))
            ])).paddingOnly(left: 30.w, top: 30.h, bottom: 20.h),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: customizationItems?.length ?? 0,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: context.height * 0.15,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        if (onTap != null) {
                          onTap!(index);
                        }
                      },
                      child: Container(
                        width: 60.h,
                        height: 60.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: customizationItems?[index].attributeNameUuid ==
                              (orderCustomizationWatch.selectedAttributeList.where((element) => element.attributeNameUuid == customizationItems?[index].attributeNameUuid)).firstOrNull?.attributeNameUuid
                              ? AppColors.blue009AF1
                              : AppColors.lightPinkF7F7FC,
                        ),
                        child: customizationItems?[index].attributeNameImage != null
                            ? ClipRRect(
                            borderRadius: BorderRadius.circular(100.r),
                            child: CacheImage(
                              imageURL: customizationItems?[index].attributeNameImage ?? '',
                              height: 20.h,
                              width: 20.w,
                            )).paddingSymmetric(horizontal: 14.w, vertical: 14.h)
                            : const CommonSVG(
                          strIcon: '',
                          svgColor: AppColors.grey7E7E7E,
                        ).paddingSymmetric(horizontal: 14.w, vertical: 14.h),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    SizedBox(
                      width: 60.w,
                      height: 40.h,
                      child: CommonText(
                        title: customizationItems?[index].attributeNameName ?? '',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        textStyle: TextStyles.regular.copyWith(
                          fontSize: 16.sp,
                          color: customizationItems?[index].attributeNameUuid ==
                              (orderCustomizationWatch.selectedAttributeList.where((element) => element.attributeNameUuid == customizationItems?[index].attributeNameUuid)).firstOrNull?.attributeNameUuid
                              ? AppColors.black
                              : AppColors.grey7E7E7E,
                        ),
                      ),
                    ),
                  ],
                ).paddingOnly(right: 30.w);
              },
            ),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }
}
