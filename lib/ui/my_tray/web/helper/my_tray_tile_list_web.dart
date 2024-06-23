import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/repository/cart/model/response_model/cart_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_tray/web/helper/item_add__remove_count_qty_widget_web.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class MyTrayTileListWeb extends StatelessWidget with BaseStatelessWidget {
  final CartDtoList? trayModel;
  final bool isShowCloseIcon;
  const MyTrayTileListWeb({super.key, required this.trayModel,this.isShowCloseIcon = true});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (context,ref, child) {
        return CommonCard(
            color: AppColors.lightPinkF7F7FC,
            child: Row(
          children: [
            /// item image
            ClipOval(
              child:CacheImage(
                  height: 124.h,
                  width: 124.h,
                  imageURL: trayModel?.productImage??''
              ),
            ),

            SizedBox(width: 36.w,),

            /// item name, close icon
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// item name
                      Expanded(
                        child: CommonText(
                          title: trayModel?.productName??'',
                          textStyle: TextStyles.medium.copyWith(
                            fontSize: 20.sp,

                          ),
                          maxLines: 3,
                        ),
                      ),

                      SizedBox(width: isShowCloseIcon ? 20.w : 0),
                    ],
                  ),
                  //SizedBox(height: 13.h,),

                  ///Attribute and Attribute Name
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: trayModel?.cartAttributeDtoList?.length??0,
                    itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                         title: '${trayModel?.cartAttributeDtoList?[index].attributeValue} : ${trayModel?.cartAttributeDtoList?[index].attributeNameValue}',
                        )
                      ],
                    );
                  },),

                  //SizedBox(height: 17.h,),

                  /// customize text & add & remove & item count
                  Row(
                    children: [
                      _customizeTextWidget(ref),
                      const Spacer(),
                      ItemAddRemoveCountQtyWidgetWeb(trayModel: trayModel),
                    ],
                  ),
                ],
              ),
            )
          ],
        ).paddingOnly(left: 41.w,top: 30.h,bottom: 30,right: 30)
        );
      }
    );
  }

  _customizeTextWidget(WidgetRef ref) {
    return InkWell(
      onTap: () => ref.read(navigationStackProvider).push(NavigationStackItem.orderCustomization(fromScreen: FromScreen.myTray,productUuid: trayModel?.productUuid??'',uuid: trayModel?.uuid??'')),
      child: Row(
        children: [
          CommonText(
            title: LocalizationStrings.keyCustomize.localized,
            fontSize: 15.sp,
            textDecoration: TextDecoration.underline,
            clrfont: AppColors.primary2,
          ),
          Icon(Icons.keyboard_arrow_down,color: AppColors.primary2,size: 15.h,)
        ],
      ),
    );
  }
}
