
abstract class SelectLocationRepository {
    /// Get Location Point API
    Future getLocationListApi({required int pageNumber});

    /// Get Location Point List API
    Future getLocationPointListApi({required String request, required int pageNumber});

    /// Get Profile Detail API
    Future getProfileDetail();
}

