import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/order_history/order_history_controller.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class SearchItemTileList extends ConsumerWidget with BaseConsumerWidget{
  final String txtSearch;

  const SearchItemTileList({super.key, required this.txtSearch});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final orderHistoryWatch = ref.watch(orderHistoryController);
    return InkWell(
      onTap: () {
        orderHistoryWatch.updateSearchController(txtSearch);
        orderHistoryWatch.updateSearchList();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           const CommonSVG(strIcon: AppAssets.svgRecentTime,boxFit: BoxFit.scaleDown),
          SizedBox(
            width: 10.w,
          ),
          Flexible(
            child: CommonText(
              title: txtSearch,
              maxLines: 3,
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
