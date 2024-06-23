import 'package:kody_operator/ui/utils/theme/app_assets.dart';

class ChatModel {
  /// Profile Image asset
  final String profile;

  /// Chat Content
  final String message;

  /// Date and Time of the chat sent
  final DateTime datetime;

  ChatModel({
    required this.message,
    required this.datetime,
    this.profile = AppAssets.icChatProfile,
  });
}
