import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_order/my_order_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/anim/list_bounce_animation.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';


class TabTileListWeb extends StatelessWidget with BaseStatelessWidget {
  final int index;
  final String title;
  final Function() onTabTap;
  final double? titleFontSize;
  const TabTileListWeb({super.key, required this.index, required this.title, required this.onTabTap, this.titleFontSize});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
        builder: (context,ref,child) {
          final orderListWatch = ref.watch(myOrderController);
          return ListBounceAnimation(
            transformSize: 1.15,
            onTap: onTabTap,
            child: Container(
              height: 40.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(
                    color: orderListWatch.selectedOrderFilter == orderListWatch.orderFilterList[index] ? AppColors.primary2 : AppColors.greyD6D6D6
                  ),
                  color: orderListWatch.selectedOrderFilter == orderListWatch.orderFilterList[index] ? AppColors.primary2 : AppColors.transparent
              ),
              alignment: Alignment.center,
              child: CommonText(
                title: title,
                fontSize: titleFontSize,
                clrfont: orderListWatch.selectedOrderFilter == orderListWatch.orderFilterList[index] ? AppColors.white : AppColors.grey6C6C6C,
              ).paddingSymmetric(horizontal: 20.w),
            ),
          );
        }
    );
  }
}