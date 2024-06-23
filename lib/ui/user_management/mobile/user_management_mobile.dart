import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/user_management/user_management_controller.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/user_management/mobile/helper/add_edit_sub_operator_dialog.dart';
import 'package:kody_operator/ui/user_management/mobile/helper/common_user_list_tile.dart';
import 'package:kody_operator/ui/user_management/mobile/helper/detail_dialog_widget.dart';
import 'package:kody_operator/ui/user_management/mobile/helper/shimmer_user_management_mobile.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_drawer_mobile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/helpers/common_dialog_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_button_mobile.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';

class UserManagementMobile extends ConsumerStatefulWidget {
  const UserManagementMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<UserManagementMobile> createState() => _UserManagementMobileState();
}

class _UserManagementMobileState extends ConsumerState<UserManagementMobile>
    with BaseConsumerStatefulWidget, BaseDrawerPageWidgetMobile {
  ScrollController userListScrollController = ScrollController();

  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final userManagementWatch = ref.read(userManagementController);
      userManagementWatch.disposeController(isNotify: true);
      userManagementWatch.subOperatorListApi(context,pageNumber: 1,isWeb: false);

      userListScrollController.addListener(() {
        if (userManagementWatch.subOperatorState.success?.hasNextPage??false) {
          if (userListScrollController.position.maxScrollExtent ==
              userListScrollController.position.pixels) {
            if (userManagementWatch.subOperatorState.success?.pageNumber != userManagementWatch.subOperatorState.success?.totalPages) {
              userManagementWatch.subOperatorListApi(context,isWeb: false);

            }
          }
        }
      });
    });
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
        body: _bodyWidget());
  }

  /// body Widget
  Widget _bodyWidget() {
    final userManagementWatch = ref.watch(userManagementController);
    return CommonWhiteBackground(
        appBar: CommonAppBar(
          title: LocalizationStrings.keyUserManagement.localized,
          isDrawerEnable: true,
        ),
        child: userManagementWatch.subOperatorState.isLoading
            ? const ShimmerUserManagementMobile()
            : Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final userManagementWatch = ref.watch(userManagementController);
            return FadeBoxTransition(
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              controller: userListScrollController,
                              itemCount: userManagementWatch.subOperatorList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    ///Details Dialog
                                    showCommonMobileDialog(
                                        context: context,
                                        dialogBody: DetailDialogWidget(
                                            subOperatorData: userManagementWatch.subOperatorList[index],
                                            onSwitchTap: (bool value) {
                                          userManagementWatch.activateDeactivateSubOperatorApi(context, (userManagementWatch.subOperatorState.success?.data?[index].uuid ?? ''), value);
                                        }, index: index,
                                            /*onSwitchTap: (bool value) {
                                              userManagementWatch.updateStatus(index);
                                            }*/).paddingLTRB(20.w, 20.h, 20.w, 16.h));
                                  },
                                  child: CommonUserListTile(
                                      subOperatorData: userManagementWatch.subOperatorList[index],
                                      index: index,
                                      onSwitchTap: (bool value) {
                                        userManagementWatch.activateDeactivateSubOperatorApi(context, (userManagementWatch.subOperatorState.success?.data?[index].uuid ?? ''), value);
                                      }).paddingOnly(bottom: 15.h),
                                );
                              }).paddingOnly(top: 20.h, left: 20.w, right: 20.w),
                        ),
                        Visibility(
                            visible: userManagementWatch.subOperatorState.isLoadMore,
                            child: const CircularProgressIndicator(color: AppColors.black,).paddingSymmetric(vertical: 20.h))
                      ],
                    ),
                  ),
                  CommonButtonMobile(
                    buttonText: LocalizationStrings.keyAddSubOperator.localized,
                    rightIcon: CommonSVG(
                      strIcon: AppAssets.svgRight,
                      height: 14.h,
                      width: 14.w,
                    ),
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CommonDialogWidget(
                              child: SizedBox(
                                  height: context.height*0.6,
                                  child: const AddEditSubOperatorDialog())
                          );
                        },
                      );
                    },
                  ).paddingAll(20.w),
                ],
              ),
            );
          },
        ));
  }
}
