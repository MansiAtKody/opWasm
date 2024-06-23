
import 'package:kody_operator/framework/repository/notification/model/response%20model/notification_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/notification/web/helper/notification_header_content_tile_list_web.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/notification/notification_screen_controller.dart';

class NotificationHeaderTileListWeb extends ConsumerWidget
    with BaseConsumerWidget {
  final NotificationData model;

  const NotificationHeaderTileListWeb({super.key, required this.model});

  @override
  Widget buildPage(BuildContext context,WidgetRef ref) {
    final notificationScreenWatch = ref.watch(notificationScreenController);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          title: notificationScreenWatch.dateConverter(formatDatetime(createdAt: model.createdAt??0,dateFormat: 'dd MMM yyyy, hh:mm:ss')),
          textStyle: TextStyles.regular
              .copyWith(color: AppColors.textFieldLabelColor, fontSize: 20.sp),
        ).paddingOnly(left: 20.w),
        SizedBox(
          height: 10.h,
        ),
        CommonCard(
          color: AppColors.lightPinkF7F7FC,
          child: ListView.separated(
            itemCount: notificationScreenWatch.notificationListState.success?.data?.length??0,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              // var notificationHeaderList = model.headerModel![index];
              return NotificationHeaderContentTileList(index: index);
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                height: 40.h,
                color: AppColors.greyBEBEBE.withOpacity(.2),
              );
            },
          ).paddingAll(20.h),
        ),
      ],
    );
  }
}