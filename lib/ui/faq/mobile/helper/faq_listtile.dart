import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/faq/faq_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';


class FaqListTile extends ConsumerWidget with BaseConsumerWidget {
  final int index;

  const FaqListTile({required this.index, super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final faqWatch = ref.watch(faqController);
    final isExpanded = faqWatch.faqModel
        .elementAt(index)
        .isExpandable;
    return Column(
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
            child: faqWatch.faqModel
                .elementAt(index)
                .isExpandable
                ? const Icon(
              Icons.minimize,
              color: AppColors.black171717,
            ) : const Icon(
              CupertinoIcons.plus,
              color: AppColors.black171717,
            ),
          ),

          title: Wrap(
            children: [
              Text(
                faqWatch.faqModel.elementAt(index).title,
                style: TextStyles.medium.copyWith(
                    fontFamily: TextStyles.fontFamily,
                    color: AppColors.black171717, fontSize: 14.sp),
              ),
            ],
          ),
        ),
        Visibility(
          visible:isExpanded,
          child: ListTile(
            title: Wrap(
              children: [
                Text(
                  faqWatch.faqModel
                      .elementAt(index)
                      .description,
                  style: TextStyles.regular.copyWith(
                    fontFamily: TextStyles.fontFamily,
                      color: AppColors.black171717, fontSize: 13.sp),
                ),
              ],
            ),
          ),
        ),
        Visibility(
            visible: index < faqWatch.faqModel.length - 1,
            child: const Divider(height: 1)).paddingSymmetric(
            horizontal: 20.w, vertical: 10.h)
      ],
    );
  }
}
