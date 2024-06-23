import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/notification/notification_screen_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/notification/mobile/helper/notification_header_tile_list.dart';
import 'package:kody_operator/ui/utils/anim/slide_left_transition.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/dialog_progressbar.dart';
import 'package:kody_operator/ui/widgets/empty_state_widget.dart';


class NotificationScreenMobile extends ConsumerStatefulWidget {
  const NotificationScreenMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<NotificationScreenMobile> createState() => _NotificationScreenMobileState();
}

class _NotificationScreenMobileState extends ConsumerState<NotificationScreenMobile> with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final notificationScreenWatch = ref.read(notificationScreenController);
      notificationScreenWatch.disposeController(isNotify: true);
      await notificationScreenWatch.notificationListAPI(context);
      notificationScreenWatch.notificationListController.addListener(() async {
        if ((notificationScreenWatch.notificationListController.position.pixels >= notificationScreenWatch.notificationListController.position.maxScrollExtent - 100)) {
          if ((notificationScreenWatch.notificationListState.success?.hasNextPage ?? false) && !(notificationScreenWatch.notificationListState.isLoadMore)) {
            notificationScreenWatch.increasePageNumber();
            await notificationScreenWatch.notificationListAPI(context);
          }
        }
      });
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
    final notificationScreenWatch = ref.read(notificationScreenController);
    return Scaffold(
      appBar: CommonAppBar(
        title: LocalizationStrings.keyNotification.localized,
        actions: [
          notificationScreenWatch.notificationListState.success?.data?.isNotEmpty ?? false ? InkWell(
            onTap: () async {
              await notificationScreenWatch.deleteNotificationListAPI(context);
            },
            child: CommonText(
              title: LocalizationStrings.keyClearAll.localized,
              textStyle: TextStyles.medium.copyWith(color: AppColors.white, fontSize: 14.sp),
            ).paddingOnly(right: 20.w),
          ) : const Offstage()
        ],
      ),
      backgroundColor: AppColors.servicesScaffoldBgColor,
      body: Stack(
        children: [
          _bodyWidget(),
          DialogProgressBar(
              isLoading: notificationScreenWatch.notificationListState.isLoading || notificationScreenWatch.deleteNotificationListState.isLoading, forPagination: false),
        ],
      ),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    final notificationScreenWatch = ref.watch(notificationScreenController);
    return (notificationScreenWatch.notificationList.isNotEmpty)
        ? Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: notificationScreenWatch.notificationListState.success?.data?.length ?? 0,
            controller: notificationScreenWatch.notificationListController,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              var model = notificationScreenWatch.notificationList[index];
              return Dismissible(
                key: Key(index.toString()),
                background: Container(color: Colors.red,),
                confirmDismiss:(value)async{
                  return showConfirmationDialog( context,'yes','no',(status)
                  async{
                    if(status)
                    {
                      await notificationScreenWatch.deleteNotificationAPI(context,notificationScreenWatch.notificationListState.success?.data?.elementAt(index).id.toString()??'');
                      if(context.mounted){
                        await notificationScreenWatch.notificationListAPI(context);
                      }
                    }
                  } ,
                    title: 'Delete Notification',
                      message: 'Are you sure you want to delete Notification',

                  );
                },                child: SlideLeftTransition(
                delay: 100,
                child: Column(
                  children: [
                    NotificationHeaderTileList(
                      model: model,
                      delay: 100,
                      modelIndex: index,
                    ),
                  ],
                ),
              ),
              );
            },
            separatorBuilder: (context, index) {
              var model = notificationScreenWatch.notificationList[index];
              String status = notificationScreenWatch.dateConverter(formatDatetime(createdAt: model.createdAt ?? 0, dateFormat: 'dd MMM yyyy, hh:mm:ss'));
              String beforeStatus = index == 0
                  ? notificationScreenWatch.dateConverter(formatDatetime(createdAt: model.createdAt ?? 0, dateFormat: 'dd MMM yyyy, hh:mm:ss'))
                  : notificationScreenWatch
                  .dateConverter(formatDatetime(createdAt: notificationScreenWatch.notificationList[index - 1].createdAt ?? 0, dateFormat: 'dd MMM yyyy, hh:mm:ss'));
              if (beforeStatus != status) {
                return Column(
                  children: [
                    Visibility(
                      visible: true,
                      // notificationScreenWatch.dateConverter(formatDatetime(createdAt: model.createdAt??0,dateFormat: 'dd MMM yyyy, hh:mm:ss')) != notificationScreenWatch.dateConverter(formatDatetime(createdAt: notificationScreenWatch.notificationList[index].data?.elementAt(index-1).createdAt??0,dateFormat: 'dd MMM yyyy, hh:mm:ss')),
                      child: CommonText(
                        title: notificationScreenWatch.dateConverter(formatDatetime(createdAt: model.createdAt ?? 0, dateFormat: 'dd MMM yyyy, hh:mm:ss')),
                        textStyle: TextStyles.regular.copyWith(color: AppColors.black, fontSize: 14.sp),
                      ),
                    ),
                    Divider(
                      height: 40.h,
                      color: AppColors.greyBEBEBE.withOpacity(.2),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    Visibility(
                      visible: true,
                      child: CommonText(
                        title: notificationScreenWatch.dateConverter(formatDatetime(createdAt: model.createdAt ?? 0, dateFormat: 'dd MMM yyyy, hh:mm:ss')),
                        textStyle: TextStyles.regular.copyWith(color: AppColors.black, fontSize: 14.sp),
                      ),
                    ),
                    Divider(
                      height: 40.h,
                      color: AppColors.greyBEBEBE.withOpacity(.2),
                    ),
                  ],
                );
              }
            },
          ).paddingSymmetric(horizontal: 20.w),
        ),
        DialogProgressBar(isLoading: notificationScreenWatch.notificationListState.isLoadMore, forPagination: true),
      ],
    )
        : EmptyStateWidget(
      title: LocalizationStrings.keyNoNotification.localized,
      subTitle: '',
    );
  }
}
