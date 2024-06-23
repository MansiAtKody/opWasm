import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/order_history/order_history_controller.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class SearchItemTileListMobile extends ConsumerWidget with BaseConsumerWidget{
  final String txtSearch;

  const SearchItemTileListMobile({super.key, required this.txtSearch});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final orderHistoryWatch = ref.watch(orderHistoryController);
    return InkWell(
      onTap: () {
        orderHistoryWatch.updateSearchController(txtSearch);
        orderHistoryWatch.updateSearchList();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CommonSVG(strIcon: AppAssets.svgRecentTime,boxFit: BoxFit.scaleDown),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: CommonText(
              title: txtSearch,
              textStyle: TextStyles.regular.copyWith(
                  fontSize: 18.sp,
                  color: AppColors.grey8F8F8F),
            ),
          )
        ],
      ),
    );
  }
}
