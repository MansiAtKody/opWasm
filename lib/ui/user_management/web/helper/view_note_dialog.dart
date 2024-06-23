import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class ViewNoteDialogWidget extends StatelessWidget with BaseStatelessWidget{
  const ViewNoteDialogWidget({
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
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              title: LocalizationStrings
                  .keyAdditionalNote.localized,
              textStyle: TextStyles.regular.copyWith(
                fontSize: 24.sp,
                color: AppColors.black171717,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: CommonSVG(
                strIcon: AppAssets.svgCrossWithBg,
                width: 42.w,
                height: 42.w,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  title: userName,
                  textStyle: TextStyles.regular.copyWith(
                    fontSize: 18.sp,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                CommonText(
                  title: place,
                  textStyle: TextStyles.regular.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.grey8D8C8C,
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.yellowFFEDBF,
                borderRadius: BorderRadius.all(
                  Radius.circular(16.r),
                ),
              ),
              child: CommonText(
                title: ticketNo,
                textStyle: TextStyles.regular.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.black,
                ),
              ).paddingSymmetric(
                horizontal: 18.w,
                vertical: 8.h,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 25.h,
        ),
        Expanded(
          child: Container(
            width: context.width,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(
                color: AppColors.greyE6E6E6,
                width: 1.w,
              ),
              color: AppColors.lightPinkF7F7FC,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: CommonText(
              title: '${LocalizationStrings.keyAdditionalNote.localized} : ${orderNote ?? ''}',
              textStyle: TextStyles.regular.copyWith(
                fontSize: 18.sp,
                color: AppColors.black,
              ),
              maxLines: 10,
            ).paddingSymmetric(
                vertical: 25.h, horizontal: 35.w),
          ),
        ),
      ],
    );
  }
}
