import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class HomeLeftOptionsWidget extends ConsumerWidget with BaseConsumerWidget{
  final String strIcon;
  final String title;
  final GestureTapCallback? onTap;
  const HomeLeftOptionsWidget({super.key, required this.strIcon, required this.title, required this.onTap});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: 236.w,
          height: 236.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(36.r),
              color: AppColors.blackFFFFFF),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonSVG(strIcon: strIcon, svgColor: AppColors.white.withOpacity(0.5)),
            SizedBox(height: 25.h),
            CommonText(
              title: title,
              textStyle: TextStyles.regular.copyWith(fontSize: 25.sp, color: AppColors.white.withOpacity(0.5)),
            )
          ],
        ),
      ),
    );
  }
}
