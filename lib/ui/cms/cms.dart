import 'package:kody_operator/ui/cms/mobile/cms_mobile.dart';
import 'package:kody_operator/ui/cms/web/cms_web.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';


class Cms extends StatelessWidget with BaseStatelessWidget{
  final CMSType cmsType;

  const Cms({Key? key, required this.cmsType}) : super(key: key);

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
        mobile: (BuildContext context) {
          return CmsMobile(cmsType: cmsType,);
        },
        desktop: (BuildContext context) {
          return CmsWeb(cmsType: cmsType,);
        }
    );
  }
}

