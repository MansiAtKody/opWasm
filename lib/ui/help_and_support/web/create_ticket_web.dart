import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/help_and_support/create_ticket_controller.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class CreateTicketWeb extends ConsumerStatefulWidget {
  const CreateTicketWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateTicketWeb> createState() => _CreateTicketWebState();
}

class _CreateTicketWebState extends ConsumerState<CreateTicketWeb>
    with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final createTicketWatch = ref.read(createTicketController);
      createTicketWatch.disposeController(isNotify: true);
      createTicketWatch.disposeFormKey();
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
      body: Container(),
    );
  }
}
