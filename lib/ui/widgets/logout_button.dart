import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';

class LogoutButton extends StatelessWidget with BaseStatelessWidget{
  const LogoutButton({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return FloatingActionButton(
          onPressed: () {
            // Session.userBox.delete(keyUserEmail);
            // Session.userBox.delete(keyLoginResponse);
            // ref
            //     .read(navigationStackProvider)
            //     .pushAndRemoveAll(const NavigationStackItem.login());
          },
          child: const Icon(Icons.logout),
        );
      },
    );
  }
}
