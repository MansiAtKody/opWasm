import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';


/// Shimmer Common Personal Information Tile
class ShimmerCommonPersonalInfoRowWidgetWeb extends StatelessWidget with BaseStatelessWidget{
  const ShimmerCommonPersonalInfoRowWidgetWeb({super.key,});

  @override
  Widget buildPage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CommonShimmer(
              height: 24.h,
              width: 24.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            CommonShimmer(
              height: 18.h,
              width: context.width * 0.1,
            ),
          ],
        ),
        CommonShimmer(
          height: 18.h,
          width: context.width * 0.1,
        ),
      ],
    );
  }
}