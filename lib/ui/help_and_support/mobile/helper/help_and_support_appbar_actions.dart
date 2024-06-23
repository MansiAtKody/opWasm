import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/framework/controller/help_and_support/help_and_support_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/help_and_support/mobile/helper/help_and_support_filter_widget.dart';
import 'package:kody_operator/ui/widgets/common_svg.dart';

class HelpAndSupportAppBarAction extends StatelessWidget with BaseStatelessWidget {
  const HelpAndSupportAppBarAction({
    super.key,
  });

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final helpAndSupportWatch = ref.watch(helpAndSupportController);
        return Hero(
          tag: filterHero,
          child: Material(
            color: Colors.transparent,
            child: InkWell(    
              onTap: (){
                helpAndSupportWatch.updateIsPopUpMenuOpen(isPopUpMenuOpen: true);
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    opaque: false,
                    barrierDismissible: true,
                    pageBuilder: (BuildContext context, _, __) {
                      return const HelpAndSupportFilterWidget();
                    },
                  ),
                );
              },
              child: CommonSVG(
                strIcon: AppAssets.svgFilter,
                width: 54.h,
                height: 55.h,
              ),
            ).paddingLTRB(0.0, 10.h, 20.w, 0.0),
          ),
        );
      },
    );
  }
}
