import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/utility/extension/string_extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_button.dart';
import 'package:kody_operator/ui/widgets/common_card.dart';

class CreateRequestButton extends StatelessWidget with BaseStatelessWidget {
  const CreateRequestButton({super.key, this.onTap});

  final void Function()? onTap;

  @override
  Widget buildPage(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return CommonCard(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60.r),
              topRight: Radius.circular(60.r),
            ),
          ),
          child: CommonButton(
            buttonText: LocalizationStrings.keyCreateRequest.localized,
            // rightIcon: const Icon(Icons.arrow_forward, color: AppColors.white),
            onTap: () {},
          ),
        );
      },
    );
  }
}
