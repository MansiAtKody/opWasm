import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';

class CommonServiceListTile extends StatelessWidget with BaseStatelessWidget {
  final String imageAsset;
  final String text;
  final TextStyle? style;
  final void Function()? onTap;
  final int index;

  const CommonServiceListTile({
    super.key,
    required this.imageAsset,
    this.onTap,
    required this.text,
    this.style,
    required this.index,
  });

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return InkWell(
          onTap: onTap,
          child: CommonCard(
            color: AppColors.whiteF7F7FC.withOpacity(0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CommonSVG(
                  strIcon: imageAsset,
                  width: 44.w,
                  height: 44.h,
                ).paddingOnly(top: 20.h, bottom: 20.h, right: 15.w),
                Text(text, style: style ?? TextStyles.regular.copyWith(fontSize: 16.sp)),
                const Spacer(),
                const CommonSVG(strIcon: AppAssets.svgRightArrow),
              ],
            ).paddingOnly(left: 20.w, right: 20.w),
          ),
        );
      },
    );
  }
}
