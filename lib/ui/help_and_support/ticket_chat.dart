import 'package:kody_operator/framework/repository/help_and_support/model/get_ticket_list_response_model.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/help_and_support/mobile/ticket_chat_mobile.dart';
import 'package:kody_operator/ui/help_and_support/web/ticket_chat_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TicketChat extends StatelessWidget with BaseStatelessWidget {
  const TicketChat({Key? key, required this.ticketModel}) : super(key: key);

  final TicketResponseModel? ticketModel;

  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(mobile: (BuildContext context) {
      return TicketChatMobile(ticketModel: ticketModel);
    }, desktop: (BuildContext context) {
      return TicketChatWeb(ticketModel: ticketModel);
    },
      tablet: (BuildContext context){
        return OrientationBuilder(builder: (BuildContext context, Orientation orientation){
          return orientation == Orientation.landscape ? TicketChatWeb(ticketModel: ticketModel) : TicketChatMobile(ticketModel: ticketModel);
        });
      },
    );
  }
}
