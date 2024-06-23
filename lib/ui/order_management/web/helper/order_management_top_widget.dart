import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/order_management/order_management_controller.dart';
import 'package:kody_operator/framework/controller/profile/profile_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class OrderManagementTopWidget extends StatelessWidget with BaseStatelessWidget{
  const OrderManagementTopWidget({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final orderManagementWatch = ref.watch(orderManagementController);
        final profileWatch = ref.watch(profileController);
        return Row(
          children: [
            InkWell(
              onTap: () {
                ref.read(navigationStackProvider).pop();
              },
              child: const CommonSVG(strIcon: AppAssets.svgHome),
            ),
            const Expanded(flex: 6, child: SizedBox()),

            /// Available status pop up
            Expanded(
              flex: 4,
              child: PopupMenuButton<PopUpStatus>(
                initialValue: PopUpStatus.Available,
                itemBuilder: (context) => [
                  PopupMenuItem(value: PopUpStatus.Available, child: Text(LocalizationStrings.keyAvailable.localized)),
                  PopupMenuItem(value: PopUpStatus.Offline, child: Text(LocalizationStrings.keyOffline.localized)),
                  PopupMenuItem(value: PopUpStatus.Unavailable, child: Text(LocalizationStrings.keyUnavailable.localized)),
                ],
                onSelected: (value) {
                  orderManagementWatch.updatePopUp(value.name);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(109.r), color: AppColors.whiteF9F9F9),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // const Expanded(flex: 2, child: SizedBox()),
                      Container(
                        width: 15.w,
                        height: 15.w,
                        decoration: BoxDecoration(
                            color: orderManagementWatch.selectedPopUp == PopUpStatus.Available.name
                                ? Colors.green
                                : orderManagementWatch.selectedPopUp == PopUpStatus.Offline.name
                                    ? Colors.red
                                    : Colors.orange,
                            borderRadius: BorderRadius.circular(30.r)),
                      ),
                      const Expanded(flex: 1, child: SizedBox()),
                      CommonText(
                        title: orderManagementWatch.selectedPopUp,
                        textStyle: TextStyles.regular.copyWith(fontSize: 20.sp, color: AppColors.black),
                      ),
                      Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: 16.w,
                          )),
                      CommonSVG(strIcon: AppAssets.svgArrowDown, height: 31.w, width: 31.w),
                      // const Expanded(flex: 2, child: SizedBox()),
                    ],
                  ).paddingSymmetric(horizontal: 14.w, vertical: 17.h),
                ),
              ),
            ),
            const Expanded(flex: 1, child: SizedBox()),

            /// Profile Image
            ClipRRect(
              borderRadius: BorderRadius.circular(50.r),
              child: CacheImage(
                imageURL: profileWatch.profileDetailState.success?.data?.profileImage ?? 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80',
                height: 63.w,
                width: 63.w,
              ),
            ),

            const Expanded(flex: 1, child: SizedBox()),

            /// Profile Username
            CommonText(
              title: profileWatch.profileDetailState.success?.data?.name ?? '',
              textStyle: TextStyles.regular.copyWith(fontSize: 20.sp, color: AppColors.black),
            ),
            const Expanded(flex: 1, child: SizedBox()),

            /// Divider
            Container(
              height: 61.h,
              width: 2.w,
              color: AppColors.black595959,
            ),
            const Expanded(flex: 1, child: SizedBox()),
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_outlined)),
          ],
        ).paddingSymmetric(horizontal: 32.w);
      },
    );
  }
}
