import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/services/web/helper/desk_cleaning_left_button_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';

class DeskCleaningCenterWidget extends ConsumerWidget with BaseConsumerWidget{
  const DeskCleaningCenterWidget({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context, ref) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: AppColors.mapBgColor,
          borderRadius: BorderRadius.circular(30.r)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Left Button Widget
          const DeskCleaningLeftButtonWidget().paddingOnly(left: 50.w, top: 50.h),
          ///Map Image
          Container(
            width: 631.w,
            height: 567.h,
            color: AppColors.white,
          ).paddingAll(20.h)
        ],
      ),
    );
  }
}