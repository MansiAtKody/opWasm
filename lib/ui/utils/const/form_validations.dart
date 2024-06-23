//
// import 'package:kody_operator/ui/utils/theme/app_strings.dart';
//
import 'package:kody_operator/framework/repository/dynamic_form/repository/model/dynamic_form_response_model.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/theme/app_strings.dart';

String? validateText(String? value, String error) {
  if (value == null || value.trim().isEmpty || value.trim().length < 3) {
    return error;
  } else {
    return null;
  }
}


RegExp mobileRegEx = RegExp(r'^[1-9][0-9]');

String? validateMobile(String? value) {

// Indian Mobile number are of 10 digit only
  if (value == null || value.isEmpty) {
    return LocalizationStrings.keyYourNumberRequiredValidation.localized;
  }
  else if(value.trim().length <10)
    {
      return LocalizationStrings.keyYourNumberLengthValidation.localized;
    }
  else if (!mobileRegEx.hasMatch(value)) {
    return LocalizationStrings.keyMobileNumberIsInvalid.localized;
  } else {
    return null;
  }
}


/// Validation function for the validate email
String? validateEmail(String? value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern.toString());
  if (value == null || value.trim().isEmpty) {
    return LocalizationStrings.keyEmailRequired.localized;
  } else if (!regex.hasMatch(value)) {
    return LocalizationStrings.keyInvalidEmailValidation.localized;
  } else {
    return null;
  }
}

/// Validating the password
String? validatePassword(String? value) {
  if (value == null || value.trim().isEmpty) {
    return LocalizationStrings.keyPasswordRequired.localized;
  } else if (value.length < 8 || value.length > 16) {
    return LocalizationStrings.keyInvalidPasswordValidation.localized;
  } else {
    return null;
  }
}
String? validateCurrentPassword(String? value) {
  if (value == null || value.trim().isEmpty) {
    return LocalizationStrings.keyCurrentPasswordRequired.localized;
  } else if (value.length < 8 || value.length > 16) {
    return LocalizationStrings.keyInvalidCurrentPasswordValidation.localized;
  } else {
    return null;
  }
}


///validate new password
String? validateNewPassword(String? value) {
  if (value == null || value.trim().isEmpty) {
    return LocalizationStrings.keyNewPasswordRequired.localized;
  } else if (value.length < 8 || value.length > 16) {
    return LocalizationStrings.keyInvalidNewPasswordValidation.localized;
  } else {
    return null;
  }
}
/// Validate confirm password
String? validateConfirmPassword(String? value,String? newPasswordText) {
  if (value == null || value.trim().isEmpty) {
    return LocalizationStrings.keyConfirmPasswordRequired.localized;
  }
  else if (value.length < 8 || value.length > 16) {
    return LocalizationStrings.keyInvalidConfirmPasswordValidation.localized;
  }
  else if (value !=newPasswordText) {
    return LocalizationStrings.keyConfirmPasswordMustAsPassword.localized;
  }
  else {
    return null;
  }
}

String? validateConfirmPasswordResetPass(String? value) {
  if (value == null || value.trim().isEmpty) {
    return LocalizationStrings.keyConfirmPasswordRequired.localized;
  } else if (value.length < 8 || value.length > 16) {
    return LocalizationStrings.keyInvalidConfirmPasswordValidation.localized;
  } else {
    return null;
  }
}

String? validateOtp(String? value) {
  if (value!.isEmpty) {
    return LocalizationStrings.keyEnterOtp.localized;
  } else if (value.trim().length < otpLength) {
    return LocalizationStrings.keyEnterValidOtp.localized;
  } else {
    return null;
  }
}

String? validateDropDown(String? value, String? errorMessage) {
  if (value == null || value.isEmpty) {
    return errorMessage;
  }else {
    return null;
  }
}

String? dynamicValidation(Field field, String? value) {
  Pattern? pattern = field.validations?.pattern;
  RegExp regex = RegExp(pattern.toString());
  if(field.fieldName == "emailId"){
    return validateEmail(value);
  }
  if (value == null || (value.isEmpty)) {
    if (field.validations?.required ?? false) {
      return field.messages?.requiredMessage?.localized;
    }
    return null;
  } else if (value.length < (field.validations?.min ?? 0)) {
    return '${field.messages?.minMessage?.localized} ${field.validations?.min}';
  } else if (value.length > (field.validations?.max ?? 0)) {
    return '${field.messages?.maxMessage?.localized} ${field.validations?.max}';
  } else if (pattern != null) {
    if (!regex.hasMatch(value)) {
      return field.messages?.invalidMessage?.localized;
    } else {
      return null;
    }
  }
  return null;
}
