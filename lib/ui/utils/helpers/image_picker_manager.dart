import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_permission_widget.dart';
import 'package:permission_handler/permission_handler.dart';

/*
Required permissions for iOS
NSCameraUsageDescription :- ${PRODUCT_NAME} is require camera permission to choose user profile photo.
NSPhotoLibraryUsageDescription :- ${PRODUCT_NAME} is require photos permission to choose user profile photo.

Required permissions for Android
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.CAMERA"/>

<!--Image Cropper-->
       <activity
           android:name="com.yalantis.ucrop.UCropActivity"
           android:exported="true"
           android:screenOrientation="portrait"
           android:theme="@style/Theme.AppCompat.Light.NoActionBar"/>
* */

class ImagePickerManager {
  ImagePickerManager._privateConstructor();

  static final ImagePickerManager instance = ImagePickerManager._privateConstructor();

  var imgSelectOption = {'camera', 'gallery', 'document', 'remove'};
  String selectionType = '';

  /*
  Open Picker
  Usage:- File? file = await ImagePickerManager.instance.openPicker(context);
  * */
  Future<Uint8List?> openPicker(BuildContext mainContext, {double? ratioX, double? ratioY}) async {
    String type = '';
    WebUiSettings webUiSettings = WebUiSettings(
      context: mainContext,
      presentStyle: CropperPresentStyle.page,
      boundary: CroppieBoundary(
        width: (mainContext.width).toInt(),
        height: (mainContext.height * 0.8).toInt(),
      ),
      translations: const WebTranslations(
        title: 'Crop Image',
        rotateLeftTooltip: 'Rotate Left',
        rotateRightTooltip: 'Rotate Right',
        cancelButton: 'Cancel',
        cropButton: 'Crop',
      ),
      enableResize: true,
      enableZoom: true,
      enableOrientation: false,
      showZoomer: true,
      barrierColor: AppColors.black,
    );


    if (!kIsWeb) {
      await showModalBottomSheet(
          context: mainContext,
          backgroundColor: AppColors.transparent,
          barrierColor: AppColors.black.withOpacity(0.3),
          builder: (BuildContext context) {
            return StatefulBuilder(builder: (context, state) {
              return Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: Container(
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.black171717,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.r),
                                topRight: Radius.circular(20.r),
                              )),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () async {
                                  Navigator.pop(context);
                                  type = imgSelectOption.elementAt(0);
                                  selectionType = imgSelectOption.elementAt(0);
                                  await checkPermissions(mainContext, permission: Permission.camera);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 25.h, bottom: 20.h),
                                  alignment: Alignment.center,
                                  child: Text(
                                    LocalizationStrings.keyTakePhoto.localized,
                                    style: TextStyles.regular.copyWith(color: AppColors.white, fontSize: 18.sp),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                                child: Divider(height: 1, color: AppColors.greyBEBEBE.withOpacity(0.2)),
                              ),
                              InkWell(
                                onTap: () async {
                                  Navigator.pop(context);
                                  type = imgSelectOption.elementAt(1);
                                  selectionType = imgSelectOption.elementAt(1);
                                  await checkPermissions(mainContext, permission: Permission.photos);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                                  alignment: Alignment.center,
                                  child: Text(
                                    LocalizationStrings.keyUploadFromGallery.localized,
                                    style: TextStyles.regular.copyWith(color: AppColors.white, fontSize: 18.sp),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                                child: Divider(height: 1, color: AppColors.greyBEBEBE.withOpacity(0.2)),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  type = imgSelectOption.elementAt(3);
                                  selectionType = imgSelectOption.elementAt(3);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 20.h, bottom: 25.h),
                                  alignment: Alignment.center,
                                  child: Text(
                                    LocalizationStrings.keyRemoveProfilePicture.localized,
                                    style: TextStyles.regular.copyWith(color: AppColors.white, fontSize: 18.sp),
                                  ),
                                ),
                              ),
                              CommonButton(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                buttonText: LocalizationStrings.keyCancel.localized,
                                buttonTextColor: AppColors.white,
                                isButtonEnabled: true,
                                buttonTextStyle: TextStyles.regular.copyWith(
                                  fontSize: 18.sp,
                                  color: AppColors.white,
                                ),
                                buttonEnabledColor: AppColors.blue,
                              ).paddingOnly(bottom: 15.h, left: 20.w, right: 20.w),
                            ],
                          ),
                        ).paddingOnly(
                          top: 30.h,
                        ),
                      )));
            });
          });
    } else {
      type = imgSelectOption.elementAt(1);
      selectionType = imgSelectOption.elementAt(1);
    }
    // Uint8List pickedImage = await ImagePicker().pickImage(source: source)

    Uint8List? pickedImage;
    XFile? fileProfile;
    if (type.isNotEmpty) {
      if (imgSelectOption.elementAt(3) == type) {
        fileProfile = null;
      } else {
        if (type != '') {
          fileProfile = (await ImagePicker().pickImage(source: (imgSelectOption.elementAt(0) == type) ? ImageSource.camera : ImageSource.gallery));
        }
      }
    }

    if (fileProfile != null && fileProfile.path != '') {
      CroppedFile? cropImage = await ImageCropper().cropImage(
        sourcePath: fileProfile.path,
        aspectRatio: CropAspectRatio(ratioX: ratioX ?? 1, ratioY: ratioY ?? 1),
        uiSettings: [
          webUiSettings,
        ],
      );

      if (cropImage != null && cropImage.path != '') {
        pickedImage = await cropImage.readAsBytes();
      }
    }
    return pickedImage;
  }

  Future checkPermissions(BuildContext context, {required Permission permission}) async {
    if (!kIsWeb) {
      if (await permission.status != PermissionStatus.granted) {
        await permission.request().then((permissionResult) {
          if (permissionResult.isPermanentlyDenied) {
            /// Widget Dialog for Image Picker
            showWidgetDialogIP(context, CommonPermissionWidget(
              onPositiveButtonTap: () async {
                openAppSettings();
              },
            ), () => null);
          }
        });
      }
    }
  }

/*
  Open Multi Picker
  Usage:- Future<List<File>?> files = ImagePickerManager.instance.openMultiPicker(context);
  * */
// Future<List<File>?> openMultiPicker(BuildContext context,
//     {int maxAssets = 3}) async {
//   final List<AssetEntity>? result = await AssetPicker.pickAssets(
//     context,
//     pickerConfig: AssetPickerConfig(
//       maxAssets: maxAssets,
//       themeColor: AppColors.primary,
//       requestType: RequestType.image,
//     ),
//   );
//
//   List<File> files = [];
//   if ((result ?? []).isNotEmpty) {
//     for (final AssetEntity entity in result!) {
//       final File? file = await entity.file;
//       files.add(file!);
//     }
//   }
//   return files;
// }

  ///Handle Document After Picker
// handleDocumentAfterPicker(BuildContext context, Function(List<File>) resultBlock) async {
//   List<File> files = [];
//   FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true,type: FileType.custom, allowedExtensions: ['pdf', 'doc', 'docx'],);
//
//   if(result != null) {
//     // files = result.paths.map((path) => PickedFile(path ?? "")).toList();
//     files = result.paths.map((path) => File(path ?? "")).toList();
//   }
//   resultBlock(files);
// }
}
