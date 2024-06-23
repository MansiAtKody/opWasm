import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class OrderDetailWidget extends StatelessWidget with BaseStatelessWidget{
  final String orderTitle;
  final String orderNumber;
  final String imageName;

  const OrderDetailWidget({
    Key? key,
    required this.orderTitle,
    required this.orderNumber,
    required this.imageName,
  }) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.11,
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.all(Radius.circular(20.r))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonSVG(
              strIcon: imageName,
              boxFit: BoxFit.scaleDown,
            ).paddingOnly(right: 11.w, left: 20.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  title: orderTitle,
                  textStyle: TextStyles.regular.copyWith(color: AppColors.grey8D8C8C),
                ),
                CommonText(
                  title: orderNumber,
                  textStyle: TextStyles.semiBold.copyWith(fontSize: 24.sp, color: AppColors.blue009AF1),
                )
              ],
            )
          ],
        ).paddingSymmetric(vertical: 13.h),
      );
    },
    );
  }
}
