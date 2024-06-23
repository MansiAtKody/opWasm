// import 'package:injectable/injectable.dart';
// import 'package:kte/framework/dependency_injection/inject.dart';
// import 'package:kte/framework/repository/address/model/location_model.dart';
// import 'package:kte/ui/utils/theme/theme.dart';
//
// final locationController = ChangeNotifierProvider(
//   (ref) => getIt<LocationController>(),
// );
//
// @injectable
// class LocationController extends ChangeNotifier {
//   ///Dispose Controller
//   void disposeController({bool isNotify = false}) {
//     isLoading = false;
//     selectedLocationIndex = 0;
//     // selectedLocationTempIndex = 0;
//     if (isNotify) {
//       notifyListeners();
//     }
//   }
//
//   int selectedLocationIndex = 0;
//
//   // int selectedLocationTempIndex = 0;
//
//   List<LocationModel> locationList = [
//     LocationModel(icon: AppAssets.svgUiUx, name: 'UI/UX Team', isDefault: true),
//     LocationModel(icon: AppAssets.svgPhp, name: 'PHP Team'),
//     LocationModel(icon: AppAssets.svgMobile, name: 'Mobile Team'),
//     LocationModel(icon: AppAssets.svgBd, name: 'Business Development Team'),
//   ];
//
//   /// call on continue button
//   void updateSelectedLocation(int index) {
//     selectedLocationIndex = index;
//     notifyListeners();
//   }
//
//   // /// call on radio click, close button bottomSheet
//   // void updateSelectedTempLocation(int index) {
//   //   selectedLocationTempIndex = index;
//   //   notifyListeners();
//   // }
//
//   /*
//   /// ---------------------------- Api Integration ---------------------------------///
//    */
//
//   ///Progress Indicator
//   bool isLoading = false;
//
//   void updateLoadingStatus(bool value) {
//     isLoading = value;
//     notifyListeners();
//   }
// }
