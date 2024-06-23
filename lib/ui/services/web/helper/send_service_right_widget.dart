import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/services/service_list_controller.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/services/web/helper/send_service_detail_right_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class SendServiceRightWidget extends ConsumerWidget with BaseConsumerWidget {
  const SendServiceRightWidget({
    super.key,
  });

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final serviceListWatch = ref.watch(serviceListController);
    return Column(
      children: [
        // SizedBox(height: context.height * 0.09),
        if (serviceListWatch.serviceProfiles.isNotEmpty)
          Expanded(
            child: SizedBox(
              width: context.width * 0.4,
              child: SendServiceDetailRightWidget(
                profile: serviceListWatch.selectedProfile,
              ),
            ),
          )
        else
          Expanded(
            child: SizedBox(
              width: context.width * 0.4,
              child: CommonCard(
                color: AppColors.clrF7F7FC,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonText(
                      title: LocalizationStrings.keyNoDataFound.localized,
                      textAlign: TextAlign.center,
                      textStyle: TextStyles.medium.copyWith(
                        fontSize: 18.sp,
                        color: AppColors.clr272727,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                      width: double.infinity,
                    ),
                    CommonText(
                      title: LocalizationStrings.keySearchForSomeone.localized,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      textStyle: TextStyles.regular.copyWith(
                        color: AppColors.clr272727,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
