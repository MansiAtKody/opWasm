import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/controller/faq/faq_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/profile/web/shimmer/shimmer_faq_list_tile_web.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';

///FAQ Screen
class ShimmerFaqWeb extends ConsumerWidget with BaseConsumerWidget {
  const ShimmerFaqWeb({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final faqWatch = ref.watch(faqController);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightPinkF7F7FC,
        borderRadius: BorderRadius.circular(20.r),
        shape: BoxShape.rectangle,
      ),
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return const ShimmerFaqListTileWeb();
        },
        padding: EdgeInsets.symmetric(horizontal: 43.w),
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 20.h,
          );
        },
        itemCount: faqWatch.faqModel.length,
      ).paddingOnly(top: 45.h, bottom: 40.h),
    );
  }
}
