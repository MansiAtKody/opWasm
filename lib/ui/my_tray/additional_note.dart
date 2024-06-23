import 'package:kody_operator/ui/my_tray/mobile/additional_note_mobile.dart';
import 'package:kody_operator/ui/my_tray/web/additional_note_web.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AdditionalNote extends StatelessWidget with BaseStatelessWidget {
  final String additionalNote;

  const AdditionalNote({Key? key, required this.additionalNote}) : super(key: key);

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) {
        return AdditionalNoteMobile(additionalNote: additionalNote);
      },
      desktop: (BuildContext context) {
        return const AdditionalNoteWeb();
      },
      tablet: (BuildContext context) {
        return OrientationBuilder(builder: (context, orientation) {
          return orientation == Orientation.landscape ? const AdditionalNoteWeb() : AdditionalNoteMobile(additionalNote: additionalNote);
        });
      },
    );
  }
}
