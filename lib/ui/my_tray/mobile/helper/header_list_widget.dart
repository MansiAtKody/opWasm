import 'package:kody_operator/framework/controller/my_tray/order_customization_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:lottie/lottie.dart';

class HeaderListWidget extends StatelessWidget with BaseStatelessWidget {
  final String header;
  final List<CustomizeItemModel> list;
  final CustomizeItemModel? selectedCustomization;
  final Function(int index) onItemTap;

  const HeaderListWidget({
    super.key,
    required this.header,
    required this.list,
    required this.selectedCustomization,
    required this.onItemTap(index),
  });

  @override
  Widget buildPage(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonText(
            title: header,
            fontWeight: TextStyles.fwMedium,
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            height: 110.h,
            child: ListView.separated(
              itemCount: list.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                CustomizeItemModel model = list[index];
                return InkWell(
                  onTap: () {
                    onItemTap(index);
                  },
                  child: SizedBox(
                    width: 60.h,
                    child: Column(
                      children: [
                        Container(
                          height: 60.h,
                          width: 60.h,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: model == selectedCustomization ? AppColors.primary2 : AppColors.scaffoldBG),
                          child: Lottie.asset(
                            model.icon,
                            repeat: false,
                            controller: model.controller,
                            fit: BoxFit.contain
                          ).paddingOnly(top: 7.h, bottom: 7.h),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        CommonText(
                          title: model.name,
                          textAlign: TextAlign.center,
                          clrfont: AppColors.grey7E7E7E,
                          maxLines: 2,
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 20.w,
                );
              },
            ),
          )
        ],
      ).paddingAll(20.h);
  }
}
