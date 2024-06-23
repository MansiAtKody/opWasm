import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/services/send_service_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/anim/slide_left_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_searchbar.dart';

class SendServiceMobileAppbarWidget extends StatelessWidget with BaseStatelessWidget {
  final bool isSendService;
  const SendServiceMobileAppbarWidget({super.key, required this.isSendService});

  @override
  Widget buildPage(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SlideLeftTransition(
          child: Consumer(
            builder: (context, ref, child) {
              final sendServiceWatch = ref.watch(sendServiceController);
              return CommonSearchBar(
                leftIcon: AppAssets.svgSearch,
                height: 44.h,
                placeholder: isSendService ? LocalizationStrings.keyFindReceiver.localized : LocalizationStrings.keyReceiveService.localized,
                clrSearchIcon: AppColors.white,
                textColor: AppColors.white,
                cursorColor: AppColors.white,
                bgColor: AppColors.white.withOpacity(0.03),
                borderWidth: 0,
                controller: sendServiceWatch.searchCtr,
                onChanged: (value) {
                  sendServiceWatch.onSearch();
                },
                onTapOutside: (value) {
                  FocusScope.of(context).unfocus();
                },
              ).paddingSymmetric(horizontal: 20.w);
            },
          ),
        ),
      ],
    );
  }
}
