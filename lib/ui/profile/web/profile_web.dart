import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/profile/profile_controller.dart';
import 'package:kody_operator/ui/profile/web/helper/profile_body_widget.dart';
import 'package:kody_operator/ui/profile/web/shimmer/shimmer_profile_web.dart';
import 'package:kody_operator/ui/utils/helpers/base_page_widget.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class ProfileWeb extends ConsumerStatefulWidget {
  const ProfileWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileWeb> createState() => _ProfileWebState();
}

class _ProfileWebState extends ConsumerState<ProfileWeb>
    with BaseConsumerStatefulWidget, BaseDrawerPageWidget {
  ///Init Override
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final profileWatch = ref.watch(profileController);
      profileWatch.disposeController(isNotify: true);
      profileWatch.getProfileDetail(context);
      // Future.delayed(const Duration(seconds: 3), () {
      //   profileWatch.updateLoadingStatus(false);
      // });
    });
  }


  ///Build Override
  @override
  Widget buildPage(BuildContext context) {
    final profileWatch = ref.watch(profileController);
    return profileWatch.profileDetailState.isLoading ? const ShimmerProfileWeb() : const ProfileBodyWidget();
  }
}
