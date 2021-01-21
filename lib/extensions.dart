import 'package:intl/intl.dart';

extension SuperLists<T> on List<T> {
  double sumByDouble(double Function(T) function) {
    double sum = 0;
    this.forEach((element) {
      sum += function.call(element);
    });
    return sum;
  }

  int sumBy(int Function(T) function) {
    int sum = 0;
    this.forEach((element) {
      sum += function.call(element);
    });
    return sum;
  }

  T find(bool Function(T) function) {
    for (var element in this) {
      if (function.call(element)) {
        return element;
      }
    }
    return null;
  }

  T firstOrNull() {
    return this.isEmpty ? null : this.first;
  }
}

extension SuperString on String {

  String capitalizeFirst() {
    var result = "";
    if (this.length > 0) {
      result += this.substring(0, 1).toUpperCase();
    }

    if (this.length > 1) {
      result += this.substring(1).toLowerCase();
    }

    return result;
  }

  DateTime stringToDate({String format = "yyyy-MM-dd HH:mm:ss"}) {
    try {
      final formatter = DateFormat(format);
      return formatter.parse(this);
    } catch(err) {
      return DateTime.now();
    }
  }
}

extension SuperDateTime on DateTime {

  bool compareDayOnly(DateTime other) {
    return this.year == other.year && this.month == other.month && this.day == other.day;
  }

  String dateToString({String format = "yyyy-MM-dd HH:mm:ss"}) {
    final formatter = DateFormat(format);
    return formatter.format(this);
  }

}