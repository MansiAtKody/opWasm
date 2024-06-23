import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class CommonMoreItem extends StatelessWidget with BaseStatelessWidget {
  final String icon;
  final String title;
  final Function() onTap;
  const CommonMoreItem({Key? key, required this.icon, required this.title, required this.onTap}) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return InkWell(
      onTap : onTap,
      child: SizedBox(
        height: 50.h,
        child: CommonCard(
          cornerRadius: 25.r,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonSVG(strIcon: icon),

              SizedBox(width: 10.w,),

              CommonText(
                title: title,
                textStyle: TextStyles.medium.copyWith(
                  color: AppColors.primary2,
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 20.w ),
        ),
      ),
    );
  }
}
