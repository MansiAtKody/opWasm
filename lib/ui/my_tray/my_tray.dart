import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:kody_operator/ui/my_tray/mobile/my_tray_mobile.dart';
import 'package:kody_operator/ui/my_tray/web/my_tray_web.dart';

class MyTray extends StatelessWidget with BaseStatelessWidget {
  const MyTray({Key? key, this.popCallBack}) : super(key: key);

  final Function? popCallBack;
  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
        mobile: (BuildContext context) {
          return MyTrayMobile(popCallBack: popCallBack,);
        },
        desktop: (BuildContext context) {
          return const MyTrayWeb();
        },
        tablet: (BuildContext context) {
      return OrientationBuilder(builder:(context,orientation){
        return orientation == Orientation.landscape?const MyTrayWeb(): MyTrayMobile(popCallBack: popCallBack);
      } );
    },
    );
  }
}

