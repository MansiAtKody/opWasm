import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/services/announcement_get_details_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';


class LocationListTile extends StatelessWidget with BaseStatelessWidget {
  final bool? isFromHome;
  final int index;
  final LocationModel locationModel;

  const LocationListTile({super.key, required this.locationModel, this.isFromHome, required this.index});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        // final locationWatch = ref.watch(locationController);
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: AppColors.white),
          child: Row(
            children: [
              /// department icon
              Container(
                height: 46.h,
                width: 46.h,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.lightPinkF7F7FC),
                alignment: Alignment.center,
                child: CommonSVG(
                  strIcon: locationModel.icon,
                ),
              ),

              SizedBox(
                width: 10.w,
              ),

              /// department name
              CommonText(
                title: locationModel.name,
                clrfont: AppColors.black171717,
              ),
              locationModel.isDefault
                  ? CommonText(
                      title: ' (${LocalizationStrings.keyDefaultLocation.localized})',
                      clrfont: AppColors.greyBEBEBE,
                    )
                  : const Offstage(),

              const Spacer(),

              /// radio
              // SizedBox(
              //   width: 30.h,
              //   height: 30.h,
              //   child: Icon(
                  /*isFromHome ?? false
                      ? */
                  // locationWatch.selectedLocationIndex == index ? Icons.radio_button_checked : Icons.radio_button_off,
                  /*: locationWatch.selectedLocationTempIndex == index
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,*/
                  // color: /*isFromHome ?? false
                  //     ? */
                      // locationWatch.selectedLocationIndex == index ? AppColors.primary2 : AppColors.black171717,
                  /*: locationWatch.selectedLocationTempIndex == index
                          ? AppColors.primary2
                          : AppColors.black171717,*/
                // ),
              // ),
            ],
          ).paddingAll(15.h),
        );
      },
    );
  }
}
