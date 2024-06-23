import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/order_history/order_history_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/order_history/mobile/helper/search_item_tile_mobile.dart';
import 'package:kody_operator/ui/utils/anim/slide_left_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class RecentSearchMobile extends ConsumerWidget with BaseConsumerWidget {
  const RecentSearchMobile({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context,ref) {
    final orderHistoryWatch = ref.watch(orderHistoryController);
    return Container(
      height: 0.3.sh,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.r)),
          color: AppColors.whiteF7F7FC),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            title: LocalizationStrings.keyRecentSearches.localized,
            textStyle: TextStyles.medium
                .copyWith(fontSize: 20.sp, color: AppColors.black),
          ).paddingOnly(bottom: 20.h),
          SizedBox(
            height: 0.18.sh,
            child: GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: orderHistoryWatch.searchList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // mainAxisExtent: (MediaQuery.of(context).size.height * 0.3).h,
                  mainAxisExtent: 40.h,
                  mainAxisSpacing: 20.h,
                  crossAxisSpacing: 30.w),
              itemBuilder: (context, index) {
                String search = orderHistoryWatch.searchList[index];
                return SlideLeftTransition(

                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.whiteF7F7FC,
                        borderRadius:
                        BorderRadius.all(Radius.circular(77.r))),
                    child: SearchItemTileListMobile(txtSearch: search)
                        .paddingSymmetric(
                        vertical: 8.h, horizontal: 12.w),
                  ),
                );
              },
            ),
          )
        ],
      ).paddingSymmetric(horizontal: 25.w, vertical: 25.h),
    ).paddingOnly(top: 10.h, left: 15.w, right: 12.w);
  }
}
