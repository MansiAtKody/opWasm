extension IntExtension on int {

  DateTime milliSecondsToDateTime({bool? isUtc}) {
    return DateTime.fromMillisecondsSinceEpoch(this,isUtc: isUtc ?? false);
  }
}