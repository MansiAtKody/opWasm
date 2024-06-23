import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/cms/contract/cms_repository.dart';
import 'package:kody_operator/framework/repository/cms/model/cms_model.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/ui_state.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/show_common_error_dialog.dart';

final cmsController = ChangeNotifierProvider(
  (ref) => getIt<CmsController>(),
);

@injectable
class CmsController extends ChangeNotifier {
  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    if (isNotify) {
      cmsState.isLoading = false;
      cmsState.success = null;
      notifyListeners();
    }
  }

  String getCmsTitle(CMSType cmsType){
    switch(cmsType){
      case CMSType.termsCondition:
        return LocalizationStrings.keyTermsAndCondition.localized;
      case CMSType.privacyPolicy:
        return LocalizationStrings.keyPrivacyPolicy.localized;
      case CMSType.about:
        return LocalizationStrings.keyAboutUs.localized;
      case CMSType.faq:
        return LocalizationStrings.keyFaqs.localized;
      case CMSType.none:
        return LocalizationStrings.keyTermsAndCondition.localized;
    }
  }
/*
  /// ---------------------------- Api Integration ---------------------------------///
   */

  CMSRepository cmsRepository;

  CmsController(this.cmsRepository);

  var cmsState = UIState<CmsResponseModel>();
  ///Message displayed inside the common dialog
  String messageDisplayed ='';

  ///get profile detail api
  Future<void> getCMS(BuildContext context, CMSType cmsType) async {
    cmsState.success = null;
    cmsState.isLoading = true;
    notifyListeners();
    final result = await cmsRepository.getCmsApi(getStringFromEnumCMS(cmsType));
    result.when(
      success: (data) async {
        cmsState.success = data;
        cmsState.isLoading = false;
        messageDisplayed = cmsState.success?.message??'';
        notifyListeners();
      },
      failure: (NetworkExceptions error) {
        cmsState.isLoading = false;
        notifyListeners();
        String errorMsg = NetworkExceptions.getErrorMessage(error);
        messageDisplayed = errorMsg;
        showCommonErrorDialog(context: context, message: errorMsg);
      },
    );
    cmsState.isLoading = false;
    notifyListeners();
  }
}
