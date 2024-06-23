import 'package:kody_operator/ui/cms/mobile/cms_mobile.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class FaqMobile extends StatelessWidget with BaseStatelessWidget {
  const FaqMobile({Key? key}) : super(key: key);
  @override
  Widget buildPage(BuildContext context) {
    return const CmsMobile(cmsType: CMSType.faq);
  }
}
