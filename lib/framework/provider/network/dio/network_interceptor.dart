import 'package:dio/dio.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/repository/authentication/model/common_response_model.dart';
import 'package:kody_operator/ui/routing/delegate.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';

InterceptorsWrapper networkInterceptor() {
  CancelToken cancelToken = CancelToken();
  return InterceptorsWrapper(
    onRequest: (request, handler) {
      request.cancelToken = cancelToken;
      handler.next(request);
    },
    onResponse: (response, handler) {
      CommonResponseModel commonResponseModel = commonResponseModelFromJson(response.toString());
      print(commonResponseModel.status);
      if (commonResponseModel.status == ApiEndPoints.apiStatus_500) {
        globalRef?.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.error(errorType: ErrorType.error403));
        return;
      }
      handler.next(response);
    },
    onError: (error, handler) {
      if (globalNavigatorKey.currentState?.context != null && error.response?.statusCode == ApiEndPoints.apiStatus_401) {
        globalRef?.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.error(errorType: ErrorType.error403));
        return;
      }
      ///This case is having some issues so it is left
      if (error.type == DioExceptionType.connectionError || error.type == DioExceptionType.unknown) {
        if (globalRef != null) {
          // globalRef?.read(navigationStackProvider).push(const NavigationStackItem.error(errorType: ErrorType.noInternet));
          return;
        }
      }
      handler.next(error);
    },
  );
}
