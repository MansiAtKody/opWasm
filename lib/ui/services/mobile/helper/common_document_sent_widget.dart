import 'package:kody_operator/framework/repository/service/service_request_model.dart';
import 'package:kody_operator/framework/utility/extension/datetime_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';

class CommonDocumentSentWidget extends StatelessWidget
    with BaseStatelessWidget {
  const CommonDocumentSentWidget(
      {super.key, required this.serviceRequestModel});

  final ServiceRequestModel? serviceRequestModel;

  @override
  Widget buildPage(BuildContext context) {
    return Container(
      color: AppColors.transparent,
      child: CommonCard(
        cornerRadius: 15.r,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ///Ticket Icon
            CommonSVG(
              strIcon: AppAssets.svgServiceDocumentFileWhiteBg,
              width: 42.w,
              height: 42.w,
            ).paddingLTRB(12.w, 20.h, 20.w, 0.0),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ///Ticket Title
                      // Flexible(
                      //   child: Text(
                      //     serviceRequestModel?.subject ?? '',
                      //     style: TextStyles.regular.copyWith(color: AppColors.black171717),
                      //     maxLines: 1,
                      //   ),
                      // ),
                      ///Ticket Description
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              serviceRequestModel?.message ?? '',
                              maxLines: 2,
                              softWrap: true,
                              style: TextStyles.regular.copyWith(
                                  fontSize: 14.sp,
                                  color: AppColors.black171717),
                            ).paddingOnly(right: 60.w),
                            Text(
                              serviceRequestModel?.requestDate.dateOnly ?? '',
                              maxLines: 1,
                              softWrap: true,
                              style: TextStyles.regular.copyWith(
                                  fontSize: 12.sp, color: AppColors.primary2),
                            ).paddingOnly(top: 10.h),
                          ],
                        ).paddingOnly(top: 20.h),
                      ),

                      ///Ticket Status
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          width: 75.w,
                          height: 27.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: AppColors.white),
                          child: Text(
                            LocalizationStrings.keyDelivered.localized,
                            style: TextStyles.regular.copyWith(
                              fontSize: 12.sp,
                              color: AppColors.charcoalGrey,
                            ),
                          ),
                        ).paddingOnly(top: 20.h, bottom: 12.h),
                      ),
                    ],
                  ).paddingOnly(right: 17.w),
                ],
              ),
            ),
          ],
        ).paddingOnly(bottom: 20.h),
      ),
    );
  }
}
