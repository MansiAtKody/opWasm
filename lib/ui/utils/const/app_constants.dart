// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kody_operator/ui/splash/web/helper/rive_avtar.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';
import 'package:rive/rive.dart';

const String appName = 'Kody Operator';

WidgetRef? globalRef;

bool getIsIOSPlatform() => Platform.isIOS;

const String SOCKET_URL = 'http://49.13.228.207';
const int SOCKET_PORT = 9508;
const String MAHARAJ_EMAIL = 'maharaj@mailinator.com';
const String CHITTI_EMAIL = 'chitti@mailinator.com';
const String filterHero = 'filterHero';


const String additionalNote = 'Choose your desired size (small, regular, or large) and milk type (whole, skim, almond, oat, or soy). Specify coffee strength (regular, strong, or extra strong) and any toppings like cocoa powder, cinnamon, nutmeg, or chocolate shavings. Decide if you want sweetener (sugar, stevia, or none) and if you\'d like extra foam. Don\'t forget to share any special instructions to tailor your cappuccino just the way you like it!';

Color getTicketStatusColor(String status){
  final TicketStatus ticketStatus = ticketStatusString.map[status] ?? TicketStatus.pending;
  switch(ticketStatus){
    case TicketStatus.all:
      return AppColors.pendingTicketColor;
    case TicketStatus.pending:
      return AppColors.pendingTicketColor;
    case TicketStatus.resolved:
      return AppColors.resolvedTicketColor;
    case TicketStatus.acknowledged:
      return AppColors.acknowledgedTicketColor;
  }
}

Color getTicketStatusTextColor(String status){
  final TicketStatus ticketStatus = ticketStatusString.map[status] ?? TicketStatus.pending;
  switch(ticketStatus){
    case TicketStatus.all:
      return AppColors.pendingTicketTextColor;
    case TicketStatus.pending:
      return AppColors.pendingTicketTextColor;
    case TicketStatus.resolved:
      return AppColors.resolvedTicketTextColor;
    case TicketStatus.acknowledged:
      return AppColors.acknowledgedTicketTextColor;
  }
}


bool getIsAppleSignInSupport() => (iosVersion >= 13);
int iosVersion = 11;

String getDeviceType() => getIsIOSPlatform() ? 'iphone' : 'android';

int maxMobileLength = 10;
int maxEmailLength = 50;
int maxPasswordLength = 16;
int otpLength=6;

double buttonBottomPadding = 20.h;

///Page Size in Pagination
int pageSize = 15;

double globalPadding = 16.w;

const String staticImageURL = 'https://picsum.photos/250?image=9';

///Debug print
printData(data) {
  if (kDebugMode) {
    print(data);
  }
}

/// Hide Keyboard
hideKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}

///home order management popup value
enum PopUpStatus { Available, Offline, Unavailable }



double deviceHeight(BuildContext context) => MediaQuery.sizeOf(context).height;
double deviceWidth(BuildContext context) => MediaQuery.sizeOf(context).width;

const String startDateHero = 'startDateHero';
const String endDateHero = 'endDateHero';

String dateFormatFromDateTime(DateTime? dateTime, String format) {
  if (dateTime != null) {
    final DateFormat formatter = DateFormat(format);
    return formatter.format(dateTime);
  } else {
    return '';
  }
}

Future<RiveAvatar> loadAnimation(String animationPath) async {
  final data = await rootBundle.load(animationPath);
  final file = RiveFile.import(data);
  final artBoard = file.mainArtboard;
  return RiveAvatar(artBoard);
}

// void commonSnackBar(BuildContext context, String message){
//   var snackBar = SnackBar(
//       behavior: SnackBarBehavior.floating,
//
//       margin: EdgeInsets.only(left: context.width * 0.1, right: context.width * 0.1, bottom: context.height * 0.07),
//       backgroundColor: AppColors.transparent,
//       elevation: 0,
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//               padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
//               decoration: BoxDecoration(color: AppColors.black171717, borderRadius: BorderRadius.circular(5.r)),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Expanded(child: Text(message, style: TextStyles.regular.copyWith(color: AppColors.white, fontSize: 22.sp),).paddingOnly(right: 30.w)),
//                   InkWell(onTap: (){ScaffoldMessenger.of(context).hideCurrentSnackBar();},child: const Icon(Icons.close, color: AppColors.white,))
//                 ],
//               )),
//         ],
//       )
//   );
//   ScaffoldMessenger.of(context).showSnackBar(snackBar);
// }

String staticImageMasalaTea = 'https://media.istockphoto.com/id/502426854/photo/pour-the-tea.jpg?s=612x612&w=0&k=20&c=HLo3hJ1jcgbgA-YuCcz2fcCOEk7G547QhDfBC4ibniw=';
String staticImageLatte = 'https://aubreyskitchen.com/wp-content/uploads/2020/10/Cardamom-latte-square.jpg';
String staticImageCappuccino = 'https://as2.ftcdn.net/v2/jpg/01/32/60/49/1000_F_132604954_fNZWsHvcytbTg8j953syhcQCBXoCWGo1.jpg';
String staticImageBiscuit = 'https://theobroma.in/cdn/shop/products/Chocolate-Coated-Biscuits---Instagram-Feeds.jpg?v=1635432717';
String staticImageCookies = 'https://www.shugarysweets.com/wp-content/uploads/2020/05/chocolate-chip-cookies-recipe-500x500.jpg';
String staticImageURLHttps = 'https://picsum.photos/250?image=9';
String staticImageService = 'https://cdn-icons-png.flaticon.com/512/887/887997.png';

int pageSizeThousand =1000;

/// To format date and time fromMillisecondsSinceEpoch to {dd MMM yyyy \'at\' h:mma} as per the docs
String formatDatetime({required int createdAt,String? dateFormat}){
  final DateFormat format = DateFormat(dateFormat??'dd MMM yyyy \'at\' h:mma');
  final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(createdAt);
  final String formattedString = format.format(dateTime);
  return formattedString;
}