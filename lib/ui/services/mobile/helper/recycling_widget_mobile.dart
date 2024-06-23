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
import 'package:kody_operator/ui/services/mobile/helper/department_list_tile_mobile.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_button_mobile.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_form_field.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';

class RecyclingWidgetMobile extends StatefulWidget {
  const RecyclingWidgetMobile({super.key});

  @override
  State<RecyclingWidgetMobile> createState() => _RecyclingWidgetMobileState();
}

class _RecyclingWidgetMobileState extends State<RecyclingWidgetMobile> with SingleTickerProviderStateMixin, BaseStatefulWidget {
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
          onTap: (){
            _runExpandCheck(false).then(
                  (value) {
                recyclingWatch.showAndHideDepartmentList();
              },
            );
          },
          child: CommonWhiteBackground(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            backgroundColor: AppColors.buttonDisabledColor,
            height: context.height,
            child: Container(
              decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r))),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Department Field
                      Form(
                        key: recyclingWatch.formKey,
                        child: CommonInputFormField(
                          onTap: () {
                            if (recyclingWatch.isDepartmentListVisible == false) {
                              recyclingWatch.showAndHideDepartmentList();
                              recyclingWatch.updateSuffix();
                              _runExpandCheck(true);
                            } else {
                              _runExpandCheck(false).then(
                                    (value) {
                                  recyclingWatch.showAndHideDepartmentList();
                                  recyclingWatch.updateSuffix();
                                },
                              );
                            }
                          },
                          readOnly: true,
                          suffixWidget: recyclingWatch.isSuffixUp ? RotatedBox(quarterTurns: 6, child: const CommonSVG(strIcon: AppAssets.svgDropDown).paddingAll(8.h)) : const CommonSVG(strIcon: AppAssets.svgDropDown).paddingAll(8.h),
                          backgroundColor: AppColors.transparent,
                          hintText: LocalizationStrings.keySelectLocation.localized,
                          textEditingController: recyclingWatch.departmentNameController,
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (value) {
                            hideKeyboard(context);
                          },
                          validator: (value) {
                            return validateText(value, LocalizationStrings.keyDepartmentMustBeRequired.localized);
                          },
                          labelText: LocalizationStrings.keySelectLocation.localized,
                        ),
                      ),

                      /// department list dropdown widget
                      recyclingWatch.isDepartmentListVisible
                          ? SizeTransition(
                              axisAlignment: 1.0,
                              sizeFactor: animation,
                              child: Container(
                                constraints: BoxConstraints(maxHeight: context.height * 0.6),
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
                                          recyclingWatch.updateSuffix();
                                          _runExpandCheck(false).then(
                                                (value) {
                                              recyclingWatch.showAndHideDepartmentList();
                                            },
                                          );
                                        },
                                        child: DepartmentListTileMobile(index: index, departmentModel: model));
                                  },
                                  separatorBuilder: (BuildContext context, int index) {
                                    return const Divider().paddingSymmetric(horizontal: 15.w);
                                  },
                                ),
                              ).paddingOnly(top: 15.h),
                            )
                          : const Offstage(),
                      SizedBox(height: MediaQuery.sizeOf(context).height * 0.085),
                    ],
                  ).paddingOnly(left: 15.w, right: 15.w, top: 37.h),

                  /// Submit Button
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: CommonButtonMobile(
                      rightIcon: Icon(
                        Icons.arrow_forward,
                        color: recyclingWatch.departmentNameController.text.isNotEmpty ? AppColors.white : AppColors.textFieldLabelColor,
                      ),
                      height: MediaQuery.sizeOf(context).height * 0.080,
                      onTap: () {
                        if (recyclingWatch.formKey.currentState!.validate()) {
                          showCommonSuccessDialogMobile(
                              context: context,
                              anim: AppAssets.animRecycleService,
                              onButtonTap: () {
                                ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.services());
                              });
                        }
                      },
                      buttonTextStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: recyclingWatch.departmentNameController.text.isNotEmpty ? AppColors.white : AppColors.clr616161),
                      buttonText: LocalizationStrings.keySubmit.localized,
                      isButtonEnabled: recyclingWatch.departmentNameController.text.isNotEmpty,
                    ).paddingSymmetric(vertical: 20.h, horizontal: 10.w),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
