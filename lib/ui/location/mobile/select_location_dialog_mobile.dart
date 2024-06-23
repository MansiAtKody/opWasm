// ignore_for_file: use_build_context_synchronously

import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/repository/select_location/model/location_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/location/select_location_bottomsheet.dart';
import 'package:kody_operator/ui/location/select_location_dialog_controller.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_form_field.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/empty_state_widget.dart';

class SelectLocationDialogMobile extends ConsumerStatefulWidget {
  const SelectLocationDialogMobile({
    Key? key,
    this.buttonText,
    this.onButtonPressed,
  }) : super(key: key);

  final String? buttonText;
  final void Function()? onButtonPressed;

  @override
  ConsumerState<SelectLocationDialogMobile> createState() =>
      _SelectLocationDialogMobileState();
}

class _SelectLocationDialogMobileState
    extends ConsumerState<SelectLocationDialogMobile>
    with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final selectLocationDialogWatch =
          ref.read(selectLocationDialogController);
      selectLocationDialogWatch.disposeController(isNotify: true);
      if (context.mounted) {
        await selectLocationDialogWatch.getProfileDetail(context);
        await selectLocationDialogWatch.getLocationListApi(context);
        if (selectLocationDialogWatch.locationListState.success != null) {
          await selectLocationDialogWatch.getLocationPointListApi(context, 0);
        }
      }
    });
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    final selectLocationWatch = ref.watch(selectLocationDialogController);
    return Scaffold(
      backgroundColor: AppColors.lightPinkF7F7FC,
      appBar: CommonAppBar(
        bottomWidget: const AppbarBottomWidget(),
        title: LocalizationStrings.keyChooseYourLocation.localized,
        appBarHeight: 150.h,
      ),
      body: Container(
        child: (selectLocationWatch.searchLocationList.isEmpty &&
                selectLocationWatch.searchController.text.isNotEmpty)
            ? const EmptyStateWidget(
                title: 'Location Not Found',
              )
            : selectLocationWatch.locationListState.isLoading ||
                    selectLocationWatch.profileDetailState.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.separated(
                    itemCount: selectLocationWatch.searchLocationList.isNotEmpty ? selectLocationWatch.searchLocationList.length : selectLocationWatch.locationListState.success?.data?.length ?? 0,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          selectLocationWatch.getLocationPointListApi(context, index);
                          selectLocationWatch.updateTempSelectedLocation(index);
                          selectLocationWatch.onLocationBottomSheetOpened();
                          openSelectLocationPointBottomSheet(context: context, buttonText: widget.buttonText, onButtonPressed: widget.onButtonPressed);
                        },
                        child: LocationListTileMobile(
                          locationResponseModel: selectLocationWatch.searchLocationList.isNotEmpty ? selectLocationWatch.searchLocationList[index] : selectLocationWatch.locationListState.success?.data?[index] ??
                              LocationResponseModel(),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 20.h,
                      );
                    },
                  ).paddingSymmetric(vertical: 20.h, horizontal: 20.w),
      ),
    );
  }
}

/// Location Search Bar
class AppbarBottomWidget extends ConsumerWidget implements PreferredSizeWidget {
  const AppbarBottomWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectLocationDialogWatch = ref.watch(selectLocationDialogController);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
      ),
      child: CommonInputFormField(
        textEditingController: selectLocationDialogWatch.searchController,
        prefixWidget: const CommonSVG(strIcon: AppAssets.svgSearch)
            .paddingSymmetric(horizontal: 12.w, vertical: 12.h),
        hintText: LocalizationStrings.keySearchLocation.localized,

        fieldTextStyle: TextStyles.regular.copyWith(
          fontSize: 16.sp,
          color: AppColors.white.withOpacity(0.5),
        ),
        onChanged: (value) {
          selectLocationDialogWatch.onSearch();
        },
        cursorColor: AppColors.white.withOpacity(0.5),
        backgroundColor: AppColors.white.withOpacity(0.03),
        hasLabel: false,
        borderColor: AppColors.transparent,
        borderRadius: BorderRadius.circular(50.r),
        hintTextStyle: TextStyles.regular.copyWith(
          fontSize: 16.sp,
          color: AppColors.white,
        ),
        placeholderTextStyle: TextStyles.regular.copyWith(
          fontSize: 16.sp,
          color: AppColors.white,
        ),
      ).paddingOnly(left: 20.w, right: 20.w, bottom: 20.h),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.h);
}

class LocationListTileMobile extends ConsumerWidget with BaseConsumerWidget {
  const LocationListTileMobile({
    super.key,
    required this.locationResponseModel,
  });

  final LocationResponseModel locationResponseModel;

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final selectLocationWatch = ref.watch(selectLocationDialogController);
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(20.r)),
      child: Row(
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
          ),
        ],
      ).paddingSymmetric(horizontal: 12.w, vertical: 20.h),
    );
  }
}
