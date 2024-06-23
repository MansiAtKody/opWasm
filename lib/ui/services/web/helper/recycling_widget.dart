import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/services/recycling_controller.dart';
import 'package:kody_operator/framework/repository/service/department_model.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/services/web/helper/department_list_tile.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/helpers/custom_mouse_region.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_appbar_web.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_form_field.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/common_top_back_widget.dart';

class RecyclingWidget extends StatefulWidget {
  const RecyclingWidget({super.key});

  @override
  State<RecyclingWidget> createState() => _RecyclingWidgetState();
}

class _RecyclingWidgetState extends State<RecyclingWidget> with BaseStatefulWidget, TickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  Future<void> _runExpandCheck(bool isExpand) async {
    if (isExpand) {
      await expandController.forward();
    } else {
      await expandController.reverse();
    }
  }

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final recyclingWatch = ref.watch(recyclingController);
        return GestureDetector(
          onTap: () {
            _runExpandCheck(false).then(
              (value) {
                recyclingWatch.showAndHideDepartmentList();
              },
            );
          },
          child: Column(
            children: [
              /// App Bar Top Widget
              const CommonAppBarWeb(),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// Location container
                    Expanded(
                      child: FadeBoxTransition(
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: AppColors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              /// Text Recycling
                              CommonBackTopWidget(
                                showBackButton: false,
                                title: LocalizationStrings.keyRecycling.localized,
                              ).paddingOnly(bottom: 30.h),

                              /// Text Select Location
                              CommonText(
                                title: LocalizationStrings.keySelectLocation.localized,
                                textStyle: TextStyles.regular.copyWith(fontSize: 20.sp, color: AppColors.clr171717),
                              ).paddingOnly(bottom: 20.h),

                              /// Department Field
                              Form(
                                key: recyclingWatch.formKey,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomMouseRegion(
                                    child: CommonInputFormField(
                                      onTap: () {
                                        if (recyclingWatch.isDepartmentListVisible == false) {
                                          recyclingWatch.showAndHideDepartmentList();
                                          _runExpandCheck(true);
                                        } else {
                                          _runExpandCheck(false).then(
                                            (value) {
                                              recyclingWatch.showAndHideDepartmentList();
                                            },
                                          );
                                        }
                                      },
                                      readOnly: true,
                                      suffixWidget: CustomMouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: CommonSVG(strIcon: recyclingWatch.isDepartmentListVisible ? AppAssets.svgDropDown : AppAssets.svgDropDown).paddingAll(2.r),
                                      ),
                                      backgroundColor: AppColors.transparent,
                                      textEditingController: recyclingWatch.departmentNameController,
                                      textInputType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      onFieldSubmitted: (value) {
                                        hideKeyboard(context);
                                      },
                                      validator: (value) {
                                        return validateText(value, LocalizationStrings.keyDepartmentMustBeRequired.localized);
                                      },
                                      labelText: LocalizationStrings.keyDepartment.localized,
                                    ).paddingOnly(right: context.width / 2),
                                  ),
                                ),
                              ),

                              /// department list dropdown widget
                              recyclingWatch.isDepartmentListVisible
                                  ? SizeTransition(
                                      axisAlignment: 1.0,
                                      sizeFactor: animation,
                                      child: Container(
                                        height: MediaQuery.sizeOf(context).height * 0.4,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20.r),
                                          color: AppColors.whiteF7F7FC,
                                        ),
                                        child: ListView.separated(
                                          shrinkWrap: true,
                                          itemCount: recyclingWatch.departmentList.length,
                                          itemBuilder: (context, index) {
                                            DepartmentModel model = recyclingWatch.departmentList[index];
                                            return InkWell(
                                                    onTap: () {
                                                      recyclingWatch.updateSelectedDepartment(index);
                                                      _runExpandCheck(false).then(
                                                        (value) {
                                                          recyclingWatch.showAndHideDepartmentList();
                                                        },
                                                      );
                                                    },
                                                    child: DepartmentListTile(index: index, departmentModel: model))
                                                .paddingSymmetric(horizontal: 20.w);
                                          },
                                          separatorBuilder: (BuildContext context, int index) {
                                            return SizedBox(
                                              height: 20.h,
                                            );
                                          },
                                        ).paddingSymmetric(vertical: 28.h),
                                      ).paddingOnly(right: context.width / 2),
                                    )
                                  : const Offstage(),

                              /// Submit Button
                              !(recyclingWatch.isDepartmentListVisible)
                                  ? CommonButton(
                                      width: MediaQuery.sizeOf(context).width * 0.1,
                                      height: MediaQuery.sizeOf(context).height * 0.090,
                                      onTap: () {
                                        showRequestSendDialogWeb(
                                          context: context,
                                          onButtonTap: () {
                                            ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.services());
                                          },
                                        );
                                      },
                                      buttonTextStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: recyclingWatch.departmentNameController.text.isNotEmpty ? AppColors.white : AppColors.clr616161),
                                      buttonText: LocalizationStrings.keySubmit.localized,
                                      isButtonEnabled: recyclingWatch.departmentNameController.text.isNotEmpty,
                                    ).paddingOnly(top: 21.h)
                                  : const Offstage(),
                            ],
                          ).paddingOnly(left: 45.w, top: 45.h),
                        ),
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 26.w, vertical: 8.h),
              ),
            ],
          ),
        );
      },
    );
  }
}
