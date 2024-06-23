import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';

class User {
  String userProfileImage;
  String userName;
  String email;
  UserStatus userStatus;

  User({
    this.userProfileImage = staticImageURL,
    this.userName = 'Operator',
    this.email = 'maharaj2@gmail.com',
    this.userStatus = UserStatus.active,
  });
}
