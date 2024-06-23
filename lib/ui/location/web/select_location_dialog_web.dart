// ignore_for_file: use_build_context_synchronously
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/repository/select_location/model/location_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/location/select_location_dialog_controller.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

import 'package:kody_operator/ui/widgets/empty_state_widget.dart';

class SelectLocationDialogWeb extends ConsumerStatefulWidget {
  const SelectLocationDialogWeb({
    Key? key,
    this.buttonText,
    this.onButtonPressed,
    this.isLoading
  }) : super(key: key);

  final String? buttonText;
  final bool? isLoading;
  final void Function()? onButtonPressed;

  @override
  ConsumerState<SelectLocationDialogWeb> createState() =>
      _SelectLocationDialogWebState();
}

class _SelectLocationDialogWebState
    extends ConsumerState<SelectLocationDialogWeb>
    with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        final selectLocationDialogWatch =
            ref.read(selectLocationDialogController);
        selectLocationDialogWatch.disposeController(isNotify: true);
        await selectLocationDialogWatch.getProfileDetail(context);
        await selectLocationDialogWatch
            .getLocationListApi(context)
            .then((value) async {
          selectLocationDialogWatch.updateTempSelectedLocation(0);
          await selectLocationDialogWatch.getLocationPointListApi(context, 0);
        });
      },
    );
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    final selectLocationWatch = ref.watch(selectLocationDialogController);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightPinkF7F7FC,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: selectLocationWatch.locationListState.isLoading ||
              selectLocationWatch.profileDetailState.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Title Widget
                    CommonText(
                      title:
                          LocalizationStrings.keyChooseYourLocation.localized,
                      textStyle: TextStyles.medium.copyWith(
                          fontSize: 20.sp, color: AppColors.blue009AF1),
                    ).paddingOnly(top: 30.h, left: 30.w),

                    /// Cross Button
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const CommonSVG(
                          strIcon: AppAssets.svgCrossRoundedWhiteBg),
                    ).paddingOnly(top: 30.h, right: 30.w),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// Location List
                    Expanded(
                      child: Container(
                        height: context.height * 0.45,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: ListView.builder(
                          itemCount: selectLocationWatch
                                  .locationListState.success?.data?.length ??
                              0,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                selectLocationWatch
                                    .updateTempSelectedLocation(index);
                                await selectLocationWatch
                                    .getLocationPointListApi(context, index);
                              },
                              child: LocationListTile(
                                  locationResponseModel: selectLocationWatch
                                          .locationListState
                                          .success
                                          ?.data?[index] ??
                                      LocationResponseModel()
                                  // selectLocationWatch.locationList[index],
                                  ),
                            );
                          },
                        ).paddingSymmetric(vertical: 10.h),
                      ).paddingSymmetric(horizontal: 30.w, vertical: 20.h),
                    ),

                    /// Location Points Grid
                    selectLocationWatch.locationPointListState.isLoading
                        ? const Expanded(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : ((selectLocationWatch
                        .locationPointListState.success?.data?.isEmpty??false)&&
                                !(selectLocationWatch
                                    .locationPointListState.isLoading))
                            ?  EmptyStateWidget(
                      title: LocalizationStrings.keyNoLocationPoints.localized,
                      subTitle: LocalizationStrings.keyNoLocationPointsMsg.localized,
                              )
                            : Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Wrap(
                                        direction: Axis.horizontal,
                                        children: List.generate(
                                          selectLocationWatch.locationPointListState.success?.data?.length ??
                                              0,
                                          (index) {
                                            return InkWell(
                                              onTap: () {
                                                selectLocationWatch.updateTempSelectedLocationPoint(index);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: (selectLocationWatch
                                                                  .tempSelectedLocationPoint
                                                                  ?.locationUuid ==
                                                              selectLocationWatch
                                                                  .tempSelectedLocation
                                                                  ?.uuid &&
                                                          selectLocationWatch
                                                                  .tempSelectedLocationPoint
                                                                  ?.uuid ==
                                                              selectLocationWatch
                                                                  .locationPointListState
                                                                  .success
                                                                  ?.data?[
                                                                      index]
                                                                  .uuid)
                                                      ? AppColors.blue009AF1
                                                      : AppColors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                                child: CommonText(
                                                  title: selectLocationWatch
                                                          .locationPointListState
                                                          .success
                                                          ?.data?[index]
                                                          .name ??
                                                      '01',
                                                  textStyle: TextStyles
                                                      .regular
                                                      .copyWith(
                                                    color: (selectLocationWatch
                                                                    .tempSelectedLocationPoint
                                                                    ?.locationUuid ==
                                                                selectLocationWatch
                                                                    .tempSelectedLocation
                                                                    ?.uuid &&
                                                            selectLocationWatch
                                                                    .tempSelectedLocationPoint
                                                                    ?.uuid ==
                                                                selectLocationWatch
                                                                    .locationPointListState
                                                                    .success
                                                                    ?.data?[
                                                                        index]
                                                                    .uuid)
                                                        ? AppColors.white
                                                        : AppColors
                                                            .black171717
                                                            .withOpacity(0.8),
                                                    fontSize: 17.sp,
                                                  ),
                                                ).paddingSymmetric(
                                                    horizontal: 10.w,
                                                    vertical: 10.h),
                                              ),
                                            ).paddingOnly(right: 10.w, bottom: 10.w);
                                          },
                                        ),
                                      ).paddingSymmetric(vertical: 30.h),
                                    ],
                                  ),
                                ),
                              ),
                  ],
                ),

                /// Save Button
                Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      child: CommonButton(
                        buttonText: widget.buttonText ??
                            LocalizationStrings.keySave.localized,
                        rightIcon: CommonSVG(
                          strIcon: AppAssets.svgArrowRight,
                          svgColor: selectLocationWatch.checkLocationValidation()?AppColors.white:AppColors.textFieldLabelColor ,
                            
                        ),
                        onTap: () {
                          selectLocationWatch.selectLocation();
                          Navigator.pop(context);
                          if (widget.onButtonPressed != null) {
                            widget.onButtonPressed?.call();
                          }
                        },
                        isLoading: widget.isLoading??false,
                        buttonDisabledColor:AppColors.textFieldLabelColor.withOpacity(0.3) ,
                        buttonTextColor:selectLocationWatch.checkLocationValidation()?AppColors.white:AppColors.textFieldLabelColor ,
                        isButtonEnabled: selectLocationWatch.checkLocationValidation(),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
    );
  }
}

class LocationListTile extends ConsumerWidget with BaseConsumerWidget {
  const LocationListTile({super.key, required this.locationResponseModel});

  final LocationResponseModel locationResponseModel;

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final selectLocationWatch = ref.watch(selectLocationDialogController);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            RichText(
              text: TextSpan(
                text: locationResponseModel.name,
                style: TextStyles.regular
                    .copyWith(fontSize: 16.sp, color: AppColors.black272727),
                children: locationResponseModel.uuid ==
                        selectLocationWatch
                            .profileDetailState.success?.data?.uuid
                    ? [
                        TextSpan(
                          text:
                              ' (${LocalizationStrings.keyDefaultLocation.localized})',
                          style: TextStyles.regular.copyWith(
                            fontSize: 14.sp,
                            color: AppColors.grey8F8F8F,
                          ),
                        ),
                      ]
                    : null,
              ),
            ),
          ],
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: AppColors.black,
          size: 14.w,
        ).paddingOnly(right: 14.w),
      ],
    ).paddingSymmetric(horizontal: 12.w, vertical: 20.h);
  }
}
