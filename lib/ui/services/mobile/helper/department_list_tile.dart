import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/services/announcement_get_details_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class DepartmentListTile extends StatelessWidget with BaseStatelessWidget {
  final int index;
  final DepartmentModel? departmentModel;

  const DepartmentListTile({super.key, required this.index, required this.departmentModel});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final announcementGetDetailsWatch = ref.watch(announcementGetDetailsController);
      return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: AppColors.white),
        child: Row(
          children: [
            /// department icon
            Container(
              height: 46.h,
              width: 46.h,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.lightPinkF7F7FC),
              alignment: Alignment.center,
              child: CommonSVG(
                strIcon: departmentModel?.icon ?? '',
              ),
            ),

            SizedBox(
              width: 10.w,
            ),

            /// department name
            CommonText(
              title: departmentModel?.name ?? '',
              clrfont: AppColors.black171717,
            ),

            const Spacer(),

            /// radio
            SizedBox(
              width: 30.h,
              height: 30.h,
              child: Icon(
                announcementGetDetailsWatch.selectedDepartment == departmentModel ? Icons.radio_button_checked : Icons.radio_button_off,
                color: announcementGetDetailsWatch.selectedDepartment == departmentModel ? AppColors.primary2 : AppColors.black171717,
              ),
            )
          ],
        ).paddingAll(15.h),
      );
    });
  }
}
