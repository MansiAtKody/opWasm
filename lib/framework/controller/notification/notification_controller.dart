import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';



final notificationController = ChangeNotifierProvider(
      (ref) => getIt<NotificationController>(),
);

@injectable
class NotificationController extends ChangeNotifier {

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {

    if (isNotify) {
      notifyListeners();
    }
  }

/*  List<NotificationModel> notificationList = [
    NotificationModel(header: 'Today',headerModel: [
      NotificationHeaderModel(title: 'Your order is successfully Accepted',value: 'Your delicious meal is being prepared, hang tight!"'),
      NotificationHeaderModel(title: 'Good Morning John !',value: 'Start your day with a perfect cup of coffee tailored just for you.')
    ]),
    NotificationModel(header: 'Yesterday',headerModel: [
      NotificationHeaderModel(title: 'New Item Added !',value: 'We have Hot Chocolate in today’s menu'),
      NotificationHeaderModel(title: 'Good Morning John !',value: 'Start your day with a perfect cup of coffee tailored just for you.')
    ]),
    NotificationModel(header: 'Older',headerModel: [
      NotificationHeaderModel(title: 'Your order is successfully Accepted',value: 'Your delicious meal is being prepared, hang tight!"'),
      NotificationHeaderModel(title: 'Good Morning John !',value: 'Start your day with a perfect cup of coffee tailored just for you.')
    ]),
  ];*/





}

class NotificationModel{
  String? header;
  List<NotificationHeaderModel>? headerModel;

  NotificationModel({this.header, this.headerModel});
}

class NotificationHeaderModel{
  String? title;
  String? value;

  NotificationHeaderModel({this.title, this.value});
}

