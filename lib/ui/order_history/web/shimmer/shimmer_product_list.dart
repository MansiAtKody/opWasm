import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kody_operator/ui/order_history/web/shimmer/shimmer_product_list_tile.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';

class ShimmerProductList extends ConsumerWidget with BaseConsumerWidget {
  const ShimmerProductList({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 40.h,
            ),
            const Expanded(
              child: ShimmerProductListTile(),
            ),
          ],
        );
      },
    );
  }
}
