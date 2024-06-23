import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_tray/my_tray_controller.dart';
import 'package:kody_operator/framework/repository/cart/model/response_model/frequenlty_bought_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_tray/web/helper/item_list_tile_tray_web.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class FrequentlyBroughtTogetherWidgetWeb extends StatelessWidget
    with BaseStatelessWidget {
  const FrequentlyBroughtTogetherWidgetWeb({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonText(
          title: LocalizationStrings.keyFrequentlyBoughtTogether.localized,
          textStyle: TextStyles.medium.copyWith(fontSize: 24.sp),
        ),
        SizedBox(
          height: 40.h,
        ),
        SizedBox(
          height: 200.h,
          child: Consumer(builder: (context, ref, child) {
            final myTrayWatch = ref.watch(myTrayController);

            return ListView.separated(
              itemCount: myTrayWatch.frequentlyBoughtListState.success?.data?.length??0,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                // return Container(color: AppColors.primary,);
                return SizedBox(
                    width: MediaQuery.sizeOf(context).width / 6,
                    child: ItemListTileTrayWeb(
                      index: index,
                      isFromMyTray: true,
                      productInfo: myTrayWatch.frequentlyBoughtListState.success?.data?[index]??ProductDetail(),
                    ));
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 30.w,
                );
              },
            );
          }),
        )
      ],
    ).paddingSymmetric(horizontal: 20.w);
  }
}
