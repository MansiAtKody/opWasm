import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:kody_operator/ui/profile/mobile/delete_account_mobile.dart';
import 'package:kody_operator/ui/profile/web/delete_account_web.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  ///Build Override
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
        mobile: (BuildContext context) {
          return const DeleteAccountMobile();
        },
        desktop: (BuildContext context) {
          return const DeleteAccountWeb();
        }
    );
  }
}

