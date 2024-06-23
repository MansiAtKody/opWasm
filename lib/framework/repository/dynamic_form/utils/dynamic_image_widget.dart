import 'dart:typed_data';
import 'package:kody_operator/framework/repository/dynamic_form/repository/model/dynamic_form_response_model.dart';
import 'package:kody_operator/framework/repository/dynamic_form/utils/dynamic_widget_controller.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/helpers/image_picker_manager.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/cache_image.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DynamicImageWidget extends StatelessWidget with BaseStatelessWidget {
  final Field? field;

  const DynamicImageWidget({super.key, required this.field});

  @override
  Widget buildPage(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final dynamicControllerWatch = ref.watch(dynamicWidgetController);
              return Container(
                height: context.height * 0.25,
                width: context.height * 0.25,
                alignment: Alignment.center,
                decoration: BoxDecoration(border: Border.all(color: AppColors.textFieldBorderColor, width: 1), borderRadius: BorderRadius.circular(20.r)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () async {
                        Uint8List? selectedImage = await ImagePickerManager.instance.openPicker(context);
                        field?.listWidget.firstOrNull?[WidgetPropertyEnum.imageBytes] = selectedImage;
                        dynamicControllerWatch.notify();
                      },
                      child: (field?.listWidget.firstOrNull?[WidgetPropertyEnum.imageBytes] != null)
                          ? Image.memory(
                              field?.listWidget.firstOrNull?[WidgetPropertyEnum.imageBytes],
                              height: context.height * 0.2,
                              width: context.height * 0.2,
                              fit: BoxFit.cover,
                            )
                          : (field?.listWidget.firstOrNull?[WidgetPropertyEnum.imageUrl] != null)
                              ? CacheImage(
                                  imageURL: field?.listWidget.firstOrNull?[WidgetPropertyEnum.imageUrl],
                                  height: context.height * 0.2,
                                  width: context.height * 0.2,
                                )
                              : CommonSVG(
                                  strIcon: AppAssets.svgSelectImage,
                                  height: 0.06.sh,
                                  width: 0.06.sw,
                                ),
                    ),
                    SizedBox(height: 0.02.sh),
                    if ((field?.listWidget.firstOrNull?[WidgetPropertyEnum.imageBytes] == null) && (field?.listWidget.firstOrNull?[WidgetPropertyEnum.imageUrl] == null))
                      InkWell(
                        onTap: () async {
                          Uint8List? selectedImage = await ImagePickerManager.instance.openPicker(context);
                          field?.listWidget.firstOrNull?[WidgetPropertyEnum.imageBytes] = selectedImage;
                          dynamicControllerWatch.notify();
                        },
                        child: CommonText(
                          title: LocalizationStrings.keySelectImage.localized,
                          textStyle: TextStyles.regular.copyWith(color: AppColors.blue0083FC),
                        ),
                      )
                    else
                      InkWell(
                        onTap: () {
                          field?.listWidget.firstOrNull?[WidgetPropertyEnum.imageBytes] = null;
                          field?.listWidget.firstOrNull?[WidgetPropertyEnum.imageUrl] = null;
                          dynamicControllerWatch.notify();
                        },
                        child: CommonText(
                          title: LocalizationStrings.keyRemove.localized,
                          textStyle: TextStyles.regular.copyWith(color: AppColors.pendingTicketTextColor),
                        ),
                      )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
