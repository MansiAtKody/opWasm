import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/services/send_service_controller.dart';
import 'package:kody_operator/framework/controller/services/service_list_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/services/mobile/helper/common_person_list_tile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class ProfileListSendServiceMobile extends StatelessWidget
    with BaseStatelessWidget {
  final bool isSendService;

  const ProfileListSendServiceMobile({super.key, required this.isSendService});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final sendServiceWatch = ref.watch(sendServiceController);
        final serviceListWatch = ref.watch(serviceListController);
        return SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                itemCount: sendServiceWatch.profiles.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                primary: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      serviceListWatch
                          .addProfileToList(sendServiceWatch.profiles[index]);
                      ref.read(navigationStackProvider).push(
                          NavigationStackItem.sendServiceDetail(
                              isSendService: isSendService,
                              profileModel: sendServiceWatch.profiles[index]));
                      ref
                          .read(sendServiceController)
                          .disposeController(isNotify: true);
                    },

                    ///Common Person Tile
                    child: CommonPersonListTile(
                            profile: sendServiceWatch.profiles[index])
                        .paddingOnly(bottom: 20.h, left: 20.w, right: 20.w),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
