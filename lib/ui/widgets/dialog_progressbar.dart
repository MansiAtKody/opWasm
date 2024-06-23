
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class DialogProgressBar extends StatelessWidget with BaseStatelessWidget {
  final bool isLoading;
  final bool forPagination;

  const DialogProgressBar({
    Key? key,
    required this.isLoading,
    this.forPagination = false,
  }) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return !(isLoading)
        ? const Offstage()
        : (forPagination)
            ? SizedBox(
                height: 70.h,
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.black),
                  ),
                ),
              )
            : AbsorbPointer(
                absorbing: true,
                child: Container(
                  decoration: BoxDecoration(
                     borderRadius: BorderRadius.all(Radius.circular(18.r)),
                    color: Colors.black.withOpacity(0.1),

                  ),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.black),
                      ),
                    ),
                  ),
                ),
              );
  }
}
