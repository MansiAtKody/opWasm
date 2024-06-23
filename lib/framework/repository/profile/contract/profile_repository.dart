import 'package:dio/dio.dart';

abstract class ProfileRepository{

  ///get profile detail of admin
   Future getProfileDetail();

   ///change password
   Future changePassword(String request);

   Future updateProfileImageApi(FormData request,String uuid);

   /// Update Email
   Future updateEmailMobile(String request,bool isEmail);

   /// Check Password
   Future checkPassword(String request);

}