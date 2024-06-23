

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/repository/cart/model/response_model/cart_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/my_tray/mobile/helper/item_add__remove_count_qty_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';

class MyTrayTileList extends StatelessWidget with BaseStatelessWidget {
  final CartDtoList? trayModel;
  final bool isShowCloseIcon;
  final Function()? onTap;

  const MyTrayTileList({super.key, required this.trayModel,this.isShowCloseIcon = true, required this.onTap });

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (context,ref, child) {
        return CommonCard(
          color: AppColors.whiteF7F7FC,
            child: Row(
          children: [
            /// item image
            ClipOval(
              child: CacheImage(
                  height: 115.h,
                  width: 115.h,
                  imageURL: trayModel?.productImage??''
              ),
            ),

            SizedBox(width: 15.w,),

            /// item name, close icon
            Expanded(
              child: Column(
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// item name
                      Expanded(child:
                          CommonText(
                            title: trayModel?.productName??'',
                            fontSize: 18.sp,
                            maxLines: 3,
                          ),
                      ),

                      SizedBox(width: isShowCloseIcon ? 20.w : 0),

                    ],
                  ),
                  SizedBox(height: 10.h,),

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

                  SizedBox(height: 10.h,),

                  /// customize text & add & remove & item count
                  Row(
                    children: [
                      _customizeTextWidget(ref),
                    ],
                  ),
                  SizedBox(height: 10.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ItemAddRemoveCountQtyWidget(trayModel: trayModel),
                    ],
                  ),
                ],
              ),
            )
          ],
        ).paddingSymmetric(horizontal: 15.w,vertical: 20.h)
        );
      }
    );
  }

  _customizeTextWidget(WidgetRef ref) {
    return InkWell(

      onTap: onTap,
      child: Row(
        children: [
          CommonText(
            title: LocalizationStrings.keyCustomize.localized,
            fontSize: 12.sp,
            textDecoration: TextDecoration.underline,
            clrfont: AppColors.primary2,
          ),
          Icon(Icons.keyboard_arrow_down,color: AppColors.primary2,size: 15.h,)
        ],
      ),
    );
  }
}
