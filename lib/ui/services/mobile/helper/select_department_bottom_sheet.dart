
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/services/announcement_get_details_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/services/mobile/helper/department_list_tile.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_bottom_sheet.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

void openSelectDepartmentBottomSheet({
  required BuildContext context,
  required WidgetRef ref,
}) {
  final announcementGetDetailsWatch = ref.watch(announcementGetDetailsController);
  showCommonModalBottomSheet(
      context: context,
      onTap: () {
        Navigator.pop(context);
        announcementGetDetailsWatch.updateSuffix();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonText(
            title: LocalizationStrings.keySelectDepartment.localized,
            fontSize: 18.sp,
            clrfont: AppColors.primary2,
          ).paddingSymmetric(horizontal: 20.w),

          SizedBox(
            height: 20.h,
          ),

          /// department list bottom sheet
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: announcementGetDetailsWatch.departmentList.length,
              itemBuilder: (context, index) {
                DepartmentModel model = announcementGetDetailsWatch.departmentList[index];
                return InkWell(
                  onTap: () {
                    announcementGetDetailsWatch.updateSelectedDepartment(selectedDepartment: model);
                    Navigator.of(context).pop();
                    announcementGetDetailsWatch.updateSuffix();
                  },
                  child: DepartmentListTile(
                    index: index,
                    departmentModel: model,
                  ),
                ).paddingSymmetric(horizontal: 20.w);
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 20.h,
                );
              },
            ),
          ),
        ],
      ).paddingSymmetric(vertical: 20.h));
}
