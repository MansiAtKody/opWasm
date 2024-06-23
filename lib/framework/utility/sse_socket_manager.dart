import 'package:flutter_client_sse/constants/sse_request_type_enum.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:kody_operator/framework/utility/session.dart';

class SSESocketManager {
  SSESocketManager._();

  static SSESocketManager instance = SSESocketManager._();

  String token =
      'eyJ4LWVudiI6IlBSRCIsImFsZyI6IlJTMjU2IiwieC1yZWciOiJFVSIsImtpZCI6InJldS1wcm9kdWN0aW9uIn0.eyJmZ3JwIjpbXSwiY2x0eSI6InByaXZhdGUiLCJzdWIiOiIzNjZmN2QyYy1lNDljLTRhY2ItYmQ5NS1mNmU3OGIxMmU3N2QiLCJhdWQiOiIzMzhCMUU3OUU3NzNBODZGNUE5NTJBQzlBMTk0RDRFQTUyQzA2REUzMTdCRjQxMEU1NEYzODFEQ0FBQzM3QjRCIiwiYXpwIjoiMzM4QjFFNzlFNzczQTg2RjVBOTUyQUM5QTE5NEQ0RUE1MkMwNkRFMzE3QkY0MTBFNTRGMzgxRENBQUMzN0I0QiIsInNjb3BlIjpbIklkZW50aWZ5QXBwbGlhbmNlIiwiQ29mZmVlTWFrZXIiXSwiaXNzIjoiRVU6UFJEOjIiLCJleHAiOjE3MDQ3Mjg3NzAsImlhdCI6MTcwNDY0MjM3MCwianRpIjoiYjk0MTQwYmEtYWUwNy00OThmLTg4N2ItYzcwNzc2M2Y5MWMzIn0.PxKUJWMSfUc9Fl60o7a8UKRE6EcISA6abZhJOEIuyofj-FzO1JqA_bzLSZl1cOT0SWHQBMway6yv-azlXYku-BXb7k_2gcWAeSkgpEuxJ1I70cdeUIPA1LPpQjamwfvmJ5gGO0JxabQWW99XmsyB1nIdZS3eb9_79nHlsaKQLbQAI_MYfuzyR7cgZhckWaZToYeOJyODcNdXZnr68eK21W81UE75-T4qDb0yI7g4ZHgydFmKdTbVJzbtWLe19kDdY2mV9sPxy9cegwByt_ikYKD2HXpu2U9BxpzRmOXQ7eJknSdCeORX85fn7makphMUMGW6M_yISTw8jQ-2pwMxDA';

  Future<void> subscribeSocket(Function(String data) onDataUpdate) async {
    SSEClient.subscribeToSSE(method: SSERequestType.GET, url: 'https://api.home-connect.com/api/homeappliances/BOSCH-CTL636EB6-68A40EA7DD54/events', header: {
      'Authorization': 'Bearer ${Session.getCoffeeAccessToken()}',
      'Accept': 'text/event-stream',
      'Cache-Control': 'no-cache',
    }).listen((event) {
      onDataUpdate.call(event.data!);
    });
  }

  Future<void> unSubscribeSocket() async {
    SSEClient.unsubscribeFromSSE();
  }
}
