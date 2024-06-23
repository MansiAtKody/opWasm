import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/services/services_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/services/mobile/helper/common_service_list_tile.dart';
import 'package:kody_operator/ui/utils/anim/fade_box_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_drawer_mobile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';

class ServicesMobile extends ConsumerStatefulWidget {
  const ServicesMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<ServicesMobile> createState() => _ServicesMobileState();
}

class _ServicesMobileState extends ConsumerState<ServicesMobile> with BaseConsumerStatefulWidget, BaseDrawerPageWidgetMobile {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // final servicesWatch = ref.read(servicesController);
    });
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return _bodyWidget();
  }

  ///Body Widget
  Widget _bodyWidget() {
    final serviceWatch = ref.watch(servicesController);
    return Scaffold(
      // backgroundColor: AppColors.white,

      body: CommonWhiteBackground(
        appBar: CommonAppBar(
          isDrawerEnable: true,
          title: LocalizationStrings.keyServices.localized,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                itemCount: serviceWatch.availableServicesMobile.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  ///Common List tile for Services
                  return FadeBoxTransition(
                    child: CommonServiceListTile(
                      index: index,
                      imageAsset: serviceWatch.availableServicesMobile[index].iconName,
                      onTap: () {
                        ref.read(navigationStackProvider).push(serviceWatch.availableServicesMobile[index].stackItem);
                      },
                      text: serviceWatch.availableServicesMobile[index].title,
                    ).paddingOnly(bottom: 20.h),
                  );
                },
              )
            ],
          ),
        ).paddingSymmetric(horizontal: 8.w, vertical: 12.h),
      ),
    );
  }
}
