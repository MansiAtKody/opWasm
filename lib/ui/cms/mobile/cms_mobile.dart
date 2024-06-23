import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:kody_operator/framework/controller/cms/cms_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_appbar.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';
import 'package:kody_operator/ui/widgets/common_white_background.dart';
import 'package:kody_operator/ui/widgets/empty_state_widget.dart';

class CmsMobile extends ConsumerStatefulWidget {
  final CMSType cmsType;

  const CmsMobile({Key? key, required this.cmsType}) : super(key: key);

  @override
  ConsumerState<CmsMobile> createState() => _CmsMobileState();
}

class _CmsMobileState extends ConsumerState<CmsMobile> with BaseConsumerStatefulWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final cmsWatch = ref.read(cmsController);
      cmsWatch.disposeController(isNotify: true);
      await getCmsAPI(widget.cmsType);
    });
  }

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    final cmsWatch = ref.watch(cmsController);
    return Scaffold(
      body: _bodyWidget(),
      appBar: CommonAppBar(
        backgroundColor: AppColors.black,
        title: cmsWatch.getCmsTitle(widget.cmsType),
        titleSize: 24.sp,
      ),
    );
  }

  ///Body Widget
  Widget _bodyWidget() {
    final cmsWatch = ref.watch(cmsController);
    return CommonWhiteBackground(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: cmsWatch.cmsState.isLoading ? const Center(child: CircularProgressIndicator(),) :  cmsWatch.cmsState.success?.data == null
                ? EmptyStateWidget(
                    icon: SizedBox(
                      height: context.height * 0.3,
                      width: context.height * 0.3,
                      child: const CommonSVG(
                        strIcon: AppAssets.svgNoData,
                      ),
                    ),
                   titleMaxLines: 3,
                   title: cmsWatch.messageDisplayed.trim() == '' ? LocalizationStrings.keyNoDataFound : cmsWatch.messageDisplayed.replaceUnderscoresWithSpaces,
                  )
                : SingleChildScrollView(
                    child: HtmlWidget(
                      cmsWatch.cmsState.success?.data?.fieldValue ?? '',
                    ),
                  ),
          ),
        ],
      ).paddingSymmetric(horizontal: 12.w, vertical: 12.h),
    );
  }

  /// Function for calling the API
  Future<void> getCmsAPI(CMSType cmsType) async {
    final cmsWatch = ref.read(cmsController);
    await cmsWatch.getCMS(context, cmsType);
  }
}
