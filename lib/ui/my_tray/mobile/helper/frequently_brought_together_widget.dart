import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/my_tray/my_tray_controller.dart';
import 'package:kody_operator/framework/repository/cart/model/response_model/frequenlty_bought_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_tray/mobile/helper/frequently_buy_item_tile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class FrequentlyBroughtTogetherWidget extends ConsumerWidget with BaseConsumerWidget {
  const FrequentlyBroughtTogetherWidget({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final myTrayWatch = ref.watch(myTrayController);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonText(
          title: LocalizationStrings.keyFrequentlyBoughtTogether.localized,
          fontWeight: TextStyles.fwMedium,
        ),
        SizedBox(
          height: 20.h,
        ),
        SizedBox(
          height: 200.h,
          child: ListView.separated(
            itemCount: myTrayWatch.frequentlyBoughtListState.success?.data?.length ?? 0,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return SizedBox(width: MediaQuery.sizeOf(context).width / 2.40, child: FrequentlyBoughtItemListTile(index: index, isFromMyTray: true,productInfo: myTrayWatch.frequentlyBoughtListState.success?.data?[index]??ProductDetail()));
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 20.w,
              );
            },
          ),
        )
      ],
    ).paddingSymmetric(horizontal: 20.w);
  }
}
