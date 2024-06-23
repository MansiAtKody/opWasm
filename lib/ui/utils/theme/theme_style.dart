import 'package:kody_operator/ui/utils/theme/theme.dart';

class ThemeStyle {
  static ThemeData themeData(BuildContext context) {
    return ThemeData(
      // fontFamily: TextStyles.fontFamily,
      // primaryColor: AppColors.black,
      // textTheme: Theme.of(context).textTheme.apply(
      //       bodyColor: AppColors.textByTheme(),
      //     ),
      scaffoldBackgroundColor: AppColors.black,
      primarySwatch: Colors.blue,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      // appBarTheme: AppBarTheme(
      //   elevation: 0.0,
      //   backgroundColor: AppColors.scaffoldBGByTheme(),
      //   systemOverlayStyle: const SystemUiOverlayStyle(
      //     statusBarColor: AppColors.black171717,
      //     statusBarIconBrightness: Brightness.light,
      //     statusBarBrightness: Brightness.dark,
      //   ),
      // ),
    );
  }
}
