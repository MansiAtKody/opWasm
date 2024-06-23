import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:flutter/scheduler.dart';

class AdditionalNoteWeb extends ConsumerStatefulWidget {
  const AdditionalNoteWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<AdditionalNoteWeb> createState() => _AdditionalNoteWebState();
}

class _AdditionalNoteWebState extends ConsumerState<AdditionalNoteWeb> with BaseConsumerStatefulWidget {

  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // final additionalNoteWatch = ref.read(additionalNoteController);
      //additionalNoteWatch.disposeController(isNotify : true);
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
      body: _bodyWidget(),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    return Container();
  }


}