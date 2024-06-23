import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/scheduler.dart';
import 'package:kody_operator/framework/controller/services/recycling_controller.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/services/mobile/helper/recycling_widget_mobile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';

class RecyclingMobile extends ConsumerStatefulWidget {
  const RecyclingMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<RecyclingMobile> createState() => _RecyclingMobileState();
}

class _RecyclingMobileState extends ConsumerState<RecyclingMobile>
    with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final recyclingWatch = ref.read(recyclingController);
      recyclingWatch.disposeController(isNotify: true);
    });
  }

  ///Dispose Override
  @override
  void dispose() {
    super.dispose();
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: LocalizationStrings.keyRecycleService.localized,
      ),
      body: _bodyWidget(),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    return const RecyclingWidgetMobile();
  }
}
