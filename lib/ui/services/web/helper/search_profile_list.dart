import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/services/send_service_controller.dart';
import 'package:kody_operator/framework/controller/services/service_list_controller.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/services/web/helper/common_person_list_tile_web.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';

class SearchProfileList extends ConsumerWidget with BaseConsumerWidget {
  const SearchProfileList({
    super.key,
    required this.isSendService,
  });

  final bool isSendService;

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final sendServiceWatch = ref.watch(sendServiceController);
    final serviceListWatch = ref.watch(serviceListController);
    return CommonCard(
      child: Container(
        height: context.height * 0.6,
        width: context.width * 0.19,
        alignment: Alignment.topCenter,
        child: ListView.builder(
          itemCount: sendServiceWatch.profiles.length,
          shrinkWrap: true,
          primary: true,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                hideKeyboard(context);
                serviceListWatch.addProfileToList(sendServiceWatch.profiles[index]);
                ref.watch(sendServiceController).disposeController(isNotify: true);
              },

              ///Common Person Tile
              child: CommonPersonListTileWeb(
                isSuffixVisible: false,
                borderRadius: 20.r,
                profile: sendServiceWatch.profiles[index],
              ).paddingOnly(bottom: 15.h, left: 15.w, right: 15.w),
            );
          },
        ),
      ),
    ).paddingOnly(top: 10.h);
  }
}
