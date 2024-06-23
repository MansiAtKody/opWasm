import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/order_management/select_coffee_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_page_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_button_coffee_selection.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/dialog_progressbar.dart';
import 'package:kody_operator/ui/widgets/show_common_error_dialog.dart';

class SelectCoffeeScreen extends ConsumerStatefulWidget {
  const SelectCoffeeScreen({super.key});

  @override
  ConsumerState<SelectCoffeeScreen> createState() => _SelectCoffeeScreenState();
}

class _SelectCoffeeScreenState extends ConsumerState<SelectCoffeeScreen> with BaseDrawerPageWidget {
  /// Init State
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final selectedCoffeeWatch = ref.watch(selectCoffeeController);
      selectedCoffeeWatch.disposeController(isNotify: true);
    });
  }

  /// Main Build
  @override
  Widget buildPage(BuildContext context) {
    final selectedCoffeeWatch = ref.watch(selectCoffeeController);
    return Stack(
      children: [
        Scaffold(
          body: bodyWidget(),
        ),
        DialogProgressBar(isLoading: selectedCoffeeWatch.selectCoffeeState.isLoading)
      ],
    );
  }

  /// Widget body
  Widget bodyWidget() {
    final selectedCoffeeWatch = ref.watch(selectCoffeeController);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Coffee Widget
                Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            CommonText(
                              title: 'Coffee',
                              textStyle: TextStyles.semiBold.copyWith(color: AppColors.primary, fontSize: 20.sp),
                            ).paddingOnly(left: 20.w, top: 20.h, right: 20.w, bottom: 20.h),
                            Wrap(
                              children: [
                                ...List.generate(selectedCoffeeWatch.coffeeList.length, (index) {
                                  return buttonWidget(
                                          title: selectedCoffeeWatch.coffeeList[index].name,
                                          onTap: () {
                                            selectedCoffeeWatch.updateSelectedCoffee(index);
                                          },
                                          isSelected: selectedCoffeeWatch.selectedCoffeeIndex == index)
                                      .paddingAll(10.h);
                                })
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 60.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonButtonCoffeeSelection(
                              backgroundColor: AppColors.white,
                              buttonText: 'Select',
                              buttonTextColor: AppColors.black,
                              isLoading: selectedCoffeeWatch.selectCoffeeState.isLoading,
                              onTap: () async {
                                if (selectedCoffeeWatch.selectedCoffeeIndex != null) {
                                  await selectedCoffeeWatch.selectProgramAPI(context);
                                } else {
                                  showCommonErrorDialog(context: context, message: 'Please select coffee first');
                                }
                              },
                            ).paddingOnly(left: 20.w, top: 20.h, right: 20.w, bottom: 40.h),
                            CommonButtonCoffeeSelection(
                              buttonText: 'Start',
                              buttonTextColor: AppColors.white,
                              isButtonEnabled: true,
                              isLoading: selectedCoffeeWatch.activeCoffeeState.isLoading,
                              onTap: () async {
                                if (selectedCoffeeWatch.selectCoffeeState.success?.status == ApiEndPoints.apiStatus_200) {
                                  await selectedCoffeeWatch.activeProgramAPI(context);
                                } else {
                                  showCommonErrorDialog(context: context, message: 'Please select coffee first');
                                }
                              },
                            ).paddingOnly(left: 20.w, top: 20.h, right: 20.w, bottom: 40.h),
                          ],
                        ),
                      ],
                    )),

                /// Hand Widget
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CommonText(
                        title: 'Hand',
                        textStyle: TextStyles.semiBold.copyWith(color: AppColors.primary, fontSize: 20.sp),
                      ).paddingOnly(left: 20.w, top: 20.h, right: 20.w, bottom: 20.h).alignAtTopCenter(),
                      Column(
                        children: [
                          /// Glass
                          buttonWidget(
                            title: 'Glass',
                            onTap: () async {
                              selectedCoffeeWatch.updateGlassSelection(true);
                              await selectedCoffeeWatch.startProgramAPI(context);
                            },
                            isLoading: selectedCoffeeWatch.startProgramState.isLoading,
                            isSelected: selectedCoffeeWatch.isGlassSelected,
                          ).paddingOnly(top: 20.h),

                          /// Dasher
                          buttonWidget(
                            title: 'Dasher',
                            isLoading: selectedCoffeeWatch.stopProgramState.isLoading,
                            onTap: () async {
                              await selectedCoffeeWatch.startDasherAPI(context);
                            },
                            isSelected: selectedCoffeeWatch.isDasherSelected,
                          ).paddingOnly(top: 20.h),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// button widget
  Widget buttonWidget({required String title, required Function() onTap, required bool isSelected, bool? isLoading}) {
    return CommonButton(
      isButtonEnabled: true,
      buttonText: title,
      isLoading: isLoading ?? false,
      buttonTextColor: isSelected ? AppColors.black : AppColors.white,
      backgroundColor: isSelected ? AppColors.black : AppColors.white,
      onTap: () {
        onTap();
      },
    );
  }
}
