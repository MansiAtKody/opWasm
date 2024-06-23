import 'package:kody_operator/framework/repository/help_and_support/model/chat_model.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';

class TicketModel {
  final String? id;
  final String? title;
  final String? description;
  final TicketStatus? ticketStatus;
  final DateTime? date;
  final String? ticketId;
  List<ChatModel>? chats;

  TicketModel({
    this.id,
    this.title,
    this.description,
    this.ticketStatus,
    this.date,
    this.ticketId,
    this.chats,
  });
}
