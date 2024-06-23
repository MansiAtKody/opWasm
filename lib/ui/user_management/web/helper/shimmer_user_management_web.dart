import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';

class ShimmerUserManagementWeb extends StatelessWidget
    with BaseStatelessWidget {
  const ShimmerUserManagementWeb({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 34.h,
          ),

          ///Page Title
          CommonShimmer(
            height: 17.h,
            width: context.width * 0.1,
          ).paddingSymmetric(horizontal: 36.w),
          SizedBox(
            height: 37.h,
          ),

          ///Page Body Widget
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Titles of User List
                  Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      _columnTitleWidget(
                        flex: 4,
                        verticalPadding: 15.h,
                        horizontalPadding: 16.w,
                      ),
                      _columnTitleWidget(
                        flex: 4,
                        verticalPadding: 15.h,
                        horizontalPadding: 16.w,
                      ),
                      _columnTitleWidget(
                        flex: 7,
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            const Expanded(
                              child: SizedBox(),
                            ),
                            CommonShimmer(
                              height: 10.h,
                              width: context.width * 0.05,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 40.w,
                      ),
                    ],
                  ).paddingSymmetric(vertical: 20.h),

                  ///User List
                  SizedBox(
                    height: context.height * 0.45,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        ///User Profile List Tile
                        return _userProfileList(context)
                            .paddingOnly(bottom: 20);
                      },
                      itemCount: 5,
                      shrinkWrap: true,
                    ),
                  )
                ],
              ),
            ).paddingSymmetric(horizontal: 40.w, vertical: 40.h),
          ).paddingSymmetric(horizontal: 36.w),
          SizedBox(
            height: context.height * 0.08,
          ),
        ],
      ),
    );
  }
}

///User Column Title Widget
Widget _columnTitleWidget(
    {required int flex, double? verticalPadding, double? horizontalPadding}) {
  return Expanded(
    flex: flex,
    child: CommonShimmer(
      height: 10.h,
      width: 57.w,
    ).paddingSymmetric(
        vertical: verticalPadding ?? 0, horizontal: horizontalPadding ?? 0),
  );
}

/// Shimmer User Profile List Widget
Widget _userProfileList(BuildContext context) {
  return Container(
    height: 76.h,
    decoration: BoxDecoration(
      color: AppColors.lightPinkF7F7FC,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(20.r),
    ),
    child: Row(
      children: [
        SizedBox(
          width: context.width * 0.02,
        ),
        Expanded(
          flex: 4,
          child: Row(
            children: [
              /// Product Image
              ClipOval(
                child: CommonShimmer(
                  height: 53.h,
                  width: 53.h,
                ),
              ).paddingSymmetric(vertical: 10.h, horizontal: 10.w),
              Expanded(
                child: CommonShimmer(
                  height: 10.h,
                  width: context.width * 0.1,
                ),
              )
            ],
          ),
        ),
        const Expanded(child: SizedBox()),
        Expanded(
          flex: 4,
          child: CommonShimmer(
            height: 10.h,
            width: context.width * 0.1,
          ).paddingOnly(right: 15.w),
        ),
        Expanded(
          flex: 7,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonShimmer(
                width: context.width * 0.08,
                height: 43.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.r),
                    color: AppColors.black),
              ),
              const Expanded(
                child: SizedBox(),
              ),
            ],
          ),
        ),
        // const Expanded(child: SizedBox()),
        CommonShimmer(
          width: 44.w,
          height: 22.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(36.r),
              color: AppColors.black),
        ),
        SizedBox(
          width: 60.w,
        ),
      ],
    ),
  );
}
