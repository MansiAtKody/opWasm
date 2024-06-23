import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/services/web/shimmer/shimmer_common_document_sent_widget_web.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';

class ShimmerSendServiceRightWidget extends StatelessWidget
    with BaseStatelessWidget {
  const ShimmerSendServiceRightWidget({
    super.key,
  });

  @override
  Widget buildPage(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SizedBox(
            width: context.width * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CommonCard(
                      color: AppColors.clrF7F7FC,
                      child: CommonCard(
                        color: AppColors.clrF7F7FC,
                        child: Column(
                          children: [
                            ///Selected Person Profile
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: AppColors.white,
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 15.h),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClipOval(
                                    child: CommonShimmer(
                                      height: context.width * 0.03,
                                      width: context.width * 0.03,
                                    ),
                                  ),
                                  SizedBox(width: context.width * 0.01),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CommonShimmer(
                                        height: 15.h,
                                        width: context.width * 0.05,
                                      ).paddingOnly(bottom: 10.h),
                                      CommonShimmer(
                                        height: 15.h,
                                        width: context.width * 0.07,
                                      )
                                    ],
                                  ),
                                  const Spacer(),
                                  CommonShimmer(
                                    height: 50.h,
                                    width: context.width * 0.1,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.r),
                                        color: AppColors.black),
                                  )
                                ],
                              ),
                            ).paddingOnly(top: 15.h, right: 15.w, bottom: 5.h),

                            Expanded(
                              child: ListView.builder(
                                itemCount: 5,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return const ShimmerCommonDocumentSentWidgetWeb()
                                      .paddingOnly(
                                          left: 10.w, right: 10.w, top: 20.h);
                                },
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
