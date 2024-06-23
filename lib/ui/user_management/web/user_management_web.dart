import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/user_management/user_management_controller.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/user_management/web/helper/common_show_detail_row.dart';
import 'package:kody_operator/ui/user_management/web/helper/icon_widget.dart';
import 'package:kody_operator/ui/user_management/web/helper/shimmer_user_management_web.dart';
import 'package:kody_operator/ui/user_management/web/helper/table_child_text_widget.dart';
import 'package:kody_operator/ui/user_management/web/helper/table_header_text_widget.dart';
import 'package:kody_operator/ui/utils/anim/slide_up_transition.dart';
import 'package:kody_operator/ui/utils/anim/slide_vertical_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_page_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_cupertino_switch.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/empty_state_widget.dart';
import 'package:kody_operator/ui/widgets/pagination_bottom_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UserManagementWeb extends ConsumerStatefulWidget {
  const UserManagementWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<UserManagementWeb> createState() => _UserManagementWebState();
}

class _UserManagementWebState extends ConsumerState<UserManagementWeb>
    with BaseConsumerStatefulWidget, BaseDrawerPageWidget {
  ScrollController userListScrollController = ScrollController();
  bool isSlideUp = true;

  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final userManagementWatch = ref.read(userManagementController);
        userManagementWatch.disposeController(isNotify: true);
        userManagementWatch.subOperatorListApi(context,pageNumber: 1,isWeb: true);
      },
    );
  }

  ///Dispose Override
  @override
  void dispose() {
    super.dispose();
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    final userManagementWatch = ref.watch(userManagementController);
    if (userManagementWatch.subOperatorState.isLoading) {
      return const ShimmerUserManagementWeb();
    } else {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// App Bar Top Widget
            // const CommonAppBarWeb(),
            SizedBox(height: 20.h,),
            ///Page Body Widget
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Page Title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                          title: LocalizationStrings.keyUserManagement.localized,
                          textStyle: TextStyles.regular.copyWith(
                            fontSize: 24.sp,
                            color: AppColors.black171717,
                          ),
                        ),
                        ///Add Sub Operator Button
                        InkWell(
                          onTap: (){
                            ref.read(navigationStackProvider).push(const NavigationStackItem.addSubOperator());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.primary2,
                                borderRadius: BorderRadius.circular(40.r)
                            ),
                            child: Row(
                              children: [
                                CommonSVG(
                                  strIcon: AppAssets.svgAddIcon,
                                  svgColor: AppColors.white,
                                  height: 14.h,
                                  width: 14.w,
                                ).paddingOnly(right: 10.w),
                                CommonText(
                                  title: LocalizationStrings.keyAddSubOperator.localized,
                                  textStyle: TextStyles.regular.copyWith(
                                      color: AppColors.white,
                                      fontSize: 12.sp
                                  ),
                                )
                              ],
                            ).paddingSymmetric(horizontal: 17.w,vertical: 15.h),
                          ),
                        ),
                      ],
                    ).paddingOnly(left: 36.w, right: 36.w, top: 20.h),

                    ///Titles of User List
                    Expanded(
                      child: userManagementWatch.subOperatorState.success?.data?.isEmpty??false
                          ?const EmptyStateWidget():
                      Column(
                        children: [
                          Table(
                            textDirection: TextDirection.ltr,
                            columnWidths: {
                              0: FlexColumnWidth(2.5.w), /// status
                              1: FlexColumnWidth(4.w), /// operator name
                              2: FlexColumnWidth(4.w), /// email id
                              3: FlexColumnWidth(20.w), /// phone number
                              4:FlexColumnWidth(2.w),/// edit
                              5: FlexColumnWidth(2.5.w), /// details arrow
                            },
                            children: [
                              TableRow(children: [
                                TableHeaderTextWidget(text: LocalizationStrings.keyStatus.localized).paddingOnly(left: 10.w),
                                TableHeaderTextWidget(text: LocalizationStrings.keyOperatorName.localized),
                                TableHeaderTextWidget(text: LocalizationStrings.keyEmailId.localized),
                                TableHeaderTextWidget(text: LocalizationStrings.keyPhoneNumber.localized),
                                TableHeaderTextWidget(text:LocalizationStrings.keyEdit.localized,textAlign: TextAlign.right,),
                                Container()
                              ]),
                            ],
                          ).paddingSymmetric(horizontal: 50.w).paddingOnly(top: 20.h,bottom: 10.h),
                          Expanded(
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: userManagementWatch.subOperatorState.success?.data?.length??0,
                              controller: userListScrollController,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context,index){
                                return SlideVerticalTransition(
                                  isUpSlide: userListScrollController.position.userScrollDirection == ScrollDirection.reverse,
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.r)), color: AppColors.lightPink),
                                    child: Table(
                                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                      textDirection: TextDirection.ltr,
                                      columnWidths: {
                                        0: FlexColumnWidth(2.5.w), /// status
                                        1: FlexColumnWidth(4.w), /// operator name
                                        2: FlexColumnWidth(4.w), /// email id
                                        3: FlexColumnWidth(20.w), /// phone number
                                        4:FlexColumnWidth(2.w), /// edit
                                        5: FlexColumnWidth(2.w), /// edit arrow
                                      },
                                      children: [
                                        ///Active Or Deactive
                                        TableRow(children: [
                                          ///Status
                                          if (userManagementWatch.activateDeactivateSubOperatorState.isLoading && userManagementWatch.updatingSubOperatorIndex == index)
                                            LoadingAnimationWidget.waveDots(color: AppColors.black, size: 22.h).alignAtCenterLeft().paddingOnly(left: 5.w)
                                          else
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: CommonCupertinoSwitch(
                                                switchValue: userManagementWatch.subOperatorState.success?.data?[index].active??false,
                                                onChanged: (val) {
                                                  userManagementWatch.activateDeactivateSubOperatorApi(context, (userManagementWatch.subOperatorState.success?.data?[index].uuid ?? ''), val);
                                                },
                                              ),
                                            ),
                                          ///Name
                                          TableChildTextWidget(text: userManagementWatch.subOperatorState.success?.data?[index].name??''),

                                          ///Email
                                          TableChildTextWidget(text: userManagementWatch.subOperatorState.success?.data?[index].email??''),

                                          ///Phone
                                          TableChildTextWidget(text: userManagementWatch.subOperatorState.success?.data?[index].contactNumber??''),


                                          ///Edit Icon
                                          Visibility(
                                            visible: userManagementWatch.subOperatorState.success?.data?[index].active ?? true,
                                            child: IconWidget(
                                                icon: AppAssets.svgEdit,
                                                onTap: (){
                                                  ref.read(navigationStackProvider).push(NavigationStackItem.addSubOperator(operatorData: userManagementWatch.subOperatorState.success?.data?[index],uuid: userManagementWatch.subOperatorState.success?.data?[index].uuid));
                                                },),
                                          ),

                                          /// Arrow Sign
                                          IconWidget(
                                            icon: AppAssets.svgExpandHistory,
                                            onTap: (){
                                              /// View Detail Screen
                                              commonTitleWithCrossIcon(
                                                context,
                                                title:  LocalizationStrings.keyOperatorDetails.localized,
                                                child: Consumer(
                                                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                                                    final userManagementWatch = ref.watch(userManagementController);
                                                    return Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            border: Border.all(color: AppColors.black),
                                                            shape: BoxShape.circle
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(85.r),
                                                            child: CacheImage(
                                                              imageURL: userManagementWatch.subOperatorState.success?.data?[index].profileImage??'',
                                                              height: 85.h,
                                                              width: 85.h),
                                                          ),
                                                        ).paddingOnly(right: 20.w),
                                                        Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                CommonText(
                                                                  title: LocalizationStrings.keyOperatorName.localized,
                                                                  textStyle: TextStyles.regular.copyWith(
                                                                      color: AppColors.clr8F8F8F, fontSize: 16.sp),
                                                                ),
                                                                SizedBox(width: context.width * 0.1),
                                                                CommonText(
                                                                  title: LocalizationStrings.keyStatus.localized,
                                                                  textStyle: TextStyles.regular.copyWith(
                                                                      color: AppColors.clr8F8F8F, fontSize: 16.sp),
                                                                ),
                                                              ],
                                                            ).paddingOnly(bottom: 7.h),
                                                            Row(
                                                              children: [
                                                                CommonText(
                                                                  title:
                                                                  '${userManagementWatch.subOperatorState.success?.data?[index].name}',
                                                                  textStyle: TextStyles.regular.copyWith(
                                                                      color: AppColors.black171717, fontSize: 18.sp),
                                                                ),

                                                                SizedBox(width: context.width * 0.13),

                                                                ///Status
                                                                if (userManagementWatch
                                                                    .activateDeactivateSubOperatorState.isLoading &&
                                                                    userManagementWatch.updatingSubOperatorIndex ==
                                                                        index)
                                                                  LoadingAnimationWidget.waveDots(
                                                                      color: AppColors.black, size: 22.h)
                                                                      .alignAtCenterLeft()
                                                                      .paddingOnly(left: 5.w)
                                                                else
                                                                  CommonCupertinoSwitch(
                                                                    switchValue: userManagementWatch.subOperatorState
                                                                        .success?.data?[index].active ??
                                                                        false,
                                                                    onChanged: (val) {
                                                                      userManagementWatch
                                                                          .activateDeactivateSubOperatorApi(
                                                                          context,
                                                                          (userManagementWatch.subOperatorState
                                                                              .success?.data?[index].uuid ??
                                                                              ''),
                                                                          val);
                                                                    },
                                                                  )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const Divider(),
                                                    Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.start,children: [
                                                        CommonShowDetailRow(
                                                          title: LocalizationStrings.keyEmailId.localized,
                                                          value: '${userManagementWatch.subOperatorState.success?.data?[index].email}').paddingOnly(bottom: 7.h),
                                                            CommonShowDetailRow(
                                                              title: LocalizationStrings.keyPhoneNumber.localized,
                                                              value: userManagementWatch.subOperatorState.success?.data?[index].contactNumber??'',),
                                                      ],
                                                    ),

                                                  ],);
                                                  },
                                                ),
                                                heightPercentage: 40,
                                                widthPercentage: 35,);
                                            },
                                          )
                                        ]),
                                      ],
                                    ).paddingOnly(left: 20.w ,right: 20.w,top:20.h,bottom: 20.h),
                                  ),
                                );
                              }, separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(height: 20.h,);
                            },).paddingSymmetric(horizontal: 30.w,vertical: 10.h),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ).paddingSymmetric(horizontal: 35.w,vertical:10.h),
            ),
            userManagementWatch.subOperatorState.success != null
                ? userManagementWatch.subOperatorState.success?.data?.isEmpty??false
                ?const SizedBox():SlideUpTransition(
              child: PaginationBottomWidget(
                hasNextPage: userManagementWatch.subOperatorState.success?.hasNextPage ?? false,
                hasPreviousPage: userManagementWatch.subOperatorState.success?.hasPreviousPage ?? false,
                totalEntries: userManagementWatch.subOperatorState.success?.totalCount ?? 0,
                totalPages: userManagementWatch.subOperatorState.success?.totalPages ?? 0,
                currentPage: userManagementWatch.subOperatorState.success?.pageNumber ?? 0,
                pageSize: userManagementWatch.subOperatorState.success?.pageSize ?? 0,
                onButtonTap: (int pageNumber) {
                  userManagementWatch.subOperatorListApi(context, pageNumber: pageNumber,isWeb: true);
                },
              ),
            ).paddingSymmetric(horizontal: 30.w)
                : const Offstage(),
            SizedBox(
              height: context.height * 0.08,
            ),
          ],
        );
    }
  }
}
