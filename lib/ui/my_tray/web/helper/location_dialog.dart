import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/services/announcement_get_details_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_tray/web/order_successful_web.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class LocationDialogWidget extends StatelessWidget with BaseStatelessWidget {
  final bool isQuickOrder;
  final void Function()? onLocationSelected;
  final void Function()? onContinueButtonPressed;

  const LocationDialogWidget({super.key, required this.isQuickOrder, this.onLocationSelected, this.onContinueButtonPressed});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      // final locationWatch = ref.watch(locationController);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                title: LocalizationStrings.keyChooseYourLocation.localized,
                textStyle: TextStyles.medium.copyWith(fontSize: 20.sp, color: AppColors.primary2),
              ),
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const CommonSVG(strIcon: AppAssets.svgCross))
            ],
          ),

          SizedBox(
            height: 20.h,
          ),

          /// location list
          Container(
            height: MediaQuery.sizeOf(context).height * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: AppColors.white,
            ),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: 3, //  locationWatch.locationList.length,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                //LocationModel model = locationWatch.locationList[index];
                //return locationTileWidget(index, model);
                return Container();
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 15.h,
                );
              },
            ).paddingOnly(left: 15.w, top: 7.h, right: 25.w),
          ),

          SizedBox(
            height: 20.h,
          ),

          /// location button
          CommonButton(
            buttonText: LocalizationStrings.keyPlaceOrder.localized,
            height: 50.h,
            rightIcon: const Icon(Icons.arrow_forward, color: AppColors.white),
            onTap: () {
              if (isQuickOrder == true) {
                Navigator.pop(context);
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Spacer(),
                      Expanded(
                        flex: 6,
                        child: Row(
                          children: [
                            const Spacer(),
                            Expanded(
                              flex: 2,
                              child: Dialog(
                                  backgroundColor: AppColors.lightPinkF7F7FC,
                                  insetPadding: EdgeInsets.all(20.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: const OrderSuccessfulWeb(fromScreen: FromScreen.none)),
                            ),
                            const Spacer()
                          ],
                        ),
                      ),
                      const Spacer()
                    ],
                  ),
                );
                //ref.read(navigationStackProvider).push(const NavigationStackItem.orderSuccessful());
              } else {
                /// to update main index
                // locationWatch.updateSelectedLocation(locationWatch.selectedLocationTempIndex);
              }
              //Navigator.pop(context);
            },
          )
        ],
      ).paddingAll(30.h);
    });
  }

  locationTileWidget(
    int index,
    LocationModel locationModel,
  ) {
    return Consumer(builder: (context, ref, child) {
      // final locationWatch = ref.watch(locationController);
      return InkWell(
        onTap: () {
          // locationWatch.updateSelectedTempLocation(index);
        },
        child: Container(
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
              //     // locationWatch.selectedLocationIndex == index ? Icons.radio_button_checked : Icons.radio_button_off,
              //     // color: locationWatch.selectedLocationIndex == index ? AppColors.primary2 : AppColors.black171717,
              //   ),
              // )
            ],
          ),
        ),
      );
    });
  }
}
