import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class CommonBackTopWidget extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final bool? showBackButton;

  const CommonBackTopWidget({Key? key, required this.title, this.onTap, this.showBackButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        showBackButton ?? true
            ? Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return InkWell(
                    onTap: onTap ??
                        () {
                          ref.read(navigationStackProvider).pop();
                        },
                    child: const CommonSVG(strIcon: AppAssets.svgLeftArrow).paddingOnly(right: 30.h),
                  );
                },
              )
            : const Offstage(),
        CommonText(
          title: title,
          textStyle: TextStyles.regular.copyWith(
            color: AppColors.black,
            fontSize: 22.sp,
          ),
        )
      ],
    );
  }
}
