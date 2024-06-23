import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';
import 'package:kody_operator/ui/routing/stack.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class SideMenuWidget extends StatelessWidget with BaseStatelessWidget {
  const SideMenuWidget({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Container(
          width: 80.w,
          height: double.infinity,
          color: AppColors.black,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  ref.read(navigationStackProvider).pushAndRemoveAll(const NavigationStackItem.home());
                },
                child: const Icon(
                  Icons.dashboard,
                  color: AppColors.white,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  ref.read(navigationStackProvider).pushRemove(const NavigationStackItem.setting());
                },
                child: const Icon(
                  Icons.settings,
                  color: AppColors.white,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: () {
                  ref.read(navigationStackProvider).pushRemove(const NavigationStackItem.profile());
                },
                child: const Icon(
                  Icons.person,
                  color: AppColors.white,
                ),
              ),
            ],
          ).paddingSymmetric(vertical: 30.h),
        );
      },
    );
  }
}
