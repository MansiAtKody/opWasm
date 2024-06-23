
import 'package:kody_operator/framework/provider/network/api_result.dart';

abstract class HelpAndSupportRepository {
    /// Get Ticket List
    Future<ApiResult> getTicketList({required String request,required int pageNo,int? pageSize});

    /// Get Ticket List
    Future<ApiResult> getTicketDetails({required String uuid});

    /// Add Ticket API
    Future<ApiResult> addTicketApi({required String request});

    /// Get Reasons Api
    Future<ApiResult> getReasonsList({int? pageNo,int? pageSize,bool? activeRecords});
}

