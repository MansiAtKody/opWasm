import 'package:kody_operator/framework/repository/service/profile_model.dart';
import 'package:kody_operator/framework/repository/service/service_request_model.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';

import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';

import 'package:kody_operator/ui/widgets/common_text.dart';

class DocumentDialog extends StatelessWidget with BaseStatelessWidget {
  const DocumentDialog({super.key, required this.model, required this.profile});

  final ServiceRequestModel? model;
  final ProfileModel? profile;

  @override
  Widget buildPage(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Status of the sent or received Services
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  title: LocalizationStrings.keySubject.localized,
                  textStyle: TextStyles.regular.copyWith(
                    color: AppColors.clr7E7E7E,
                  ),
                ).paddingOnly(bottom: 6.h),
                CommonText(
                  title: model?.subject ?? '',
                  textStyle: TextStyles.regular.copyWith(
                    color: AppColors.clr171717,
                  ),
                ).paddingOnly(bottom: 20.h),
                CommonText(
                  title: LocalizationStrings.keyDescription.localized,
                  textStyle: TextStyles.regular.copyWith(
                    color: AppColors.clr7E7E7E,
                  ),
                ).paddingOnly(bottom: 8.h),
                CommonText(
                  title: model?.message ?? '',
                  maxLines: 5,
                  textStyle: TextStyles.regular.copyWith(
                    color: AppColors.clr171717,
                  ),
                ),
              ],
            ).paddingOnly(top: 20.h, bottom: 10.h),
          ],
        ).paddingSymmetric(vertical: 20.h),
        CommonCard(
          color: AppColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Divider(
              //   height: 4.h,
              // ).paddingSymmetric(vertical: 10.h),
              // CommonText(
              //   title: LocalizationStrings.keyRequestDetails,
              //   textStyle: TextStyles.medium.copyWith(
              //     color: AppColors.clr171717,
              //   ),
              // ).paddingOnly(bottom: 26.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RequestDetailsCommonWebWidget(
                    title: model?.orderId ?? '',
                    label: LocalizationStrings.keyOrderId.localized,
                  ),
                  RequestDetailsCommonWebWidget(
                    title: model?.fromPerson ?? '',
                    label: LocalizationStrings.keyFrom.localized,
                  ),
                  RequestDetailsCommonWebWidget(
                    title: model?.toPerson ?? '',
                    label: LocalizationStrings.keyTo.localized,
                  ),
                  RequestDetailsCommonWebWidget(
                    title: model?.itemType ?? '',
                    label: LocalizationStrings.keyItemType.localized,
                  ),
                  RequestDetailsCommonWebWidget(
                    title: model?.orderStatus ?? '',
                    label: LocalizationStrings.keyOrderStatus.localized,
                  ),
                ],
              ).paddingOnly(bottom: 30.h, right: 40.w),
              ///Ticket Status
              Container(
                height: context.height * 0.04,
                width: context.width * 0.07,
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
              ).paddingOnly(bottom: 30.h),
            ],
          ),
        ),
      ],
    );
  }
}

class RequestDetailsCommonWebWidget extends StatelessWidget with BaseStatelessWidget {
  const RequestDetailsCommonWebWidget({
    super.key,
    required this.title,
    required this.label,
  });

  final String label;
  final String title;

  @override
  Widget buildPage(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          title: label,
          textStyle: TextStyles.regular.copyWith(
            color: AppColors.clr7E7E7E,
            fontSize: 12.sp,
          ),
        ).paddingOnly(bottom: 10.h),
        CommonText(
          title: title,
          textStyle: TextStyles.regular.copyWith(
            color: AppColors.clr171717,
            fontSize: 12.sp,
          ),
        ).paddingOnly(bottom: 10.h),
      ],
    );
  }
}
