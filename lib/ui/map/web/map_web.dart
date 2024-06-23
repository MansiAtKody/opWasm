import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/ui/map/web/helper/map_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_page_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class MapWeb extends ConsumerStatefulWidget {
  const MapWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<MapWeb> createState() => _MapWebState();
}

class _MapWebState extends ConsumerState<MapWeb> with BaseConsumerStatefulWidget, BaseDrawerPageWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // final mapWatch = ref.watch(mapController);
      //mapWatch.disposeController(isNotify : true);
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
    // return Scaffold(
    //   body: _bodyWidget(),
    // );
    return _bodyWidget();
  }

  ///Body Widget
  Widget _bodyWidget() {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return const MapWidget();
      },
    );
  }

}
