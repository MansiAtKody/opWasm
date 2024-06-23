import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:kody_operator/ui/help_and_support/mobile/create_ticket_mobile.dart';
import 'package:kody_operator/ui/help_and_support/web/create_ticket_web.dart';

class CreateTicket extends StatelessWidget with BaseStatelessWidget{
  const CreateTicket({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
        mobile: (BuildContext context) {
          return const CreateTicketMobile();
        },
        desktop: (BuildContext context) {
          return const CreateTicketWeb();
        },
      tablet: (BuildContext context){
        return OrientationBuilder(builder: (BuildContext context, Orientation orientation){
          return orientation == Orientation.landscape ? const CreateTicketWeb() : const CreateTicketMobile();
        });
      },
    );
  }
}

