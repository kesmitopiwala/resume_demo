import 'package:intl/intl.dart';


String timeAgoSinceDate(DateTime dateTime, {bool numericDates = true}) {
  final date2 = DateTime.now();
  final difference = date2.difference(dateTime);

  if (difference.inDays > 8) {
    return DateFormat("dd MMMM yyyy").format(dateTime);
  } else if ((difference.inDays / 7).floor() >= 1) {
    return (numericDates) ? '1 week ago': 'Last week';
  } else if (difference.inDays >= 2) {
    return '${difference.inDays} days ago';
  } else if (difference.inDays >= 1) {
    return (numericDates) ? '1 day ago': 'Yesterday';
  } else if (difference.inHours >= 2) {
    return '${difference.inHours} hours ago';
  } else if (difference.inHours >= 1) {
    return (numericDates) ? '1 hour ago': 'An hour ago';
  } else if (difference.inMinutes >= 2) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inMinutes >= 1) {
    return (numericDates) ? '1 minute ago': 'A minute ago';
  } else if (difference.inSeconds >= 3) {
    return '${difference.inSeconds} seconds ago';
  } else {
    return 'Just now';
  }
}

String? returnCorrectStringNull(String? value) {
  if (value == null || value == "") {
    return null;
  } else {
    return value;
  }
}

String returnCorrectStringString(String? value) {
  if (value == null) {
    return "";
  } else {
    return value;
  }
}

String returnCorrectStringInt(String? value) {
  if (value == null) {
    return "0";
  } else {
    return value;
  }
}

String returnCorrectStringNumber(int? value) {
  if (value == null) {
    return "0";
  } else {
    return value.toString();
  }
}

bool returnCorrectStringBool(String? value) {
  if (value == null || value == "") {
    return false;
  } else {
    return true;
  }
}

String? returnCorrectInitialValue(bool? value) {
  if (value == null) {
    return null;
  } else if (value == true) {
    return "Yes";
  } else {
    return "No";
  }
}

bool checkChangeText(String controllerText, String? objectText) {
  bool isControllerEmpty = controllerText.isEmpty;
  bool isObjectNotNull = objectText != null;
  bool areBothSame = controllerText != objectText;

  return isControllerEmpty && isObjectNotNull || areBothSame;
}


