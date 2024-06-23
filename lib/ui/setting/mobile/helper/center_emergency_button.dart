import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/anim/slide_up_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class CenterEmergencyButton extends StatelessWidget with BaseStatelessWidget{
  const CenterEmergencyButton({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return

      ///Emergency stop button
      InkWell(
        onTap: () {},
        child: SlideUpTransition(
          delay: 300,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: 246.h,
              width: 246.w,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.redF2a5a6,
                      AppColors.white,
                    ],
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonSVG(
                    strIcon: AppAssets.svgPower,
                    height: 86.h,
                    width: 96.w,
                    svgColor: AppColors.black,
                  ).paddingOnly(bottom: 25.h),
                  CommonText(
                    title: LocalizationStrings.keyEmergencyStop.localized,
                    textStyle: TextStyles.regular.copyWith(
                      color: AppColors.black171717,
                      fontSize: 23.sp,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ).paddingSymmetric(horizontal: 50.w)
                ],
              ),
            ),
          ),
        ),
      );
  }
}
