import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

final ticketChatController = ChangeNotifierProvider((ref) => getIt<TicketChatController>());

@injectable
class TicketChatController extends ChangeNotifier {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  ScrollController scrollController = ScrollController();

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    chatInputController.clear();
    isLoading = false;
    if (isNotify) {
      notifyListeners();
    }
  }

  TextEditingController chatInputController = TextEditingController();


  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */

  ///Progress Indicator
  bool isLoading = false;

  void updateLoadingStatus(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
