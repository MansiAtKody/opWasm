import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/authentication/model/common_response_model.dart';
import 'package:kody_operator/framework/repository/notification/contract/notification_repository.dart';
import 'package:kody_operator/framework/repository/notification/model/response%20model/notification_list_count_response_model.dart';
import 'package:kody_operator/framework/utility/ui_state.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/show_common_error_dialog.dart';
import 'package:kody_operator/framework/repository/notification/model/response%20model/notification_list_response_model.dart';


final notificationScreenController = ChangeNotifierProvider(
      (ref) => getIt<NotificationScreenController>(),
);

@injectable
class NotificationScreenController extends ChangeNotifier {
  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = false;
    notificationListCountState.success = null;
    pageNoNotificationList = 1;
    if (isNotify) {
      notifyListeners();
    }
  }

  ScrollController notificationListController = ScrollController();

  /*List<NotificationModel> notificationList = [
    NotificationModel(header: 'Today', headerModel: [
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

  List<NotificationData> notificationList = [];

  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */

  ///Progress Indicator
  bool isLoading = false;

  void updateLoadingStatus(bool value) {
    isLoading = value;
    notifyListeners();
  }

  NotificationRepository notificationRepository;

  NotificationScreenController(this.notificationRepository);

  var notificationListState = UIState<NotificationListResponseModel>();
  var notificationListCountState = UIState<NotificationListCountResponseModel>();
  var deleteNotificationListState = UIState<CommonResponseModel>();
  var deleteNotificationState = UIState<CommonResponseModel>();

  int pageNoNotificationList = 1;

  void increasePageNumber() {
    pageNoNotificationList += 1;
    notifyListeners();
  }

  /// Notification List API
  Future<void> notificationListAPI(BuildContext context) async {
    if ((pageNoNotificationList != 1) && (notificationListState.success?.hasNextPage ?? false)) {
      notificationListState.isLoadMore = true;
    } else {
      pageNoNotificationList = 1;
      notificationList.clear();
      notificationListState.isLoading = true;
    }
    notificationListState.success = null;
    notifyListeners();

    /// set loading status and clear product list
    if (pageNoNotificationList == 1) {
      notificationList.clear();
      notificationListState.isLoading = true;
    } else {
      notificationListState.isLoadMore = true;
    }
    notifyListeners();
    final result = await notificationRepository.notificationListAPI(pageNoNotificationList);

    result.when(success: (data) async {
      notificationListState.success = data;
      // notificationList.addAll(notificationListState.success as List);

      if (notificationListState.success?.data?.isNotEmpty ?? false) {
        notificationList.addAll(notificationListState.success?.data ?? []);
      }
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    notificationListState.isLoading = false;
    notificationListState.isLoadMore = false;
    notifyListeners();
  }

  /// Notification count
  Future<void> notificationListCountAPI(BuildContext context) async {
    notificationListCountState.isLoading = true;
    notificationListCountState.success = null;
    notifyListeners();

    final result = await notificationRepository.notificationListCountAPI();

    result.when(success: (data) async {
      notificationListCountState.success = data;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      /* print('MediaQuery.of(context).size.height${MediaQuery.of(context).size.height}');
          print('MediaQuery.of(context).size.width${MediaQuery.of(context).size.width}');
          print('MediaQuery.of(context).size.height>812 && MediaQuery.of(context).size.width>375${MediaQuery.of(context).size.height>812 && MediaQuery.of(context).size.width>375}');*/
      showCommonErrorDialog(context: context, message: errorMsg);
      /*if(MediaQuery.of(context).size.height>812 || MediaQuery.of(context).size.width>375)
            {
              showCommonErrorDialogWeb(context: context, message: errorMsg);
              print("this web part is calling");
            }
          else
            {
              showCommonErrorDialogMobile(context: context, message: errorMsg);
              print("mobile part is calling");
            }*/
    });

    notificationListCountState.isLoading = false;
    notifyListeners();
  }

  /// Delete all Notification
  Future<void> deleteNotificationListAPI(BuildContext context) async {
    deleteNotificationListState.isLoading = true;
    deleteNotificationListState.success = null;
    notifyListeners();

    final result = await notificationRepository.deleteNotificationList();

    result.when(success: (data) async {
      deleteNotificationListState.success = data;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    deleteNotificationListState.isLoading = false;
    notifyListeners();
  }

  /// Delete one  Notification
  Future<void> deleteNotificationAPI(BuildContext context, String notificationId) async {
    deleteNotificationState.isLoading = true;
    deleteNotificationState.success = null;
    notifyListeners();

    final result = await notificationRepository.deleteNotification(notificationId);

    result.when(success: (data) async {
      deleteNotificationState.success = data;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    deleteNotificationState.isLoading = false;
    notifyListeners();
  }

  String dateConverter(String myDate) {
    String date;
    DateTime convertedDate = DateFormat('dd MMM yyyy, hh:mm:ss').parse(myDate.toString());
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    final dateToCheck = convertedDate;
    final checkDate = DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    if (checkDate == today) {
      date = 'Today';
    } else if (checkDate == yesterday) {
      date = 'Yesterday';
    } else {
      date = 'Older';
    }

    return date;
  }
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
