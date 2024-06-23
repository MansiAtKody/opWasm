import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/profile/language_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';

///Change Language Tiles
class ChangeLanguageRadioTile extends StatelessWidget with BaseStatelessWidget {
  const ChangeLanguageRadioTile({
    super.key,
    required this.groupValue,
    required this.value,
    required this.onTap,
    this.textStyle,
  });

  final LanguageModel? groupValue;
  final LanguageModel value;
  final TextStyle? textStyle;
  final GestureTapCallback? onTap;

  @override
  Widget buildPage(BuildContext context) {
    return Container(
      height: 76.h,
      width: double.infinity,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white,
      ),
      child: InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const CommonSVG(strIcon: AppAssets.svgChangeLanguageIcon).paddingSymmetric(
                      horizontal: 15.w,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          value.localName,
                          style: textStyle ??
                              TextStyles.regular.copyWith(
                                color: AppColors.black,
                              ),
                        ),
                        Text(
                          value.name,
                          style: textStyle ??
                              TextStyles.regular.copyWith(
                                color: AppColors.black,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              CommonSVG(
                strIcon: value == groupValue ? AppAssets.svgRadioSelected : AppAssets.svgRadioUnselected,
              ).paddingOnly(top: 31.h, bottom: 31.h, right: 31.w),
            ],
          )),
    );
  }
}
