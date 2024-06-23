import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:kody_operator/framework/controller/cms/cms_controller.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class CmsWeb extends ConsumerStatefulWidget {
  final CMSType cmsType;

  const CmsWeb({Key? key, required this.cmsType}) : super(key: key);

  @override
  ConsumerState<CmsWeb> createState() => _CmsWebState();
}

class _CmsWebState extends ConsumerState<CmsWeb> with BaseConsumerStatefulWidget {

  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp)async {
      final cmsWatch = ref.read(cmsController);
      cmsWatch.disposeController(isNotify : true);
      await getCmsAPI(widget.cmsType);

    });
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    final cmsWatch = ref.watch(cmsController);
    return SizedBox(
      height: context.height,
      child: HtmlWidget(
        cmsWatch.cmsState.success?.status == ApiEndPoints.apiStatus_200 ?
          cmsWatch.cmsState.success?.data?.fieldValue.toString() ?? ''  : cmsWatch.cmsState.success?.data?.fieldValue.toString().replaceUnderscoresWithSpaces ?? ''
      ),
      // decoration: BoxDecoration(
      //   color: AppColors.servicesScaffoldBgColor,
      //   borderRadius: BorderRadius.circular(20.r),
      // ),
      // child: SingleChildScrollView(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Stack(
      //         children: [
      //           Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               CommonText(
      //                 title: '${LocalizationStrings().keyLastUpdated}: 3/10/23',
      //                 textStyle: TextStyles.regular.copyWith(
      //                   color: AppColors.blue0083FC,
      //                   fontSize: 14.sp,
      //                 ),
      //               ),
      //             ],
      //           ).paddingOnly(bottom: 20.h),
      //           cmsWatch.progress < 100 ? const DialogProgressBar(isLoading: true) : Container(),
      //         ],
      //       )
      //     ],
      //   ),
      // ),
    );
  }

  /// Function for calling the API
  Future<void> getCmsAPI(CMSType cmsType) async {
    final cmsWatch = ref.read(cmsController);
    await cmsWatch.getCMS(context, cmsType);
  }
}
