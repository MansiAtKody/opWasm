import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/repository/service/profile_model.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/services/web/helper/common_document_sent_widget_web.dart';
import 'package:kody_operator/ui/services/web/helper/common_person_list_tile_web.dart';
import 'package:kody_operator/ui/services/web/helper/create_request_button_web.dart';
import 'package:kody_operator/ui/services/web/helper/document_dialog_widget.dart';
import 'package:kody_operator/ui/utils/anim/slide_vertical_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class SendServiceDetailRightWidget extends ConsumerWidget with BaseConsumerWidget {
  const SendServiceDetailRightWidget({
    super.key,
    required this.profile,
  });

  final ProfileModel? profile;

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    ScrollController serviceRequestScrollController = ScrollController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: CommonCard(
            color: AppColors.clrF7F7FC,
            child: profile?.requests?.isNotEmpty ?? false

                ///Show previous requests list
                ? CommonCard(
                    color: AppColors.clrF7F7FC,
                    child: Column(
                      children: [
                        ///Selected Person Profile
                        CommonPersonListTileWeb(
                          profile: profile,
                          bgColor: AppColors.transparent,
                          suffix: SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.10,
                            height: 40.h,

                            ///On-Tap Opens Create Request Form Dialog
                            child: CreateRequestButtonWeb(profile: profile),
                          ),
                        ).paddingOnly(top: 15.h, right: 15.w, bottom: 5.h),
                        Expanded(
                          child: ListView.builder(
                            controller: serviceRequestScrollController,
                            itemCount: profile?.requests?.length ?? 0,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return SlideVerticalTransition(
                                delay: 50,
                                isUpSlide: serviceRequestScrollController.position.userScrollDirection == ScrollDirection.reverse,
                                child: InkWell(
                                  onTap: () {
                                    showCommonWebDialog2(
                                      context: context,
                                      topWidget: Row(
                                        children: [
                                          CommonSVG(
                                            height: context.height * 0.06,
                                            strIcon: AppAssets.svgServiceDocumentFile,
                                          ).paddingOnly(right: 10.w),
                                          CommonText(
                                            title: LocalizationStrings.keyINeedADocument.localized,
                                            textStyle: TextStyles.regular.copyWith(color: AppColors.clr171717, fontSize: 24.sp),
                                          )
                                        ],
                                      ),
                                      topHorizontalPadding: 20.w,
                                      topPadding: 15.h,
                                      topVerticalPadding: 0.h,
                                      iconRightPadding: 6.w,
                                      iconTopPadding: 10.h,
                                      width: MediaQuery.sizeOf(context).width * 0.45,
                                      widget: DocumentDialog(
                                        model: profile?.requests?[index],
                                        profile: profile,
                                      ),
                                      onTapCrossIconButton: () {
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                  child: CommonDocumentSentWidgetWeb(
                                    serviceRequestModel: profile?.requests?[index],
                                    dateColor: AppColors.primary2,
                                    svgBgColor: AppColors.clr272727,
                                    bgColor: AppColors.buttonDisabledColor,
                                  ).paddingOnly(left: 10.w, right: 10.w, top: 20.h),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )

                ///Show no data found if there is no previous request
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonSVG(
                        strIcon: AppAssets.svgNoServices,
                        width: MediaQuery.sizeOf(context).height * 0.25,
                        height: MediaQuery.sizeOf(context).height * 0.25,
                      ),
                      SizedBox(
                        height: 25.h,
                        width: double.infinity,
                      ),
                      Text(
                        LocalizationStrings.keyNoDataFound.localized,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.medium.copyWith(
                          fontSize: 18.sp,
                          color: AppColors.clr272727,
                        ),
                      ).paddingOnly(bottom: 10.h),
                      Text(
                        LocalizationStrings.keyThereIsNoPerson.localized,
                        maxLines: 2,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.regular.copyWith(
                          color: AppColors.clr272727,
                          fontSize: 14.sp,
                        ),
                      ).paddingOnly(bottom: 20.h),
                      CreateRequestButtonWeb(profile: profile)
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
