import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/provider/network/dio/sdk_error_response.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/authentication/model/common_response_model.dart';
import 'package:kody_operator/framework/repository/authentication/model/start_program_response_model.dart';
import 'package:kody_operator/framework/repository/coffee_selection/contract/coffee_selection_repository.dart';
import 'package:kody_operator/framework/repository/coffee_selection/model/coffee_list_model.dart';
import 'package:kody_operator/framework/repository/coffee_selection/model/refresh_token_response_model.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/framework/utility/ui_state.dart';
import 'package:kody_operator/ui/widgets/show_common_error_dialog.dart';

final selectCoffeeController = ChangeNotifierProvider(
  (ref) => getIt<SelectCoffeeController>(),
);

@injectable
class SelectCoffeeController extends ChangeNotifier {
  /// Glass Selection
  bool isGlassSelected = false;

  /// Dasher Selection
  bool isDasherSelected = false;

  /// Update Glass Selection
  void updateGlassSelection(bool isSelected) {
    if (isDasherSelected) {
      isDasherSelected = false;
    }
    isGlassSelected = isSelected;
    notifyListeners();
  }

  /// Update Dasher Selection
  void updateDasherSelection(bool isSelected) {
    if (isGlassSelected) {
      isGlassSelected = false;
    }
    isDasherSelected = isSelected;
    notifyListeners();
  }

  double loaderValue = 0;

  updateLoaderValue(int value) {
    loaderValue = double.parse((value / 100).toString());
    notifyListeners();
  }

  resetLoaderValue() {
    loaderValue = 0;
    notifyListeners();
  }

  /// Coffee List
  List<CoffeeListModel> coffeeList = [
    CoffeeListModel(id: '1', name: 'Ristretto coffee', json: '''{
   "data": {
       "key": "ConsumerProducts.CoffeeMaker.Program.Beverage.Ristretto",
       "options": [
               {
                   "key": "ConsumerProducts.CoffeeMaker.Option.CoffeeTemperature",
                   "value": "ConsumerProducts.CoffeeMaker.EnumType.CoffeeTemperature.94C"
               },
               {
                   "key": "ConsumerProducts.CoffeeMaker.Option.BeanAmount",
                   "value": "ConsumerProducts.CoffeeMaker.EnumType.BeanAmount.Normal"
               },
               {
                   "key": "ConsumerProducts.CoffeeMaker.Option.FillQuantity",
                   "value": 20,
                   "unit": "ml"
               },
               {
                   "key": "ConsumerProducts.CoffeeMaker.Option.MultipleBeverages",
                   "value": false
               }
           ]
   }
}
'''),
    CoffeeListModel(id: '2', name: 'Espresso', json: '''{
   "data": {
       "key": "ConsumerProducts.CoffeeMaker.Program.Beverage.Espresso",
       "options": [
               {
                   "key": "ConsumerProducts.CoffeeMaker.Option.CoffeeTemperature",
                   "value": "ConsumerProducts.CoffeeMaker.EnumType.CoffeeTemperature.94C"
               },
               {
                   "key": "ConsumerProducts.CoffeeMaker.Option.BeanAmount",
                   "value": "ConsumerProducts.CoffeeMaker.EnumType.BeanAmount.Normal"
               },
               {
                   "key": "ConsumerProducts.CoffeeMaker.Option.FillQuantity",
                   "value": 50,
                   "unit": "ml"
               },
               {
                   "key": "ConsumerProducts.CoffeeMaker.Option.MultipleBeverages",
                   "value": false
               }
           ]
   }
}
'''),
    CoffeeListModel(id: '3', name: 'Espresso Macchiato', json: '''{
   "data": {
       "key": "ConsumerProducts.CoffeeMaker.Program.Beverage.Espresso",
       "options": [
               {
                   "key": "ConsumerProducts.CoffeeMaker.Option.CoffeeTemperature",
                   "value": "ConsumerProducts.CoffeeMaker.EnumType.CoffeeTemperature.94C"
               },
               {
                   "key": "ConsumerProducts.CoffeeMaker.Option.BeanAmount",
                   "value": "ConsumerProducts.CoffeeMaker.EnumType.BeanAmount.Normal"
               },
               {
                   "key": "ConsumerProducts.CoffeeMaker.Option.FillQuantity",
                   "value": 60,
                   "unit": "ml"
               },
               {
                   "key": "ConsumerProducts.CoffeeMaker.Option.MultipleBeverages",
                   "value": false
               }
           ]
   }
}
'''),
    CoffeeListModel(id: '4', name: 'Cappuccino', json: '''{
   "data": {
       "key": "ConsumerProducts.CoffeeMaker.Program.Beverage.Cappuccino",
       "options": [
           {
               "key": "ConsumerProducts.CoffeeMaker.Option.CoffeeTemperature",
               "value": "ConsumerProducts.CoffeeMaker.EnumType.CoffeeTemperature.94C"
           },
           {
               "key": "ConsumerProducts.CoffeeMaker.Option.BeanAmount",
               "value": "ConsumerProducts.CoffeeMaker.EnumType.BeanAmount.Normal"
           },
           {
               "key": "ConsumerProducts.CoffeeMaker.Option.FillQuantity",
               "value": 140,
               "unit": "ml"
           },
           {
               "key": "ConsumerProducts.CoffeeMaker.Option.MultipleBeverages",
               "value": false
           }
       ]
   }
}
'''),
    CoffeeListModel(id: '5', name: 'Latte', json: '''{
   "data": {
       "key": "ConsumerProducts.CoffeeMaker.Program.Beverage.CaffeLatte",
       "options": [
               {
                   "key": "ConsumerProducts.CoffeeMaker.Option.CoffeeTemperature",
                   "value": "ConsumerProducts.CoffeeMaker.EnumType.CoffeeTemperature.90C"
               },
               {
                   "key": "ConsumerProducts.CoffeeMaker.Option.BeanAmount",
                   "value": "ConsumerProducts.CoffeeMaker.EnumType.BeanAmount.Normal"
               },
               {
                   "key": "ConsumerProducts.CoffeeMaker.Option.FillQuantity",
                   "value": 280,
                   "unit": "ml"
               },
               {
                   "key": "ConsumerProducts.CoffeeMaker.Option.MultipleBeverages",
                   "value": false
               }
           ]
           }
           }
'''),
    CoffeeListModel(id: '6', name: 'Latte Macchiato', json: '''{
   "data": {
       "key": "ConsumerProducts.CoffeeMaker.Program.Beverage.LatteMacchiato",
       "options": [
               {
                   "key": "ConsumerProducts.CoffeeMaker.Option.CoffeeTemperature",
                   "value": "ConsumerProducts.CoffeeMaker.EnumType.CoffeeTemperature.90C"
               },
               {
                   "key": "ConsumerProducts.CoffeeMaker.Option.BeanAmount",
                   "value": "ConsumerProducts.CoffeeMaker.EnumType.BeanAmount.Normal"
               },
               {
                   "key": "ConsumerProducts.CoffeeMaker.Option.FillQuantity",
                   "value": 280,
                   "unit": "ml"
               },
               {
                   "key": "ConsumerProducts.CoffeeMaker.Option.MultipleBeverages",
                   "value": false
               }
           ]
   }
   }
'''),
    CoffeeListModel(id: '7', name: 'Coffee', json: '''
   "data": {
       "key": "ConsumerProducts.CoffeeMaker.Program.Beverage.Coffee",
            "options": [
                {
                    "key": "ConsumerProducts.CoffeeMaker.Option.CoffeeTemperature",
                    "value": "ConsumerProducts.CoffeeMaker.EnumType.CoffeeTemperature.94C"
                },
                {
                    "key": "ConsumerProducts.CoffeeMaker.Option.BeanAmount",
                    "value": "ConsumerProducts.CoffeeMaker.EnumType.BeanAmount.Normal"
                },
                {
                    "key": "ConsumerProducts.CoffeeMaker.Option.FillQuantity",
                    "value": 130,
                    "unit": "ml"
                },
                {
                    "key": "ConsumerProducts.CoffeeMaker.Option.MultipleBeverages",
                    "value": false
                }
            ]
   }
'''),
  ];

  bool isLoading = false;

  /// Selected Coffee Index
  int? selectedCoffeeIndex;

  /// Update Coffee Index
  void updateSelectedCoffee(int index) {
    selectedCoffeeIndex = index;
    notifyListeners();
  }

  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = false;
    selectedCoffeeIndex = null;
    isGlassSelected = false;
    isDasherSelected = false;
    if (isNotify) {
      notifyListeners();
    }
  }

  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */

  CoffeeSelectionRepository coffeeSelectionRepository;

  SelectCoffeeController(this.coffeeSelectionRepository);

  /// Coffee SDK
  UIState<CommonResponseModel> selectCoffeeState = UIState<CommonResponseModel>();
  UIState<CommonResponseModel> activeCoffeeState = UIState<CommonResponseModel>();
  UIState<RefreshTokenResponseModel> refreshTokenState = UIState<RefreshTokenResponseModel>();

  /// Robot
  UIState<StartProgramResponseModel> startProgramState = UIState<StartProgramResponseModel>();
  UIState<StartProgramResponseModel> startDasherState = UIState<StartProgramResponseModel>();
  UIState<StartProgramResponseModel> stopProgramState = UIState<StartProgramResponseModel>();

  /// Select Program API
  Future<void> selectProgramAPI(BuildContext context, {String? request}) async {
    selectCoffeeState.isLoading = true;
    selectCoffeeState.success = null;
    notifyListeners();

    final result = await coffeeSelectionRepository.selectProgramAPI(request ?? coffeeList[selectedCoffeeIndex!].json);

    result.when(success: (data) async {
      selectCoffeeState.success = data;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      error.whenOrNull(notFound: (String reason, Response? response) {
        SdkErrorResponse errorResponse = sdkErrorResponseFromJson(response.toString());
        errorMsg = errorResponse.error?.description ?? '';
      });
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    selectCoffeeState.isLoading = false;
    notifyListeners();
  }

  /// Refresh Token Api
  Future<void> refreshTokenApi(BuildContext context) async {
    refreshTokenState.isLoading = true;
    refreshTokenState.success = null;
    notifyListeners();

    final result = await coffeeSelectionRepository.refreshTokenApi();

    result.when(success: (data) async {
      refreshTokenState.success = data;
      Session.saveLocalData(keyCoffeeAccessToken, refreshTokenState.success?.accessToken);
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      error.whenOrNull(notFound: (String reason, Response? response) {
        SdkErrorResponse errorResponse = sdkErrorResponseFromJson(response.toString());
        errorMsg = errorResponse.error?.description ?? '';
      });
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    refreshTokenState.isLoading = false;
    notifyListeners();
  }

  /// Active Program API
  Future<void> activeProgramAPI(BuildContext context, {String? request}) async {
    activeCoffeeState.isLoading = true;
    activeCoffeeState.success = null;
    notifyListeners();

    final result = await coffeeSelectionRepository.activeProgramAPI(request ?? coffeeList[selectedCoffeeIndex!].json);

    result.when(success: (data) async {
      activeCoffeeState.success = data;
      if (activeCoffeeState.success?.status == ApiEndPoints.apiStatus_200) {
        disposeController(isNotify: true);
      }
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      error.whenOrNull(notFound: (String reason, Response? response) {
        SdkErrorResponse errorResponse = sdkErrorResponseFromJson(response.toString());
        errorMsg = errorResponse.error?.description ?? '';
      });
      showCommonErrorDialog(context: context, message: errorMsg);
    });
    activeCoffeeState.isLoading = false;
    notifyListeners();
  }

  /// Start Program API
  Future<void> startProgramAPI(BuildContext context) async {
    startProgramState.isLoading = true;
    startProgramState.success = null;
    notifyListeners();

    final result = await coffeeSelectionRepository.startVoltageAPI();

    result.when(success: (data) async {
      startProgramState.success = data;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      error.whenOrNull(notFound: (String reason, Response? response) {
        SdkErrorResponse errorResponse = sdkErrorResponseFromJson(response.toString());
        errorMsg = errorResponse.error?.description ?? '';
      });
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    startProgramState.isLoading = false;
    notifyListeners();
  }

  /// Start Program API
  Future<void> startDasherAPI(BuildContext context) async {
    startDasherState.isLoading = true;
    startDasherState.success = null;
    notifyListeners();

    final result = await coffeeSelectionRepository.startDasherAPI();

    result.when(success: (data) async {
      startDasherState.success = data;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      error.whenOrNull(notFound: (String reason, Response? response) {
        SdkErrorResponse errorResponse = sdkErrorResponseFromJson(response.toString());
        errorMsg = errorResponse.error?.description ?? '';
      });
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    startDasherState.isLoading = false;
    notifyListeners();
  }

  /// Stop Program API
  Future<void> stopProgramAPI(BuildContext context) async {
    stopProgramState.isLoading = true;
    stopProgramState.success = null;
    notifyListeners();

    final result = await coffeeSelectionRepository.emergencyStopAPI();

    result.when(success: (data) async {
      stopProgramState.success = data;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      error.whenOrNull(notFound: (String reason, Response? response) {
        SdkErrorResponse errorResponse = sdkErrorResponseFromJson(response.toString());
        errorMsg = errorResponse.error?.description ?? '';
      });
      showCommonErrorDialog(context: context, message: errorMsg);
    });

    stopProgramState.isLoading = false;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
