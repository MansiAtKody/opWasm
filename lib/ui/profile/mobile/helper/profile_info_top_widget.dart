import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/profile/profile_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/helpers/image_picker_manager.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class ProfileInfoTopWidget extends ConsumerWidget with BaseConsumerWidget {
  const ProfileInfoTopWidget({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final operatorDetailWatch = ref.watch(profileController);

    return Row(
      children: [
        operatorDetailWatch.profileImageRemoved
            ? SizedBox.fromSize(
          size: Size.fromRadius(25.r),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25.r),
            child :Center(
              child: Text(
                appName[0],
                style: TextStyles.semiBold.copyWith(fontSize: 18),
              ),
            ),
          ),
        ).paddingOnly(right: 20.w)
            : operatorDetailWatch.profileImage == null
            ? CacheImage(
          imageURL:
          operatorDetailWatch.profileDetailState.success?.data?.profileImage ?? '',
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
              operatorDetailWatch.profileImage!,
              fit: BoxFit.fill,
            ),
          ),
        ).paddingOnly(right: 20.w),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              title: operatorDetailWatch.profileDetailState.success?.data?.name ?? '',
              textStyle: TextStyles.regular.copyWith(
                fontSize: 18.sp,
              ),
            ).paddingOnly(bottom: 3.h),
            CommonText(
              title: operatorDetailWatch.profileDetailState.success?.data?.email ?? '',
              textStyle: TextStyles.regular.copyWith(
                  fontSize: 14.sp, color: AppColors.black.withOpacity(0.7)),
            ),
          ],
        ),
        const Spacer(),
        InkWell(
            onTap: () async {
              Uint8List? file =
              await ImagePickerManager.instance.openPicker(context);
              if (ImagePickerManager.instance.selectionType == 'remove') {
                operatorDetailWatch.updateProfileImageRemoveStatus(true);
                await operatorDetailWatch.updateProfileImageApi(context,operatorDetailWatch.profileDetailState.success?.data?.uuid??'', true);
              }
              if (file != null) {

                operatorDetailWatch.updateProfileImage(file);
                print('api call');
                await operatorDetailWatch.updateProfileImageApi(context,operatorDetailWatch.profileDetailState.success?.data?.uuid??'', true);

              }
            },
            child: const CommonSVG(strIcon: AppAssets.svgEdit)),
      ],
    );
  }
}
