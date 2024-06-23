import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/profile/web/shimmer/shimmer_change_language_radio_tile_web.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class ShimmerChangeLanguageWeb extends StatelessWidget with BaseStatelessWidget {
  const ShimmerChangeLanguageWeb({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightPinkF7F7FC,
        borderRadius: BorderRadius.circular(20.r),
        shape: BoxShape.rectangle,
      ),
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return const ShimmerChangeLanguageRadioTileWeb();
        },
        padding: EdgeInsets.symmetric(horizontal: 43.w),
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 20.h,
          );
        },
        itemCount: 4,
      ).paddingOnly(top: 45.h, bottom: 40.h),
    );
  }
}
