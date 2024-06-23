import 'dart:ui';

import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';



void showCommonModalBottomSheet({
  required BuildContext context,
  EdgeInsetsGeometry? bottomSheetPadding,
  Widget? child,
  Function()? onTap,
}) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                color: AppColors.transparent,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: onTap ??
                                  () {
                                Navigator.pop(context);
                              },
                          child: CommonSVG(
                            strIcon: AppAssets.svgCrossWithBg,
                            height: 44.h,
                            width: 44.h,
                          )),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.whiteF7F7FC,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.r),
                              topRight: Radius.circular(20.r),
                            )),
                        child: child ?? const Offstage(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      });
}
