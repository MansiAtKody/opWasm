import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/scheduler.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class TopWidget extends ConsumerStatefulWidget {
  final String strTitle;
  final FromScreen fromScreen;
  TopWidget({Key? key, required this.strTitle, required this.fromScreen})
      : super(key: key);

  @override
  ConsumerState<TopWidget> createState() => _LoginMobileState();
}

class _LoginMobileState extends ConsumerState<TopWidget> {
  ///Init
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // final loginWatch = ref.watch(loginController);
      //loginWatch.disposeController(isNotify : true);
    });
  }

  ///Dispose
  @override
  void dispose() {
    super.dispose();
  }

  ///Build
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AppAssets.authTopImage,
          height: 0.5.sh,
          width: double.maxFinite,
          fit: BoxFit.fitWidth,
        ),
        Column(
          children: [
            CommonAppBar(
              backgroundColor: AppColors.transparent,
              isLeadingEnable:
                  widget.fromScreen == FromScreen.login ? false : true,
              onLeadingPress: () {
                if (widget.fromScreen == FromScreen.resetPassword) {
                  ref.read(navigationStackProvider).pushRemove(
                      const NavigationStackItem.forgotResetPassword(
                          isForgotPassword: true));
                }else if(widget.fromScreen == FromScreen.forgotPassword){
                  ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.login());
                } else {
                  ref.read(navigationStackProvider).pop();
                }
              },
              leftImage: const CommonSVG(
                strIcon: AppAssets.svgLeftArrrow,
                svgColor: AppColors.white,
              ),
              title: widget.strTitle,
              titleWidget: CommonText(
                title: widget.strTitle,
                textStyle: TextStyles.medium
                    .copyWith(fontSize: 20.sp, color: AppColors.white),
              ),
            ),
          ],
        )
      ],
    );
  }
}
