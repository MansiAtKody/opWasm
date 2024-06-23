import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/repository/service/service_name.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';

final servicesController = ChangeNotifierProvider(
  (ref) => getIt<ServicesController>(),
);

@injectable
class ServicesController extends ChangeNotifier {
  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = false;

    if (isNotify) {
      notifyListeners();
    }
  }

  /// List for the services
  List<ServicesOption> availableServices = [
    ServicesOption(
      iconName: AppAssets.svgSpeaker,
      title: LocalizationStrings.keyAnnouncement.localized,
      stackItem: const NavigationStackItem.announcement(),
      screenName: ScreenName.announcement,
    ),
    ServicesOption(
      iconName: AppAssets.svgDelete,
      title: LocalizationStrings.keyRecycleService.localized,
      stackItem: const NavigationStackItem.recycling(),
      screenName: ScreenName.recycle,
    ),
    ServicesOption(
      iconName: AppAssets.svgReceiveService,
      title: LocalizationStrings.keyReceiveService.localized,
      stackItem: const NavigationStackItem.sendService(isSendService: false),
      screenName: ScreenName.receiveService,
    ),
    ServicesOption(
      iconName: AppAssets.svgSendService,
      title: LocalizationStrings.keySendService.localized,
      stackItem: const NavigationStackItem.sendService(isSendService: true),
      screenName: ScreenName.sendService,
    )
  ];

  /// List for the services Mobile
  List<ServicesOption> availableServicesMobile = [
    ServicesOption(
      iconName: AppAssets.svgSpeaker,
      title: LocalizationStrings.keyAnnouncement.localized,
      stackItem: const NavigationStackItem.announcement(),
      screenName: ScreenName.announcement,
    ),
    ServicesOption(
      iconName: AppAssets.svgSendService,
      title: LocalizationStrings.keySendService.localized,
      stackItem: const NavigationStackItem.sendService(isSendService: true),
      screenName: ScreenName.sendService,
    ),
    ServicesOption(
      iconName: AppAssets.svgReceiveService,
      title: LocalizationStrings.keyReceiveService.localized,
      stackItem: const NavigationStackItem.sendService(isSendService: false),
      screenName: ScreenName.receiveService,
    ),
    ServicesOption(
      iconName: AppAssets.svgDelete,
      title: LocalizationStrings.keyRecycleService.localized,
      stackItem: const NavigationStackItem.recycling(),
      screenName: ScreenName.recycle,
    ),
  ];

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
