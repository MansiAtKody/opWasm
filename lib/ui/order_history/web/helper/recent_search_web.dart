import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/order_history/order_history_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/order_history/web/helper/search_item_tile_list.dart';
import 'package:kody_operator/ui/utils/anim/slide_left_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class RecentSearchWeb extends StatelessWidget with BaseStatelessWidget {
  const RecentSearchWeb({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final orderHistoryWatch = ref.watch(orderHistoryController);
        return Container(
          width: 0.37.sw,
          height: 0.3.sh,
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.r)), color: AppColors.whiteF7F7FC),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                title: LocalizationStrings.keyRecentSearches.localized,
                textStyle: TextStyles.medium.copyWith(fontSize: 20.sp, color: AppColors.black),
              ).paddingOnly(bottom: 20.h),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Wrap(
                      children:
                          List.generate(
                            orderHistoryWatch.searchList.length,
                                (index) {
                              String search = orderHistoryWatch.searchList[index];
                              return SlideLeftTransition(
                                delay: (index * 50) + 300,
                                child: SearchItemTileList(txtSearch: search).paddingOnly(right: 8.w),
                              );
                            },
                      ),
                    )

                  ],
                ),
              ),
              // GridView.builder(
              //   shrinkWrap: true,
              //   padding: EdgeInsets.zero,
              //   itemCount: orderHistoryWatch.searchList.length,
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 3,
              //       mainAxisExtent: 20.h,
              //       mainAxisSpacing: 25.h,
              //       crossAxisSpacing: 30.w),
              //   itemBuilder: (context, index) {
              //     String search = orderHistoryWatch.searchList[index];
              //     return SlideLeftTransition(
              //       delay: (index * 50) + 300,
              //       child: SearchItemTileList(txtSearch: search),
              //     );
              //   },
              // )
            ],
          ).paddingSymmetric(horizontal: 25.w, vertical: 30.h),
        ).paddingOnly(top: 10.h, left: 15.w);
      },
    );
  }
}
