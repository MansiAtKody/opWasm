import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/anim/list_bounce_animation.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class TabTileList extends StatelessWidget with BaseStatelessWidget {
  final int index;
  final String title;
  final Function() onTabTap;
  const TabTileList({super.key, required this.index, required this.title, required this.onTabTap});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (context,ref,child) {
        final orderListWatch = ref.watch(myOrderController);
        return ListBounceAnimation(
          transformSize: 1.05,
          onTap: onTabTap,
          child: Container(
            height: 40.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: orderListWatch.selectedOrderTypeFilter?.type == orderListWatch.orderTypeFilterList[index].type ? AppColors.primary2 : AppColors.white
            ),
            alignment: Alignment.center,
            child: CommonText(
              title: title,
              clrfont: orderListWatch.selectedOrderTypeFilter?.type == orderListWatch.orderTypeFilterList[index].type ? AppColors.white : AppColors.grey626262,
            ).paddingSymmetric(horizontal: 20.w),
          ),
        ).paddingOnly(left: index == 0 ? 20.h : 0,right: index == 2 ? 20.h : 0);
      }
    );
  }
}
