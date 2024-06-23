import 'package:kody_operator/framework/repository/help_and_support/model/chat_model.dart';
import 'package:kody_operator/framework/utility/extension/datetime_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class ChatCard extends StatelessWidget with BaseStatelessWidget {
  final ChatModel? chat;

  const ChatCard({
    super.key,
    required this.chat,
  });

  @override
  Widget buildPage(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: AppColors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ///Profile
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Image.asset(
                chat?.profile ?? '',
                width: 27.h,
                height: 27.h,
                fit: BoxFit.fill,
              ).paddingLTRB(20.w, 20.h, 15.w, 0.0),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Message content
                  CommonText(
                    title: chat?.message ?? '',
                    textStyle: TextStyles.regular.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.chatCardTextColor,
                    ),
                    maxLines: 2000,
                  ).paddingLTRB(0.0, 28.h, 20.w, 11.h),
                  Row(
                    children: [
                      ///Date of the Message
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            title: LocalizationStrings.keyTicketDateLabel.localized,
                            textStyle: TextStyles.regular.copyWith(
                                fontSize: 14.sp,
                                color: AppColors.chatCardTextColor),
                          ),
                          CommonText(
                            title: (chat?.datetime.dateOnly) ?? '',
                            textStyle: TextStyles.regular.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.chatCardTextColor,
                            ),
                          ),
                        ],
                      ).paddingOnly(right: 12.sp),

                      ///Vertical Divider
                      CommonSVG(
                        strIcon: AppAssets.svgChatVerticalDivider,
                        width: 2.w,
                        height: 18.h,
                      ),

                      ///Time of the message
                      CommonText(
                        title: (chat?.datetime.timeOnly) ?? '',
                        textStyle: TextStyles.regular.copyWith(
                            fontSize: 14.sp,
                            color: AppColors.chatCardTextColor),
                      ).paddingOnly(left: 12.sp),
                    ],
                  ).paddingOnly(bottom: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
