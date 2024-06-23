import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/faq/faq_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_assets.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/utils/theme/text_style.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';

class FaqListTile extends ConsumerWidget with BaseConsumerWidget{
  final int index;
  final TextStyle? titleStyle;
  final double? dividerHeight;

  const FaqListTile(
      {super.key, required this.index, this.titleStyle, this.dividerHeight});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final faqWatch = ref.watch(faqController);
    final isExpanded = faqWatch.faqModel[index].isExpandable;
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20.r)),
      child: Column(
        children: [
          /// This will make the default divider of expansion tile transparent
          ListTile(
            leading: const CommonSVG(
              strIcon: AppAssets.svgFaq,
            ),
            trailing: InkWell(
              onTap: () {
                faqWatch.setExpandable(index);
              },
              child: SizedBox(
                width: 24.w,
                height: 24.w,
                child: faqWatch.faqModel[index].isExpandable
                    ? const Icon(
                        Icons.minimize,
                        color: AppColors.black171717,
                      )
                    : const Icon(
                        CupertinoIcons.plus,
                        color: AppColors.black171717,
                      ),
              ),
            ),
            title: Wrap(
              children: [
                Text(
                  faqWatch.faqModel[index].title,
                  style: titleStyle ??
                      TextStyles.medium.copyWith(
                        color: AppColors.black171717,
                        fontSize: 14.sp,
                      ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: isExpanded,
            child: ListTile(
              title: Wrap(
                children: [
                  Text(
                    faqWatch.faqModel[index].description,
                    style: TextStyles.regular.copyWith(
                      color: AppColors.grey7D7D7D,
                      fontSize: 14.sp,
                    ),
                  ).paddingOnly(bottom: 23.h, left: 45.w),
                ],
              ),
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 15.w, vertical: 15.h),
    );
  }
}
