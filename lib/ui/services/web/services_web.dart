import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/services/services_controller.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/anim/slide_horizontal_transaction.dart';
import 'package:kody_operator/ui/utils/helpers/base_page_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_appbar_web.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class ServicesWeb extends ConsumerStatefulWidget {
  const ServicesWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<ServicesWeb> createState() => _ServicesWebState();
}

class _ServicesWebState extends ConsumerState<ServicesWeb> with BaseConsumerStatefulWidget, BaseDrawerPageWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // final servicesWatch = ref.watch(servicesController);
      //servicesWatch.disposeController(isNotify : true);
    });
  }

  ///Dispose Override
  @override
  void dispose() {
    super.dispose();
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return _bodyWidget();
  }

  ///Body Widget
  Widget _bodyWidget() {
    final servicesWatch = ref.watch(servicesController);
    return Column(
      children: [
        /// App Bar Top Widget
        const CommonAppBarWeb(),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Gridview and white container
              Expanded(
                child: FadeBoxTransition(
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: AppColors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                          title: LocalizationStrings.keyServiceManagement.localized,
                          textStyle: TextStyles.regular.copyWith(color: AppColors.clr171717, fontSize: 24.sp),
                        ).paddingOnly(left: 39.w, top: 45.h),

                        SizedBox(height: context.height * 0.03),
                        /// Gridview builder
                        GridView.builder(
                          itemCount: servicesWatch.availableServices.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 30.w,
                            mainAxisSpacing: 30.h,
                            childAspectRatio: 9,
                            mainAxisExtent: 60.h,
                          ),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return SlideHorizontalTransition(
                              isRightSlide: index % 2 == 0,
                              child: InkWell(
                                onTap: () {
                                  ref.read(navigationStackProvider).push(servicesWatch.availableServices[index].stackItem);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 14.w),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: AppColors.clrF7F7FC),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    // mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        // mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CommonSVG(strIcon: servicesWatch.availableServices.elementAt(index).iconName),
                                          SizedBox(
                                            width: 16.w,
                                          ),
                                          CommonText(
                                            title: servicesWatch.availableServices.elementAt(index).title,
                                            textStyle: TextStyles.regular.copyWith(color: AppColors.clr171717, fontSize: 16.sp),
                                          )
                                        ],
                                      ),
                                      const Icon(Icons.arrow_forward_ios),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ).paddingSymmetric(horizontal: 20.w, vertical: 30.h),
                        Expanded(
                          child: Image.asset(
                            AppAssets.icServiceManagementBg,
                            fit: BoxFit.contain,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ).paddingOnly(top: 38.h, left: 38.w, right: 38.w),
        ),
      ],
    );
  }
}
/*class ServicesWeb extends ConsumerWidget {
  const ServicesWeb({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Container(
      color: Colors.red,
      height: 100.h,
      width: 100.w,
    );
  }
}*/
