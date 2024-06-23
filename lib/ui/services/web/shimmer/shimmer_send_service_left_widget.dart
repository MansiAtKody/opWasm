import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/services/web/shimmer/shimmer_common_person_list_tile_web.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';

class ShimmerSendServiceLeftWidget extends StatelessWidget
    with BaseStatelessWidget {
  const ShimmerSendServiceLeftWidget({super.key});

  @override
  Widget buildPage(BuildContext context) {
    ScrollController serviceHistoryUserListController = ScrollController();
    return Column(
      children: [
        SizedBox(
          width: context.width * 0.2,
          height: context.height * 0.09,
          child: CommonShimmer(
            height: 0.h,
            width: 0.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(57.r),
                color: AppColors.black),
          ).paddingOnly(bottom: 25.h),
        ),
        Expanded(
          child: Stack(
            children: [
              SizedBox(
                height: context.height * 0.6,
                width: context.width * 0.2,
                child: CommonCard(
                  child: ListView.separated(
                    controller: serviceHistoryUserListController,
                    itemCount: 1,
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return const ShimmerCommonPersonListTileWeb();
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 10.h,
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
