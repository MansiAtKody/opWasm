import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';

class ShimmerCommonDocumentSentWidgetWeb extends StatelessWidget
    with BaseStatelessWidget {
  const ShimmerCommonDocumentSentWidgetWeb({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: context.height * 0.02,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: context.width * 0.01),

          ///Ticket Icon
          CommonShimmer(
            height: context.height * 0.06,
            width: context.height * 0.06,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: AppColors.black),
          ),
          SizedBox(width: context.width * 0.01),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Ticket Title
                    Expanded(
                      child: CommonShimmer(
                        height: 17.h,
                        width: context.width * 0.1,
                      ).paddingOnly(top: 10.h),
                    ),
                    const Spacer(),

                    ///Ticket Status
                    CommonShimmer(
                      height: 35.h,
                      width: context.width * 0.07,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          color: AppColors.black),
                    ),
                  ],
                ),
                SizedBox(height: context.height * 0.02),

                ///Ticket Description
                CommonShimmer(
                  height: 25.h,
                  width: context.width * 0.2,
                ),
                SizedBox(height: context.height * 0.01),
                CommonShimmer(
                  height: 8.h,
                  width: 48.w,
                ),
              ],
            ),
          ),
        ],
      ).paddingOnly(
          bottom: context.height * 0.02, right: context.width * 0.015),
    );
  }
}
