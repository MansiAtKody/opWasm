import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/authentication/contract/authentication_repository.dart';
import 'package:kody_operator/framework/repository/authentication/model/common_response_model.dart';
import 'package:kody_operator/framework/repository/profile/contract/profile_repository.dart';
import 'package:kody_operator/framework/repository/profile/model/profile_item_model.dart';
import 'package:kody_operator/framework/repository/profile/model/request_model/change_password_request_model.dart';
import 'package:kody_operator/framework/repository/profile/model/request_model/check_password_request_model.dart';
import 'package:kody_operator/framework/repository/profile/model/request_model/update_email_request_model.dart';
import 'package:kody_operator/framework/repository/profile/model/response_model/change_password_response_model.dart';
import 'package:kody_operator/framework/repository/profile/model/response_model/profile_detail_response_model.dart';
import 'package:kody_operator/framework/repository/profile/model/response_model/update_email_response_model.dart';
import 'package:kody_operator/framework/repository/profile/model/response_model/update_profile_image_response_model.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/framework/utility/session.dart';
import 'package:kody_operator/framework/utility/ui_state.dart';
import 'package:kody_operator/ui/profile/change_language.dart';
import 'package:kody_operator/ui/profile/web/helper/faq.dart';
import 'package:kody_operator/ui/profile/web/helper/personal_information_widget.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/const/form_validations.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:http_parser/http_parser.dart';
import 'package:kody_operator/ui/widgets/show_common_error_dialog.dart';
import 'package:path_provider/path_provider.dart';


final profileController = ChangeNotifierProvider(
  (ref) => getIt<ProfileController>(),
);

@injectable
class ProfileController extends ChangeNotifier {
  ///Dispose Controller
  void disposeController({bool isNotify = false}) {
    isLoading = true;
    selectedProfileItem = 0;
    profileImage = null;
    profileImageRemoved = false;
    initProfileList();
    initProfileInfoList();
    resetFormKey();
    if (isNotify) {
      notifyListeners();
    }
  }


  resetFormKey(){
    Future.delayed(const Duration(milliseconds: 10), () {
      changePasswordKey.currentState?.reset();
      passwordVerifyOtpKey.currentState?.reset();
    });
  }

  ///Clear all form controllers
  void clearFormData() {
    oldEmailController.clear();
    newEmailController.clear();
    newMobileController.clear();
    oldPasswordController.clear();
    newPasswordController.clear();
    mobileOtpController.clear();
    emailOtpController.clear();
    confirmNewPasswordController.clear();
    emailOtpController.clear();
    emailPasswordController.clear();
    mobilePasswordController.clear();
    passwordOtpController.clear();
    isEmailFieldsValid = false;
    isPasswordFieldsValid = false;
    isEmailVerifyOtpValid = false;
    isPasswordVerifyOtpValid = false;
    profileImageRemoved=false;
    tempEmail = '';
    tempPassword = '';
    disposeKeys();
    notifyListeners();
  }

  /// Dispose Keys
  void disposeKeys() {
    Future.delayed(const Duration(milliseconds: 100), () {
      changeEmailKey.currentState?.reset();
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      emailVerifyOtpKey.currentState?.reset();
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      mobileVerifyOtpKey.currentState?.reset();
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      changeMobileKey.currentState?.reset();
    });
  }

  /// Change Email Form Key
  final GlobalKey<FormState> changeEmailKey = GlobalKey<FormState>();

  /// Change Email Verify Otp Form Key
  final GlobalKey<FormState> emailVerifyOtpKey = GlobalKey<FormState>();

  /// Change Password Form Key
  final GlobalKey<FormState> changePasswordKey = GlobalKey<FormState>();

  /// Change Password verify Otp Form Key
  final GlobalKey<FormState> passwordVerifyOtpKey = GlobalKey<FormState>();

  /// Change Phone Form Key
  final GlobalKey<FormState> changeMobileKey = GlobalKey<FormState>();

  final GlobalKey<FormState> mobileVerifyOtpKey = GlobalKey<FormState>();

  /// Old Email Text Field Controller
  TextEditingController oldEmailController = TextEditingController();

  /// New Email Text Field Controller
  TextEditingController newEmailController = TextEditingController();

/*  /// Confirm New Email Text Field Controller
  TextEditingController confirmNewEmailController = TextEditingController();*/

  /// Old Password Text Field Controller
  TextEditingController oldPasswordController = TextEditingController();

  /// New Password Text Field Controller
  TextEditingController newPasswordController = TextEditingController();

  /// Confirm New Password Text Field Controller
  TextEditingController confirmNewPasswordController = TextEditingController();

  /// Email Verify OTP Text Field Controller
  TextEditingController emailOtpController = TextEditingController();

  /// Password Verify OTP Text Field Controller
  TextEditingController passwordOtpController = TextEditingController();

  /// Controller for the new mobile no
  TextEditingController newMobileController = TextEditingController();

/*  /// Controller for the confirm new mobile number
  TextEditingController confirmMobileController = TextEditingController();*/

  /// Mobile no verify otp controller
  TextEditingController mobileOtpController = TextEditingController();

  ///verify change email form
  bool isEmailFieldsValid = false;

  ///verify change password form
  bool isPasswordFieldsValid = false;

  ///verify change email otp form
  bool isEmailVerifyOtpValid = false;

  ///verify change password otp form
  bool isPasswordVerifyOtpValid = false;

  ///Check Validity of change Email Form
  ///Check Validity of change Email Form
  void checkIfEmailValid() {
    isEmailFieldsValid = (
        newEmailController.text != email &&
            validateEmail(newEmailController.text) == null && emailPasswordController.text!=''&& validateCurrentPassword(emailPasswordController.text)==null);
    notifyListeners();
  }

  /// Show password
  bool isShowNewPassword = false;

  /// Email Password Controller
  TextEditingController emailPasswordController = TextEditingController();

  /// Mobile password controller
  TextEditingController mobilePasswordController = TextEditingController();


  /// to change  password visibility
  void changePasswordVisibility() {
    isShowNewPassword = !isShowNewPassword;
    notifyListeners();
  }


  ///Check Validity of change Email Form
  void checkIfPasswordValid() {
    isPasswordFieldsValid =
    (validatePassword(oldPasswordController.text) == null /*&&
            oldPasswordController.text == password &&
            newPasswordController.text != password*/ &&
        validatePassword(newPasswordController.text) == null &&
        validatePassword(confirmNewPasswordController.text) == null &&
        newPasswordController.text == confirmNewPasswordController.text);
    notifyListeners();
  }

  ///Check if Change Email OTP is valid or not
  void checkIfOtpValid() {
    isEmailVerifyOtpValid = (validateOtp(emailOtpController.text) == null);
    notifyListeners();
  }

 /* /// check if new and confirm email are same
  bool checkIfNewEmailIsSameAsConfirmEmail() {
    return newEmailController.text == confirmNewEmailController.text;
  }
*/
  ///check if  new and confirm password are same
  bool checkIfNewPasswordIsSameAsConfirmPassword() {
    return newPasswordController.text == confirmNewPasswordController.text;
  }

  /// validate old password field
  String? verifyOldPassword() {
    if (password == oldPasswordController.text) {
      return null;
    }
    return LocalizationStrings.keyEnteredPasswordMustBeSame.localized;
  }

  /// validate old email field
  String? verifyOldEmail() {
    if (email == oldEmailController.text) {
      return null;
    }
    return LocalizationStrings.keyEnteredEmailMustBeSame.localized;
  }

  ///For OTP Verification Counter
  int counterSeconds = 119;
  Timer? counter;

  ///Start Counter function
  void startCounter() {
    counterSeconds = 60;
    const oneSec = Duration(seconds: 1);
    counter = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (counterSeconds == 0) {
          timer.cancel();
        } else {
          counterSeconds = counterSeconds - 1;
        }
        notifyListeners();
      },
    );
  }

  /// Return Counter Seconds as String
  String getCounterSeconds() {
    int minutes = (counterSeconds ~/ 60);
    int seconds = counterSeconds - (minutes * 60);
    if (seconds < 10) {
      return '0$minutes:0$seconds';
    }
    return '0$minutes:$seconds';
  }

  /// Return URL base on our input
  String getCmsUrl({required bool isPrivacyPolicy}) {
    return isPrivacyPolicy ? 'https://www.termsandcondiitionssample.com/live.php?token=0lH1DAxGF3vHMs4kroFlkLLGAk5JSwLJ' : 'https://www.termsandcondiitionssample.com/live.php?token=0lH1DAxGF3vHMs4kroFlkLLGAk5JSwLJ';
  }

  ///Account email
  String email = 'maharaj2@gmail.com';

  /// Store new email temporarily before otp verification
  String tempEmail = '';

  ///Store new password temporarily before verification
  String tempPassword = '';

  /// Account password
  String password = '1234567890';

  ///Used for navigating between different profile menus
  int selectedProfileItem = 0;

  ///Profile Image
  Uint8List? profileImage;
  bool profileImageRemoved = false;

  ///Update Temporary Email
  void updateTempEmail() {
    tempEmail = newEmailController.text;
    notifyListeners();
  }

  ///Update Email after OTP Verification
  void updateEmail() {
    email = tempEmail;
    notifyListeners();
  }

  ///Update Temporary Email
  void updateTempPassword() {
    tempPassword = newPasswordController.text;
    notifyListeners();
  }

  ///Update Email after OTP Verification
  void updatePassword() {
    password = tempPassword;
    notifyListeners();
  }

  /// update profile image
  void updateProfileImage(Uint8List? photoFile) {
    profileImage = photoFile!;
    notifyListeners();
  }

  /// update profile image status
  void updateProfileImageRemoveStatus(bool value) {
    profileImageRemoved = value;
    notifyListeners();
  }

  ///Profile List Tiles
  List<ProfileItem> profileList = [
    ProfileItem(
      tileTitle: LocalizationStrings.keyPersonalInfo.localized,
      svgAsset: AppAssets.svgPersonalInfo,
      screen: const PersonalInformationWidget(),
    ),
    ProfileItem(
      tileTitle: LocalizationStrings.keyLanguage.localized,
      svgAsset: AppAssets.svgLanguageIcon,
      screen: const ChangeLanguage(),
    ),
    ProfileItem(
      tileTitle: LocalizationStrings.keyFaq.localized,
      svgAsset: AppAssets.svgFaqIcon,
      screen: const Faq(),
    ),
  ];

  initProfileList() {
    profileList = [
      ProfileItem(
        tileTitle: LocalizationStrings.keyPersonalInfo.localized,
        svgAsset: AppAssets.svgPersonalInfo,
        screen: const PersonalInformationWidget(),
      ),
      ProfileItem(
        tileTitle: LocalizationStrings.keyLanguage.localized,
        svgAsset: AppAssets.svgLanguageIcon,
        screen: const ChangeLanguage(),
      ),
      ProfileItem(
        tileTitle: LocalizationStrings.keyFaq.localized,
        svgAsset: AppAssets.svgFaqIcon,
        screen: const Faq(),
      ),
    ];
  }

  ///Navigate between Profile Options
  void updateSelectedProfile(int index) {
    selectedProfileItem = index;
    notifyListeners();
  }

  ///Info title list
  List<ProfileItem> profileInfoTitleList = [
    ProfileItem(
      tileTitle: LocalizationStrings.keyPersonalInformation.localized,
      svgAsset: AppAssets.svgRoundProfile,
      stackItem: const NavigationStackItem.personalInformation(),
    ),
    ProfileItem(
      tileTitle: LocalizationStrings.keyFaq.localized,
      svgAsset: AppAssets.svgRoundFaq,
      stackItem: const NavigationStackItem.faq(),
    ),
    ProfileItem(
      tileTitle: LocalizationStrings.keySetting.localized,
      svgAsset: AppAssets.svgRoundSetting,
      stackItem: const NavigationStackItem.profileSetting(),
    ),
    ProfileItem(
      tileTitle: LocalizationStrings.keyChangeLanguage.localized,
      svgAsset: AppAssets.svgRoundLanguage,
      stackItem: const NavigationStackItem.changeLanguage(),
    ),
    ProfileItem(
      tileTitle: LocalizationStrings.keyPrivacyPolicies.localized,
      svgAsset: AppAssets.svgRoundPolicy,
      stackItem: const NavigationStackItem.cms(cmsType: CMSType.privacyPolicy),
    ),
    ProfileItem(
      tileTitle: LocalizationStrings.keyTermsAndCondition.localized,
      svgAsset: AppAssets.svgRoundTermsCondition,
      stackItem: const NavigationStackItem.cms(cmsType: CMSType.termsCondition),
    ),
  ];

  initProfileInfoList() {
    profileInfoTitleList = [
      ProfileItem(
        tileTitle: LocalizationStrings.keyPersonalInformation.localized,
        svgAsset: AppAssets.svgRoundProfile,
        stackItem: const NavigationStackItem.personalInformation(),
      ),
      ProfileItem(
        tileTitle: LocalizationStrings.keyFaq.localized,
        svgAsset: AppAssets.svgRoundFaq,
        stackItem: const NavigationStackItem.faq(),
      ),
      ProfileItem(
        tileTitle: LocalizationStrings.keySetting.localized,
        svgAsset: AppAssets.svgRoundSetting,
        stackItem: const NavigationStackItem.profileSetting(),
      ),
      ProfileItem(
        tileTitle: LocalizationStrings.keyChangeLanguage.localized,
        svgAsset: AppAssets.svgRoundLanguage,
        stackItem: const NavigationStackItem.changeLanguage(),
      ),
      ProfileItem(
        tileTitle: LocalizationStrings.keyPrivacyPolicies.localized,
        svgAsset: AppAssets.svgRoundPolicy,
        stackItem: const NavigationStackItem.cms(cmsType: CMSType.privacyPolicy),
      ),
      ProfileItem(
        tileTitle: LocalizationStrings.keyTermsAndCondition.localized,
        svgAsset: AppAssets.svgRoundTermsCondition,
        stackItem: const NavigationStackItem.cms(cmsType: CMSType.termsCondition),
      ),
    ];
  }

  List<int>? imageInUnit8List;

  ///upload profile Image file
  updateProfileImageInUnit(List<int> photoFile) async {
    imageInUnit8List = photoFile;
    notifyListeners();
  }
  //Uint8List? profileImage;


  /// For mobile Number
  bool isNewMobileValid = false;

  String tempNo = '';

  void updateTempNo(String value)
  {
    tempNo= value;
    notifyListeners();
  }

  ///Check Validity of change mobile function
  void validateNewMobile() {
    isNewMobileValid = (
        newMobileController.text != '' &&
            validateMobile(newMobileController.text) == null && mobilePasswordController.text!=''&& validateCurrentPassword(mobilePasswordController.text)==null);
    notifyListeners();
  }

 /* bool validateConfirmNumber() {
    return newMobileController.text == confirmMobileController.text;
  }*/

  /*
  /// ---------------------------- Api Integration ---------------------------------///
   */

  ///Progress Indicator
  bool isLoading = false;

  void updateLoadingStatus(bool value) {
    isLoading = value;
    notifyListeners();
  }

  ProfileRepository profileRepository;
  AuthenticationRepository authenticationRepository;
  ProfileController(this.profileRepository, this.authenticationRepository);

  var profileDetailState = UIState<ProfileDetailResponseModel>();
  var changePasswordState = UIState<ChangePasswordResponseModel>();
  var updateProfileImageState = UIState<UpdateProfileImageResponseModel>();

  ///get profile detail api
  Future<UIState<ProfileDetailResponseModel>> getProfileDetail(BuildContext context) async {
    profileDetailState.isLoading = true;
    profileDetailState.success = null;
    notifyListeners();

    final result = await profileRepository.getProfileDetail();
    result.when(success: (data) async {
      profileDetailState.success = data;
    },
        failure: (NetworkExceptions error) {
          String errorMsg = NetworkExceptions.getErrorMessage(error);
           showCommonErrorDialog(context: context, message: errorMsg);

        });
    profileDetailState.isLoading = false;

    notifyListeners();
    return profileDetailState;
  }

  ///Change password api
  Future<void> changePassword({required BuildContext context,required String oldPass,required String confirmPass}) async {
    changePasswordState.isLoading = true;
    changePasswordState.success = null;
    notifyListeners();

    ChangePasswordRequestModel requestModel = ChangePasswordRequestModel(oldPassword: oldPass,newPassword: confirmPass);
    String request = changePasswordRequestModelToJson(requestModel);


    final result = await profileRepository.changePassword(request);
    result.when(success: (data) async {
      changePasswordState.success = data;
    },
        failure: (NetworkExceptions error) {
          String errorMsg = NetworkExceptions.getErrorMessage(error);
           showCommonErrorDialog(context: context, message: errorMsg);

        });
    changePasswordState.isLoading = false;

    notifyListeners();
  }

  ///Update Profile Image api
  Future<void> updateProfileImageApi(BuildContext context, String uuid,bool isWeb) async {
    updateProfileImageState.isLoading = true;
    updateProfileImageState.success = null;
    notifyListeners();

    FormData? formData;

    if(isWeb==true){
      MultipartFile profilePic = MultipartFile.fromBytes(
          profileImage!,
          filename: '${DateTime.now().toIso8601String()}.jpeg',
          contentType: MediaType('image', 'jpeg'));

      formData = FormData.fromMap({
        'file': profilePic,
      });
    }
    else{
      final tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}/profile.png').create();
      file.writeAsBytesSync(profileImage!);
      // File file = File.fromRawPath(profileImage!);
      MultipartFile profilePic = await MultipartFile.fromFile(
          file.path,
          filename: '${DateTime.now().toIso8601String()}.jpeg',
          contentType: MediaType('image', 'jpeg'));

      formData = FormData.fromMap({
        'ic_notification_icon': profilePic,
      });
    }
    final result = await profileRepository.updateProfileImageApi(formData,Session.getUuid());
    result.when(success: (data) async {
      updateProfileImageState.success = data;
    },
        failure: (NetworkExceptions error) {
          String errorMsg = NetworkExceptions.getErrorMessage(error);
           showCommonErrorDialog(context: context, message: errorMsg);

        });
    updateProfileImageState.isLoading = false;


    notifyListeners();
  }

  /// Update email state
  var updateEmailState = UIState<UpdateEmailResponseModel>();

  ///Change email api
  Future<void> updateEmailMobileApi(BuildContext context,bool isEmail,{String? mobileNo,String? email,required String otp,required String password}) async {
    updateEmailState.isLoading = true;
    updateEmailState.success = null;
    notifyListeners();

    UpdateEmailRequestModel requestModelEmail = UpdateEmailRequestModel(
      email:email??newEmailController.text,
      otp: otp,
      password:password,
    );

    UpdateEmailRequestModel requestModelMobile = UpdateEmailRequestModel(
        contactNumber:mobileNo??newMobileController.text,
        otp: otp,
        email:null,
        password:password
    );
    String request = updateEmailRequestModelToJson(isEmail?requestModelEmail:requestModelMobile);

    final result = await profileRepository.updateEmailMobile(request,isEmail);
    result.when(success: (data) async {
      updateEmailState.success = data;
    },
        failure: (NetworkExceptions error) {
          String errorMsg = NetworkExceptions.getErrorMessage(error);
           showCommonErrorDialog(context: context, message: errorMsg);

        });
    updateEmailState.isLoading = false;

    notifyListeners();
  }

  var checkPasswordState = UIState<CommonResponseModel>();

  ///Check password API
  Future<void> checkPassword(BuildContext context,String value) async {
    checkPasswordState.isLoading = true;
    checkPasswordState.success = null;
    notifyListeners();

    CheckPasswordRequestModel checkPasswordRequestModel = CheckPasswordRequestModel(
      password:value,
    );
    String request = checkPasswordRequestModelToJson(checkPasswordRequestModel);

    final result = await profileRepository.checkPassword(request);
    result.when(success: (data) async {
      checkPasswordState.success = data;
    },
        failure: (NetworkExceptions error) {
          String errorMsg = NetworkExceptions.getErrorMessage(error);
          showCommonErrorDialog(context: context, message: errorMsg);
        });
    checkPasswordState.isLoading = false;

    notifyListeners();
  }

  /// Delete Operator
  var deleteOperatorState = UIState<CommonResponseModel>();

  ///deleteOperatorApi api
  Future<void> deleteOperatorApi(BuildContext context,String uuid) async {
    deleteOperatorState.isLoading = true;
    deleteOperatorState.success = null;
    notifyListeners();

    final result = await authenticationRepository.deleteOperatorApi(uuid);
    result.when(success: (data) async {
      deleteOperatorState.success = data;
    },
        failure: (NetworkExceptions error) {
          String errorMsg = NetworkExceptions.getErrorMessage(error);
          showCommonErrorDialog(context: context, message: errorMsg);
        });
    deleteOperatorState.isLoading = false;

    notifyListeners();
  }

  ///logout operator api
  UIState<CommonResponseModel> deleteDeviceIdState = UIState<CommonResponseModel>();
  /// delete Device FCM token
  Future<void> deleteDeviceTokenApi() async {
    deleteDeviceIdState.isLoading = true;
    deleteDeviceIdState.success = null;
    notifyListeners();

    final result = await authenticationRepository.deleteDeviceTokenApi(Session.getNewFCMToken());

    result.when(success: (data) async {
      deleteDeviceIdState.success = data;
    }, failure: (NetworkExceptions error) {
      String errorMsg = NetworkExceptions.getErrorMessage(error);
      print('Error ---> $errorMsg');
      // showCommonErrorDialog(context: context, message: errorMsg);
    });

    deleteDeviceIdState.isLoading = false;
    notifyListeners();
  }

}
