import 'package:kody_operator/framework/repository/service/service_request_model.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/datetime_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class CommonDocumentSentWidgetWeb extends StatelessWidget with BaseStatelessWidget {
  const CommonDocumentSentWidgetWeb({
    super.key,
    required this.serviceRequestModel,
    this.bgColor,
    this.dateColor,
    this.svgBgColor,
  });

  final ServiceRequestModel? serviceRequestModel;
  final Color? bgColor;
  final Color? dateColor;
  final Color? svgBgColor;

  @override
  Widget buildPage(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: context.height * 0.02,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: context.width * 0.01),

          ///Ticket Icon
          CommonSVG(
            height: context.height * 0.06,
            strIcon: AppAssets.svgServiceDocumentFile,
          ),
          SizedBox(width: context.width * 0.01),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Ticket Title
                    Expanded(
                      child: CommonText(
                        title: serviceRequestModel?.subject ?? '',
                        textStyle: TextStyles.regular.copyWith(color: AppColors.clr171717),
                        maxLines: 1,
                      ).paddingOnly(top: 10.h),
                    ),

                    ///Ticket Status
                    Container(
                      height: context.height * 0.04,
                      width: context.width * 0.1,
                      decoration: BoxDecoration(
                        color: AppColors.clrF7F7FC,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.r),
                        ),
                      ),
                      child: Center(
                        child: CommonText(
                          title: LocalizationStrings.keyDelivered.localized,
                          textStyle: TextStyles.regular.copyWith(
                            fontSize: 12.sp,
                            color: AppColors.charcoalGrey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.height * 0.02),

                ///Ticket Description
                CommonText(
                  title: serviceRequestModel?.message ?? '',
                  maxLines: 5,
                  textStyle: TextStyles.regular.copyWith(fontSize: 12.sp, color: AppColors.textFieldLabelColor),
                ),
                SizedBox(height: context.height * 0.01),
                CommonText(
                  title: serviceRequestModel?.requestDate.dateOnly ?? '',
                  maxLines: 1,
                  textStyle: TextStyles.regular.copyWith(
                    fontSize: 12.sp,
                    color: dateColor ?? AppColors.primary2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ).paddingOnly(bottom: context.height * 0.02, right: context.width * 0.015),
    );
  }
}
