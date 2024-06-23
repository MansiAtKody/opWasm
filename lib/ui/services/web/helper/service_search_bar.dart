import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/services/send_service_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_searchbar.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';

class ServiceSearchBar extends StatelessWidget with BaseStatelessWidget {
  final String title;
  const ServiceSearchBar({
    super.key, required this.title,
  });

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
      final sendServiceWatch = ref.watch(sendServiceController);
      return CommonSearchBar(
        leftIcon: AppAssets.svgSearch,
        height: 44.h,
        placeholder:title,
        clrSearchIcon: AppColors.clr272727,
        textColor: AppColors.clr272727,
        cursorColor: AppColors.clr272727,
        bgColor: AppColors.clrF7F7FC,
        borderWidth: 0,
        controller: sendServiceWatch.searchCtr,
        suffix: InkWell(
          onTap: () {
            sendServiceWatch.clearSearch();
            sendServiceWatch.onSearch();
          },
          child: sendServiceWatch.searchCtr.text.isNotEmpty ?
          const CommonSVG(strIcon: AppAssets.svgCrossIcon) :
          const Offstage(),
        ).paddingSymmetric(vertical: 12.h, horizontal: 12.w),
        onChanged: (value) {
          sendServiceWatch.onSearch();
        },
        onClearSearch: () {
          sendServiceWatch.onSearch();
        },
        onTapOutside: (value) {
          hideKeyboard(context);
        },
      );
    });
  }
}
