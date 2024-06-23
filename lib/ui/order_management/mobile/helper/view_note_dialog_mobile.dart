import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class ViewNoteDialogWidgetMobile extends StatelessWidget with BaseStatelessWidget{
  const ViewNoteDialogWidgetMobile({
    super.key,
    required this.userName,
    required this.place,
    required this.ticketNo,
    required this.orderNote,
  });

  final String userName;
  final String place;
  final String ticketNo;
  final String? orderNote;

  @override
  Widget buildPage(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     CommonText(
        //       title: LocalizationStrings
        //           .keyAdditionalNote.localized,
        //       textStyle: TextStyles.regular.copyWith(
        //         fontSize: 24.sp,
        //         color: AppColors.black171717,
        //       ),
        //     ),
        //     InkWell(
        //       onTap: () {
        //         Navigator.pop(context);
        //       },
        //       child: CommonSVG(
        //         strIcon: AppAssets.svgCrossWithBg,
        //         width: 42.w,
        //         height: 42.w,
        //       ),
        //     ),
        //   ],
        // ),
        // SizedBox(
        //   height: 30.h,
        // ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonText(
              title: userName,
              textStyle: TextStyles.regular.copyWith(
                fontSize: 20.sp,
                color: AppColors.black,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            CommonText(
              title: place,
              textStyle: TextStyles.regular.copyWith(
                fontSize: 16.sp,
                color: AppColors.black515151,
              ),
            ),
            SizedBox(
              height: 22.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 40.h,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                    color: AppColors.yellowFFEDBF,
                    borderRadius: BorderRadius.all(
                      Radius.circular(24.r),
                    ),
                  ),
                  child: Center(
                    child: CommonText(
                      title: ticketNo,
                      textStyle: TextStyles.regular.copyWith(
                        fontSize: 12.sp,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
        const Divider(
          height: 0,
          color: AppColors.greyE6E6E6,
        ).paddingSymmetric(vertical: 25.h),

        Expanded(
          child: CommonText(
            title: orderNote ?? additionalNote,
            textStyle: TextStyles.regular.copyWith(
              fontSize: 18.sp,
              color: AppColors.black,
            ),
            maxLines: 10,
          ),
        ),
        InkWell(
          onTap: () {
                    Navigator.pop(context);

          },
          child: Container(
            width: double.maxFinite,
            height: 0.06.sh,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.blue009AF1,
              ),
              borderRadius: BorderRadius.all(Radius.circular(30.r))
            ),
            child: Center(
              child: CommonText(
                title: LocalizationStrings.keyClose.localized,
                textStyle: TextStyles.regular.copyWith(
                  color: AppColors.blue009AF1
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
