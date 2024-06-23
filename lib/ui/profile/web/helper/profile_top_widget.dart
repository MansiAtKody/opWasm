import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/profile/profile_controller.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/helpers/image_picker_manager.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class ProfileTopWidget extends StatelessWidget with BaseStatelessWidget {
  const ProfileTopWidget({
    super.key,
  });

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final profileWatch = ref.watch(profileController);
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ///Display Profile Image
              profileWatch.profileImageRemoved
                  ? SizedBox.fromSize(
                size: Size.fromRadius(35.r),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(35.r),
                  child: Container(
                    color: AppColors.white,
                    child: CommonSVG(
                      svgColor: AppColors.grey7D7D7D,
                      strIcon: AppAssets.svgProfile,
                      height: 20.h,
                      width: 20.h,
                    ),
                  ),
                ),
              ).paddingOnly(right: 20.w)
                  : profileWatch.profileImage == null
                  ? CacheImage(
                imageURL:
                profileWatch.profileDetailState.success?.data?.profileImage ?? 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80',
                height: 67.h,
                width: 67.h,
                bottomRightRadius: 65.r,
                bottomLeftRadius: 65.r,
                topLeftRadius: 65.r,
                topRightRadius: 65.r,
              ).paddingOnly(right: 20.w)
                  : SizedBox.fromSize(
                size: Size.fromRadius(45.r),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(45.r),
                  child: Image.memory(
                    profileWatch.profileImage!,
                    fit: BoxFit.fill,
                  ),
                ),
              ).paddingOnly(right: 20.w),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: context.width * 0.4),
                    child: Text(
                      profileWatch.profileDetailState.success?.data?.name ?? '',
                      style: TextStyles.medium.copyWith(
                        fontSize: 20.sp,
                        color: AppColors.black171717,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ).paddingOnly(bottom: 3.h),
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: context.width * 0.4),
                    child: CommonText(
                      title: profileWatch.profileDetailState.success?.data?.email ?? '',
                      textStyle: TextStyles.regular.copyWith(
                        fontSize: 18.sp,
                        color: AppColors.black.withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          ///Update or remove Image Button
          InkWell(
            ///Show Image Picker on tap
              onTap: () async {
                // FilePickerResult? selectedFile = await FilePicker.platform.pickFiles();
                // if (selectedFile != null) {
                //   List<int> fileBytes = selectedFile.files.first.bytes??[];
                //   String? fileName = selectedFile.files.first.name;
                //   profileWatch.updateProfileImageInUnit(fileBytes);
                //   await profileWatch.updateProfileImageApi(context, fileName, profileWatch.profileDetailState.success?.data?.uuid??'',true);
                //   await profileWatch.getProfileDetail(context,profileWatch.profileDetailState.success?.data?.uuid??'');
                // }
                Uint8List? file =
                await ImagePickerManager.instance.openPicker(context);
                if (ImagePickerManager.instance.selectionType == 'remove') {
                  profileWatch.updateProfileImageRemoveStatus(true);
                }
                if (file != null) {
                  profileWatch.updateProfileImage(file);
                  print('api call');
                  await profileWatch.updateProfileImageApi(context,profileWatch.profileDetailState.success?.data?.uuid??'', true);

                  //profileWatch.updateProfileImageRemoveStatus(false);
                }
              },
              child: const CommonSVG(strIcon: AppAssets.svgUpdateImage)),
        ],
      ).paddingOnly(bottom: 46.h, right: 44.w, left: 40.w);
    });
  }
}
