import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/notification/notification_screen_controller.dart';
import 'package:kody_operator/framework/repository/notification/model/response%20model/notification_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';

/// Shimmer Notification
class ShimmerNotification extends StatelessWidget with BaseStatelessWidget {
  const ShimmerNotification({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final notificationScreenWatch = ref.watch(notificationScreenController);
        return CommonWhiteBackground(
          child: ListView.builder(
            itemCount: notificationScreenWatch.notificationList.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              var model = notificationScreenWatch.notificationList[index];
              return _notificationHeaderListTile(context, model);
            },
          ).paddingOnly(left: 12.w, right: 12.w, top: 12.h),
        );
      },
    );
  }
}

/// Shimmer Notification Header List Tile
Widget _notificationHeaderListTile(
    BuildContext context, NotificationData model) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CommonShimmer(
        height: 9.h,
        width: 66.w,
      ).paddingOnly(top: 30.h, bottom: 20.h),
      ListView.separated(
        itemCount:5,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return _notificationHeaderContentListTile(context);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 40.h,
            color: AppColors.greyBEBEBE.withOpacity(.2),
          );
        },
      ).paddingOnly(left: 21.w, top: 21.w, right: 67.w, bottom: 32.h),
    ],
  );
}

/// Shimmer Notification Header Content List Tile
Widget _notificationHeaderContentListTile(BuildContext context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 44.h,
        width: 44.h,
        decoration:
            const BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
        child: CommonShimmer(
          height: 22.h,
          width: 22.h,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: AppColors.black),
        ),
      ),
      SizedBox(
        width: 15.w,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonShimmer(
              height: 16.h,
              width: context.width * 0.5,
            ),
            SizedBox(
              height: 5.h,
            ),
            CommonShimmer(
              height: 12.h,
              width: context.width * 0.9,
            ),
            SizedBox(
              height: 5.h,
            ),
            CommonShimmer(
              height: 12.h,
              width: context.width * 0.9,
            ),
          ],
        ),
      )
    ],
  );
}
