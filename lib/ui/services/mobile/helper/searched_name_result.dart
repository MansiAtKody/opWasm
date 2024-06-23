import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/controller/services/announcement_get_details_controller.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/services/mobile/helper/common_person_list_tile.dart';
import 'package:kody_operator/ui/utils/anim/slide_left_transition.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class SearchedNameResult extends ConsumerWidget with BaseConsumerWidget {

  const SearchedNameResult({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final announcementGetDetailsWatch = ref.watch(announcementGetDetailsController);
    return SlideLeftTransition(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                child: ListView.separated(
                    itemCount: announcementGetDetailsWatch.profiles.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    primary: true,
                    separatorBuilder: (BuildContext context, int index) {
                      /// Divider
                      return Divider(
                        height: 0,
                        color: AppColors.greyBEBEBE.withOpacity(0.5),
                      ).paddingSymmetric(horizontal: 20.w);
                    },
                    itemBuilder: (context, index) {{
                        return InkWell(
                        onTap: () {
                          announcementGetDetailsWatch.updateName(announcementGetDetailsWatch.profiles[index].name);
                          announcementGetDetailsWatch.updateListVisibilityFalse();
                          announcementGetDetailsWatch.checkIfAllFieldsValid();
                        },

                        ///Common Person Tile Result List
                        child: CommonPersonListTile(isSuffixVisible: false, borderRadius: 20.r, profile: announcementGetDetailsWatch.profiles[index]).paddingOnly(right: 40.w),
                      );
                      }
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
