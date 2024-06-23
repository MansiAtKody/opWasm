import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/auth/forgot_reset_password_controller.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';

class CommonBackGroundContainer extends ConsumerWidget with BaseConsumerWidget{
  final FromScreen? fromScreen;
  final Widget child;

   const CommonBackGroundContainer({super.key,required this.child,this.fromScreen});

  @override
  Widget buildPage(BuildContext context,WidgetRef ref) {
    return Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.icAuthBg), fit: BoxFit.cover)),
        child:
        Column(
          children: [
            /// For adding space from top
            const Expanded(flex: 1, child: SizedBox()),
            Expanded(
              flex: 8,
              child: Row(
                children: [
                  Expanded(
                    flex: 9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Expanded(child: SizedBox()),

                        /// Common Container
                        Expanded(
                          child: FadeBoxTransition(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  color: Colors.white),
                              child:  Row(
                                children: [
                                  const Spacer(),
                                  Expanded(
                                    flex: 9,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        /// Adding the space inside the container from top
                                         Expanded(
                                            flex: 2,
                                            child: Visibility(
                                            visible:!(fromScreen == FromScreen.login),
                                              child: InkWell(
                                                onTap: (){
                                                  if(fromScreen ==FromScreen.resetPassword)
                                                    {
                                                      final forgotResetPasswordWatch = ref.watch(forgotResetPasswordController);
                                                      forgotResetPasswordWatch.disposeController(isNotify: true);
                                                      ref.read(navigationStackProvider).pushRemove(const NavigationStackItem.forgotResetPassword(isForgotPassword: true));
                                                    }
                                                  else
                                                    {
                                                      ref.read(navigationStackProvider).pop();
                                                    }
                                                },
                                                  child: const CommonSVG(strIcon:AppAssets.svgBackIcon),
                                              ),
                                            )),

                                        /// The content
                                        Expanded(
                                            flex: 10,
                                            child:child
                                        ),

                                        /// Adding the space from bottom inside the container
                                        const Expanded(flex: 2, child: SizedBox()),
                                      ],
                                    ),
                                  ),
                                  const Spacer()
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Add the from right side
                  const Expanded(flex: 1, child: SizedBox())
                ],
              ),
            ),
            /// For adding space from bottom
            const Expanded(flex: 1, child: SizedBox()),
          ],
        ));
  }
}
