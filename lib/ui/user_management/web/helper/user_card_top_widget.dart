import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/user_management/web/helper/view_note_dialog.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_dialogs.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:lottie/lottie.dart';

class UserCardTopWidgetWeb extends StatelessWidget with BaseStatelessWidget {
  const UserCardTopWidgetWeb({
    super.key,
    required this.userName,
    required this.place,
    required this.orderNote,
    required this.ticketNo,
  });

  final String userName;
  final String place;
  final String? orderNote;
  final String ticketNo;

  @override
  Widget buildPage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ///User Name And Location
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                title: userName,
                textStyle: TextStyles.regular.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.black,
                ),
              ),
              CommonText(
                title: place,
                maxLines: 3,
                textStyle: TextStyles.regular.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.grey8D8C8C,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 5.w,
        ),

        ///View Note Widget
        if(orderNote?.isNotEmpty ?? false) ...{
          Expanded(
            flex: 4,
            child: InkWell(
              onTap: () {
                showCommonWebDialog(
                  context: context,
                  dialogBody: ViewNoteDialogWidget(
                          userName: userName,
                          place: place,
                          ticketNo: ticketNo,
                          orderNote: orderNote)
                      .paddingSymmetric(vertical: 30.h, horizontal: 50.w),
                  width: context.width * 0.6,
                  height: context.height * 0.7,
                );
              },
              child: Container(
                height: 28.h,
                decoration: BoxDecoration(
                  color: AppColors.blue009AF1.withOpacity(0.16),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Spacer(),
                    Lottie.asset(AppAssets.animViewNote,
                        width: 25.w, height: 21.h, fit: BoxFit.contain),
                    CommonText(
                      title: LocalizationStrings.keyViewNote.localized,
                      textStyle: TextStyles.regular.copyWith(
                        fontSize: 12.sp,
                        color: AppColors.black,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
        } else...{
          Expanded(flex: 3,child: Container(),),
        },

        ///Ticket Number
        Expanded(
          flex: 5,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.yellowFFEDBF,
              borderRadius: BorderRadius.all(
                Radius.circular(16.r),
              ),
            ),
            child: Center(
              child: CommonText(
                title: ticketNo,
                textStyle: TextStyles.regular.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.black,
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
              ).paddingSymmetric(horizontal: 18.w, vertical: 8.h),
            ),
          ),
        )
      ],
    );
  }
}
