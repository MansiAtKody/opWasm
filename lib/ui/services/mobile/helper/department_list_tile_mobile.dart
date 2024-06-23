import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/repository/service/department_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/app_colors.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class DepartmentListTileMobile extends StatelessWidget with BaseStatelessWidget {
  final int index;
  final DepartmentModel departmentModel;

  const DepartmentListTileMobile({super.key, required this.index, required this.departmentModel});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: AppColors.whiteF7F7FC),
        child: Row(
          children: [
            /// department icon
            Container(
              height: 46.h,
              width: 46.h,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.white),
              alignment: Alignment.center,
              child: CommonSVG(
                strIcon: departmentModel.icon,
              ),
            ),

            SizedBox(
              width: 10.w,
            ),

            /// department name
            CommonText(
              title: departmentModel.name,
              clrfont: AppColors.clr171717,
            ),
          ],
        ).paddingSymmetric(vertical: 15.h, horizontal: 20.w),
      );
    });
  }
}