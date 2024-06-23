import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/product_management/product_management_controller.dart';
import 'package:kody_operator/framework/repository/product_management/model/response_model/get_product_list_response_model.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/product_management/helper/quantity_widget_mobile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_text.dart';
import 'package:kody_operator/ui/widgets/empty_state_widget.dart';


class CustomizationDialog extends ConsumerStatefulWidget {
  final GetProductListResponseData? productModel;
  const CustomizationDialog({super.key,required this.productModel});

  @override
  ConsumerState<CustomizationDialog> createState() => _CustomizationDialogState();
}

class _CustomizationDialogState extends ConsumerState<CustomizationDialog> with BaseConsumerStatefulWidget{

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final productManagementWatch = ref.watch(productManagementController);
      await productManagementWatch.productDetailApi(context, widget.productModel?.uuid ?? '');
    });
    super.initState();
  }
  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    final productManagementWatch = ref.watch(productManagementController);
    return productManagementWatch.productDetailState.isLoading?
        const Center(child: CircularProgressIndicator(color: AppColors.black,))
        :Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              title: widget.productModel?.productName ?? '',
              textStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: AppColors.black),
            ).paddingOnly(bottom: 30.h),
            Expanded(
              child: productManagementWatch.productDetailState.success?.data?.productAttributes?.length==0?EmptyStateWidget(title: LocalizationStrings.keyNoDataFound.localized, titleColor: AppColors.black):ListView.separated(
                itemCount: productManagementWatch.productDetailState.success?.data?.productAttributes?.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return QuantityWidgetMobile(productAttribute: productManagementWatch.productDetailState.success?.data?.productAttributes?[index]);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(color: AppColors.greyDCD9D9);
                },
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 60.h,
                width: double.maxFinite,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30.r)), border: Border.all(color: AppColors.blue009AF1)),
                child: Center(
                  child: CommonText(
                    title: LocalizationStrings.keyClose.localized,
                    textStyle: TextStyles.regular.copyWith(color: AppColors.blue009AF1),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    ).paddingOnly(left: 30.w, right: 30.w, top: 30.h, bottom: 15.h);
  }
}
