
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/order_details_controller.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';


class OrderDetailsWeb extends ConsumerStatefulWidget {
  const OrderDetailsWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<OrderDetailsWeb> createState() => _OrderDetailsWebState();
}

class _OrderDetailsWebState extends ConsumerState<OrderDetailsWeb> with BaseConsumerStatefulWidget {

  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final orderDetailsWatch = ref.read(orderDetailsController);
      orderDetailsWatch.disposeController(isNotify : true);
    });
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }

}