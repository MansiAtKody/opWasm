import 'dart:math';

import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';


class PaginationBottomWidget extends StatelessWidget with BaseStatelessWidget {
  final bool hasNextPage;
  final bool hasPreviousPage;
  final int totalPages;
  final int totalEntries;
  final int currentPage;
  final int pageSize;
  final Function(int pageNumber)? onButtonTap;

  const PaginationBottomWidget({
    super.key,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.totalPages,
    required this.totalEntries,
    required this.currentPage,
    required this.pageSize,
    this.onButtonTap,
  });

  @override
  Widget buildPage(BuildContext context) {
    int startEntry = currentPage == 1 ? pageSize * (currentPage - 1) + 1 : (pageSize * (currentPage - 1) + 2);
    int endEntry = currentPage == 1 ? (pageSize * (currentPage - 1) + pageSize) : (pageSize * (currentPage - 1) + pageSize + 1);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        /// per page showing,
        CommonText(
          title: '${LocalizationStrings.keyShowing.localized} $startEntry ${LocalizationStrings.keyTo.localized.toLowerCase()} $endEntry ${LocalizationStrings.keyOf.localized} $totalEntries ${LocalizationStrings.keyEntries.localized}',
          fontSize: 13.sp,
          clrfont: AppColors.greyA5A3AE,
        ),
        const Spacer(),

        /// previous button
        CommonButton(
          buttonText: LocalizationStrings.keyPrevious.localized,
          isButtonEnabled: hasPreviousPage,
          height: 39.h,
          width: 83.w,
          buttonTextSize: 15.sp,
          onTap: () {
            onButtonTap?.call(currentPage - 1);
          },
          borderRadius: BorderRadius.circular(6.r),
          buttonDisabledColor: AppColors.lightPink,
          buttonEnabledColor: AppColors.lightPink,
          buttonTextColor: (hasPreviousPage) ? AppColors.grey5D596C : AppColors.greyA5A3AE,
        ),

        currentPage >= 3
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(width: 5.w),
                  CommonButton(
                    buttonText: (1).toString(),
                    isButtonEnabled: true,
                    height: 39.h,
                    buttonTextSize: 15.sp,
                    width: 39.h,
                    onTap: () {
                      onButtonTap?.call(1);
                    },
                    borderRadius: BorderRadius.circular(6.r),
                    buttonDisabledColor: AppColors.lightPink,
                    buttonEnabledColor: AppColors.lightPink,
                    buttonTextColor: AppColors.grey5D596C,
                  ),
                  SizedBox(width: 5.w),
                  CommonText(
                    title: '...',
                    textStyle: TextStyles.medium.copyWith(fontSize: 15.sp, color: AppColors.black),
                  )
                ],
              )
            : const Offstage(),

        SizedBox(width: 5.w),

        /// list of pages buttons
        if (currentPage != 1)
          SizedBox(
            height: 39.h,
            child: ListView.separated(
              itemCount: min(totalPages, 3),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                int count = index == 0
                    ? currentPage - 1
                    : index == 1
                        ? currentPage
                        : currentPage + 1;
                return Opacity(
                  opacity: (count) <= totalPages ? 1 : 0.4,
                  child: CommonButton(
                    buttonText: (count).toString(),
                    isButtonEnabled: true,
                    height: 39.h,
                    width: 39.h,
                    buttonTextSize: 15.sp,
                    onTap: () {
                      if ((count) <= totalPages) {
                        onButtonTap?.call(count);
                      }
                    },
                    borderRadius: BorderRadius.circular(6.r),
                    buttonDisabledColor: (index == 1) ? AppColors.black1A1A1A : AppColors.lightPink,
                    buttonEnabledColor: (index == 1) ? AppColors.black1A1A1A : AppColors.lightPink,
                    buttonTextColor: (index == 1) ? AppColors.white : AppColors.grey5D596C,
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 5.w,
                );
              },
            ),
          )
        else
          SizedBox(
            height: 39.h,
            child: ListView.separated(
              itemCount: min(totalPages, 3),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CommonButton(
                  buttonText: (currentPage + index).toString(),
                  isButtonEnabled: true,
                  height: 39.h,
                  width: 39.h,
                  buttonTextSize: 15.sp,
                  onTap: () {
                    onButtonTap?.call(currentPage + index);
                  },
                  borderRadius: BorderRadius.circular(6.r),
                  buttonDisabledColor: (index == 0) ? AppColors.black1A1A1A : AppColors.lightPink,
                  buttonEnabledColor: (index == 0) ? AppColors.black1A1A1A : AppColors.lightPink,
                  buttonTextColor: (index == 0) ? AppColors.white : AppColors.grey5D596C,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 5.w,
                );
              },
            ),
          ),

        currentPage <= totalPages - 3
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(width: 5.w),
                  CommonText(
                    title: '...',
                    textStyle: TextStyles.medium.copyWith(fontSize: 15.sp, color: AppColors.black),
                  ),
                  SizedBox(width: 5.w),
                  CommonButton(
                    buttonText: (totalPages).toString(),
                    isButtonEnabled: true,
                    height: 39.h,
                    width: 39.h,
                    buttonTextSize: 15.sp,
                    onTap: () {
                      onButtonTap?.call(totalPages);
                    },
                    borderRadius: BorderRadius.circular(6.r),
                    buttonDisabledColor: AppColors.lightPink,
                    buttonEnabledColor: AppColors.lightPink,
                    buttonTextColor: AppColors.grey5D596C,
                  ),
                ],
              )
            : const Offstage(),

        SizedBox(width: 5.w),

        /// next button
        CommonButton(
          buttonText: LocalizationStrings.keyNext.localized,
          height: 39.h,
          width: 57.w,
          buttonTextSize: 15.sp,
          isButtonEnabled: hasNextPage,
          onTap: () {
            onButtonTap?.call(currentPage + 1);
          },
          borderRadius: BorderRadius.circular(6.r),
          buttonDisabledColor: AppColors.lightPink,
          buttonEnabledColor: AppColors.lightPink,
          buttonTextColor: (hasNextPage) ? AppColors.grey5D596C : AppColors.greyA5A3AE,
        ),
      ],
    );
  }
}
