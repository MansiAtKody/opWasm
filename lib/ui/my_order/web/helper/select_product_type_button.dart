import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/repository/order/model/response/category_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/anim/list_bounce_animation.dart';
import 'package:kody_operator/ui/utils/anim/slide_up_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class SelectProductTypeButton extends StatelessWidget with BaseStatelessWidget {
  const SelectProductTypeButton({
    this.isSelected = false,
    this.svgAsset,
    required this.title,
    this.onTap,
    this.productType,
    super.key,
  });

  final bool isSelected;
  final String? svgAsset;
  final String title;
  final CategoryData? productType;
  final GestureTapCallback? onTap;

  @override
  Widget buildPage(BuildContext context) {
    return SlideUpTransition(
      delay: 100,
      child: ListBounceAnimation(
        onTap: onTap ?? () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isSelected ? 25.r : 31.r),
            border: isSelected ? null : Border.all(color: AppColors.greyD6D6D6,width: 1),
            color: isSelected ? AppColors.black : AppColors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              svgAsset != null ? CommonSVG(
                strIcon: svgAsset ?? AppAssets.svgAllLogo,
                svgColor: isSelected ? AppColors.white : AppColors.clr8F8F8F,
              ) : const Offstage(),
              Container(
                constraints: BoxConstraints(maxWidth: context.width * 0.3),
                child: CommonText(
                  title: title,
                  maxLines: 3,
                  textStyle: TextStyles.regular.copyWith(
                    color: isSelected ? AppColors.white : AppColors.clr8F8F8F,
                    fontSize: 16.sp,
                  ),
                ).paddingOnly(left: 8.w),
              ),
            ],
          ).paddingSymmetric(horizontal: 15.w, vertical: 15.h),
        ),
      ),
    );
  }
}
