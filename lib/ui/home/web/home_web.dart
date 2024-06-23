import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/order_management/order_management_controller.dart';
import 'package:kody_operator/framework/controller/order_management/order_status_controller.dart';
import 'package:kody_operator/framework/controller/profile/profile_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/ui/order_management/web/helper/order_status_right_widget.dart';
import 'package:kody_operator/ui/order_management/web/helper/shimmer_order_management_web.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_page_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class OrderManagementWeb extends ConsumerStatefulWidget {
  final ScreenName? screenName;

  const OrderManagementWeb({Key? key, this.screenName}) : super(key: key);

  @override
  ConsumerState<OrderManagementWeb> createState() => _HomeWebState();
}

class _HomeWebState extends ConsumerState<OrderManagementWeb> with BaseConsumerStatefulWidget, BaseDrawerPageWidget, TickerProviderStateMixin {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final orderManagementWatch = ref.read(orderManagementController);
      orderManagementWatch.disposeController(isNotify: true);
      if(Session.getOldFCMToken().isEmpty){
        await orderManagementWatch.registerDeviceFcmToken(context);
        await Session.saveLocalData(keyOldFCMToken, Session.getNewFCMToken());
      }else if(Session.getNewFCMToken() != Session.getOldFCMToken()){
        await orderManagementWatch.registerDeviceFcmToken(context);
        await Session.saveLocalData(keyOldFCMToken, Session.getNewFCMToken());
      }
      // await ref.read(selectCoffeeController).refreshTokenApi(context);
      ref.read(orderStatusController).socketManager.startSocket(ref);
      final profileWatch = ref.watch(profileController);
      await profileWatch.getProfileDetail(context);
    });
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    final orderStatusWatch = ref.watch(orderStatusController);
    final profileWatch = ref.watch(profileController);

    return
      profileWatch.profileDetailState.isLoading &&
          orderStatusWatch.upcomingSocketOrders.isEmpty ? const ShimmerOrderManagementWeb(): const OrderStatusRightWidget()
          .paddingSymmetric(vertical: 15.h);
  }
}
