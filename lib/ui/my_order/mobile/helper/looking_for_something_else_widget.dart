import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/order_home_controller.dart';
import 'package:kody_operator/framework/repository/order/model/response/product_list_reponse_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/my_tray/mobile/helper/item_list_tile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/dialog_progressbar.dart';
import 'package:kody_operator/ui/widgets/empty_state_widget.dart';


class LookingForSomeThingElseWidget extends ConsumerWidget
    with BaseConsumerWidget {
  final bool? fromGuest;
  const LookingForSomeThingElseWidget({super.key, this.fromGuest = false});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final homeWatch = ref.watch(orderHomeController);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row(
        //   children: [
        //     Expanded(
        //       child: CommonText(
        //         title:
        //             '${LocalizationStrings.keyLookingForSomething.localized} ${LocalizationStrings.keyDelicious.localized} ? 🧐',
        //         textStyle: TextStyles.medium
        //             .copyWith(fontSize: 14.sp, color: AppColors.black),
        //       ).paddingOnly(left: 20.w, bottom: 20.h),
        //     ),
        //   ],
        // ),

        /// Product List
        (homeWatch.productListState.success?.data?.isEmpty ?? true)

            ///Empty State
            ? const EmptyStateWidget()

            /// List widget
            : Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: homeWatch.productListState.success?.data?.length ??0,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5.h,
                      mainAxisExtent: context.height * 0.30,
                      crossAxisSpacing: 20.w,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return ItemListTile(
                          index: index,
                          fromGuest: fromGuest,
                          productInfo: homeWatch.productListState.success?.data?[index]??ProductList());
                    },
                  ).paddingSymmetric(horizontal: 20.w),
                  homeWatch.productListState.isLoadMore
                      ? const DialogProgressBar(isLoading: true)
                      : const SizedBox(),
                  SizedBox(
                    height: 20.h,
                  )
                  // DialogProgressBar(forPagination: homeWatch.getProductListState.isLoadMore, isLoading: false,)
                ],
              ),
      ],
    );
  }
}
