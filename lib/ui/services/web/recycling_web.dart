import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/scheduler.dart';
import 'package:kody_operator/ui/services/web/helper/recycling_widget.dart';
import 'package:kody_operator/framework/controller/services/recycling_controller.dart';
import 'package:kody_operator/ui/utils/helpers/base_page_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';

class RecyclingWeb extends ConsumerStatefulWidget {
  const RecyclingWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<RecyclingWeb> createState() => _RecyclingWebState();
}

class _RecyclingWebState extends ConsumerState<RecyclingWeb> with BaseConsumerStatefulWidget, BaseDrawerPageWidget {

  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final recyclingWatch = ref.read(recyclingController);
      recyclingWatch.disposeController(isNotify : true);
      print(recyclingWatch.selectedDepartmentIndex);
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
    return _bodyWidget();
  }

  ///Body Widget
  Widget _bodyWidget() {
    return const RecyclingWidget();
  }


}
