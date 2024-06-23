import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/framework/utility/extension/context_extension.dart';
import 'package:kody_operator/framework/utility/extension/extension.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:kody_operator/ui/widgets/common_shimmer.dart';

class ShimmerOrderManagementWeb extends StatelessWidget
    with BaseStatelessWidget {
  const ShimmerOrderManagementWeb({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Column(
      children: [
        /// Order Status Top Widget
        _orderStatusTopWidget(context),

        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _upComingOrders(context)),
              SizedBox(
                width: 35.w,
              ),
              Expanded(child: _ongoingOrders(context)),
              SizedBox(
                width: 35.w,
              ),
              Expanded(child: _pastOrderList(context))
            ],
          ).paddingSymmetric(horizontal: 26.w, vertical: 8.h),
        )
      ],
    );
  }
}

/// Shimmer Order Status Top Widget
Widget _orderStatusTopWidget(BuildContext context) {
  return Column(
    children: [
      ///App bar
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CommonShimmer(
                height: 57.h,
                width: 57.h,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.black),
              ).paddingOnly(right: 24.w),
              CommonShimmer(
                height: 20.h,
                width: context.width * 0.1,
              ).paddingOnly(right: 6.w),
              CommonShimmer(
                height: 24.h,
                width: 24.h,
              )
            ],
          ),
          Row(
            children: [
              CommonShimmer(
                height: 57.h,
                width: 57.h,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.black),
              ).paddingOnly(right: 20.w),
              CommonShimmer(
                height: 57.h,
                width: 57.h,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.black),
              ),
            ],
          )
        ],
      ),
      SizedBox(
        height: 30.h,
      ),

      Row(
        children: [
          Expanded(
            child: _orderDetailWidget(context),
          ),
          SizedBox(
            width: 35.w,
          ),
          Expanded(
            child: _orderDetailWidget(context),
          ),
          SizedBox(
            width: 35.w,
          ),
          Expanded(
            child: _orderDetailWidget(context),
          )
        ],
      )
    ],
  ).paddingSymmetric(horizontal: 32.w, vertical: 22.h);
}

/// Order Detail Widget
Widget _orderDetailWidget(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.11,
    decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(20.r))),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CommonShimmer(
          height: 70.h,
          width: 70.h,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: AppColors.black),
        ).paddingOnly(right: 11.w, left: 20.w),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonShimmer(
              height: 12.h,
              width: context.width * 0.07,
            ).paddingOnly(bottom: 10.h),
            CommonShimmer(
              height: 20.h,
              width: 30.w,
            )
          ],
        )
      ],
    ).paddingSymmetric(vertical: 14.h),
  );
}

/// ---------------------------- Shimmer Upcoming orders ---------------------------- ///
Widget _upComingOrders(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(20.r))),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonShimmer(height: 12.h, width: context.width * 0.08),
            CommonShimmer(height: 11.h, width: 60.w),
          ],
        ),
        SizedBox(
          height: 30.h,
        ),
        //const UserCard(),
        Expanded(
          child: ListView.separated(
            itemCount: 3,
            itemBuilder: (context, index) {
              return _userCardWebWidget(context);
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 20.h,
              );
            },
          ),
        )
      ],
    ).paddingSymmetric(horizontal: 21.w, vertical: 30.h),
  );
}

/// Shimmer User Card Web Widget
Widget _userCardWebWidget(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        color: AppColors.lightPink,
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
        border: Border.all(color: AppColors.pinkEDEDFF)),
    child: Column(
      children: [
        ///User Card Top Widget
        _userCardTopWidget(context),
        SizedBox(
          height: 21.h,
        ),
        Container(
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(Radius.circular(22.r)),
              border: Border.all(color: AppColors.greyE6E6E6)),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  CommonShimmer(
                    height: 40.h,
                    width: 40.h,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.black),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CommonShimmer(
                            height: 10.h, width: context.width * 0.05),
                        SizedBox(height: 5.h),
                        CommonShimmer(
                            height: 10.h, width: context.width * 0.07),
                      ],
                    ).paddingOnly(left: 10.w),
                  ),
                  CommonShimmer(
                      height: 40.h,
                      width: 40.h,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.black)),
                ],
              ).paddingSymmetric(horizontal: 10.w, vertical: 12.h);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                height: 0,
                color: AppColors.greyE6E6E6,
              ).paddingSymmetric(horizontal: 15.w);
            },
          ),
        ),
        SizedBox(
          height: 13.h,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: CommonShimmer(
                  height: 40.h,
                  width: context.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(33.r),
                      color: AppColors.black)),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: CommonShimmer(
                  height: 40.h,
                  width: context.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(33.r),
                      color: AppColors.black)),
            ),
          ],
        )
      ],
    ).paddingSymmetric(vertical: 16.h, horizontal: 16.w),
  );
}

/// Shimmer User Card Top Widget
Widget _userCardTopWidget(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      ///User Name And Location
      Expanded(
        flex: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonShimmer(height: 10.h, width: context.width * 0.08),
            SizedBox(height: 5.h),
            CommonShimmer(height: 10.h, width: 68.w),
          ],
        ),
      ),
      SizedBox(
        width: 5.w,
      ),

      ///View Note Widget
      Expanded(
        flex: 4,
        child: CommonShimmer(
          height: 28.h,
          width: context.width * 0.1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.r),
              color: AppColors.black),
        ),
      ),
      SizedBox(
        width: 5.w,
      ),

      ///Ticket Number
      Expanded(
        flex: 3,
        child: CommonShimmer(
          height: 28.h,
          width: context.width * 0.06,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.r),
              color: AppColors.black),
        ),
      )
    ],
  );
}

/// ---------------------------- Shimmer Ongoing orders ---------------------------- ///
Widget _ongoingOrders(BuildContext context) {
  return Container(
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.r))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonShimmer(height: 12.h, width: context.width * 0.08),
              CommonShimmer(height: 11.h, width: 60.w),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                primary: true,
                itemBuilder: (context, index) {
                  ///Common Chat Widget
                  return _ongoingOrderCardWeb(context)
                      .paddingOnly(bottom: 20.h);
                },
              ),
            ),
          )
        ],
      ).paddingSymmetric(horizontal: 21.w, vertical: 30.h));
}

/// Shimmer Ongoing Order Card Web
Widget _ongoingOrderCardWeb(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        color: AppColors.lightPink,
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
        border: Border.all(color: AppColors.pinkEDEDFF)),
    child: Column(
      children: [
        ///User Card Top Widget
        _userCardTopWidget(context),

        SizedBox(
          height: 21.h,
        ),

        Container(
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(Radius.circular(22.r)),
              border: Border.all(color: AppColors.greyE6E6E6)),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  CommonShimmer(
                    height: 40.h,
                    width: 40.h,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.black),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonShimmer(
                            height: 10.h, width: context.width * 0.05),
                        SizedBox(height: 5.h),
                        CommonShimmer(
                            height: 10.h, width: context.width * 0.07),
                      ],
                    ).paddingOnly(left: 10.w),
                  ),
                  const Spacer(),
                  CommonShimmer(
                    height: 40.h,
                    width: context.width * 0.04,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(46.r),
                        color: AppColors.black),
                  ),
                ],
              ).paddingSymmetric(horizontal: 10.w, vertical: 12.h);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                height: 0,
                color: AppColors.greyE6E6E6,
              ).paddingSymmetric(horizontal: 15.w);
            },
          ),
        ),
      ],
    ).paddingSymmetric(vertical: 16.h, horizontal: 16.w),
  );
}

/// ---------------------------- Shimmer Past orders ---------------------------- ///
Widget _pastOrderList(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(20.r))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonShimmer(height: 12.h, width: context.width * 0.08),
            CommonShimmer(height: 11.h, width: 60.w),
          ],
        ),
        SizedBox(
          height: 30.h,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              primary: true,
              itemBuilder: (context, index) {
                ///Common Chat Widget
                return _pastOrderCardWeb(context).paddingOnly(bottom: 20.h);
              },
            ),
          ),
        )
      ],
    ).paddingSymmetric(horizontal: 21.w, vertical: 30.h),
  );
}

/// Shimmer Past Order Card Widget
Widget _pastOrderCardWeb(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        color: AppColors.lightPink,
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
        border: Border.all(color: AppColors.pinkEDEDFF)),
    child: Column(
      children: [
        /// Name of person & order ID
        _userCardTopWidget(context),

        SizedBox(
          height: 21.h,
        ),

        /// List of the order
        Container(
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(Radius.circular(22.r)),
              border: Border.all(color: AppColors.greyE6E6E6)),
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return ListView.separated(
                shrinkWrap: true,
                itemCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      CommonShimmer(
                        height: 40.h,
                        width: 40.h,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.black),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonShimmer(
                                height: 10.h, width: context.width * 0.05),
                            SizedBox(height: 5.h),
                            CommonShimmer(
                                height: 10.h, width: context.width * 0.07),
                          ],
                        ).paddingOnly(left: 10.w),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 10.w, vertical: 12.h);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height: 0,
                    color: AppColors.greyE6E6E6,
                  ).paddingSymmetric(horizontal: 15.w);
                },
              );
            },
          ),
        ),
        SizedBox(
          height: 9.h,
        ),

        /// Dispatch Button
        CommonShimmer(
          height: 37.h,
          width: context.width * 0.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.r),
              color: AppColors.black),
        ),
      ],
    ).paddingSymmetric(vertical: 16.h, horizontal: 16.w),
  );
}
