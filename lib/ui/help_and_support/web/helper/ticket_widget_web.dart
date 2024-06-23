import 'package:kody_operator/framework/repository/help_and_support/model/get_ticket_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/datetime_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class TicketWidgetWeb extends StatelessWidget with BaseStatelessWidget {
  final TicketResponseModel? ticket;

  ///give 0 if you dont want to display as a card
  final double? elevation;

  final Decoration? decoration;

  const TicketWidgetWeb({
    Key? key,
    this.elevation,
    required this.ticket,
    this.decoration,
  }) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    final ticketStatusColor = getTicketStatusColor(ticket?.ticketStatus ?? 'Pending');
    final ticketStatusTextColor = getTicketStatusTextColor(ticket?.ticketStatus ?? 'Pending');
    return CommonCard(
      cornerRadius: 15.r,
      color: AppColors.whiteF7F7FC,
      elevation: elevation,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ///Ticket Icon
          const CommonSVG(
            strIcon: AppAssets.svgTicketIconWhiteBg,
          ).paddingLTRB(12.w, 20.h, 12.w, 3.h),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///Ticket Title
                    Expanded(
                      child: CommonText(
                        title: ticket?.ticketReason ?? '',
                        textOverflow: TextOverflow.ellipsis,
                        textStyle: TextStyles.regular.copyWith(color: AppColors.black171717,fontSize: 16.sp),
                        maxLines: 1,
                      ).paddingOnly(top: 15.h),
                    ),

                    ///Ticket Status
                    Container(
                      decoration: BoxDecoration(
                        color: ticketStatusColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.r),
                        ),
                      ),
                      child: Center(
                        child: CommonText(
                          title: ticket?.ticketStatus ?? LocalizationStrings.keyPending.localized,
                          textStyle: TextStyles.regular.copyWith(
                            fontSize: 14.sp,
                            color: ticketStatusTextColor,
                          ),
                        ).paddingSymmetric(horizontal: 20.w, vertical: 8.h),
                      ),
                    ).paddingOnly(top: 20.h, bottom: 12.h),
                  ],
                ).paddingOnly(right: 20.w),

                ///Ticket Description
                CommonText(
                  title: ticket?.description ?? '',
                  maxLines: 1000,
                  textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.textFieldLabelColor),
                ).paddingOnly(right: 30.w),
                Row(
                  children: [
                    /// Ticket Id
                    Row(children: [
                      CommonText(
                        title: LocalizationStrings.keyTicketIdLabel.localized,
                        textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.primary2),
                      ),
                      CommonText(
                        title: ticket?.id.toString() ?? '',
                        textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.primary2),
                      ),
                    ]).paddingOnly(right: 8.w),

                    /// Vertical Divider
                    CommonSVG(
                      strIcon: AppAssets.svgTicketVerticalDivider,
                      width: 2.w,
                      height: 18.h,
                    ),

                    ///Ticket date
                    Row(
                      children: [
                        CommonText(
                          title: LocalizationStrings.keyTicketDateLabel.localized,
                          textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.primary2),
                        ),
                        CommonText(
                          title: DateTime.fromMillisecondsSinceEpoch(ticket?.createdAt ?? 0).dateOnly,
                          textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.primary2),
                        ),
                      ],
                    ).paddingOnly(left: 8.w),
                  ],
                ).paddingOnly(top: 10.h),
              ],
            ),
          ),
        ],
      ).paddingOnly(bottom: 20.h),
    );
  }
}
