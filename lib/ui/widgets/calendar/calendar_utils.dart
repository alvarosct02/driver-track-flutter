import 'package:flutter/material.dart';
import 'package:driver_track/ui/utils/styles.dart';
import 'package:driver_track/ui/widgets/buttons.dart';
import 'package:driver_track/ui/widgets/calendar/calendar_month_view.dart';
import 'package:driver_track/ui/widgets/labels.dart';

String weekdayToAbbreviatedString(int weekday) {
  switch (weekday) {
    case DateTime.monday:
      return "L";
    case DateTime.tuesday:
      return "M";
    case DateTime.wednesday:
      return "M";
    case DateTime.thursday:
      return "J";
    case DateTime.friday:
      return "V";
    case DateTime.saturday:
      return "S";
    case DateTime.sunday:
      return "D";
    default:
      return "-";
  }
}

String monthToString(int month) {
  switch (month) {
    case DateTime.january:
      return "Enero";
    case DateTime.february:
      return "Febrero";
    case DateTime.march:
      return "Marzo";
    case DateTime.april:
      return "Abril";
    case DateTime.may:
      return "Mayo";
    case DateTime.june:
      return "Junio";
    case DateTime.july:
      return "Julio";
    case DateTime.august:
      return "Agosto";
    case DateTime.september:
      return "Setiembre";
    case DateTime.october:
      return "Octubre";
    case DateTime.november:
      return "Noviembre";
    case DateTime.december:
      return "Diciembre";
    default:
      return "-";
  }
}

String monthToAbbreviatedString(int month) {
  return monthToString(month).substring(0,3);
}

String minuteOfDayToHourMinuteString(int minuteOfDay) {
  var aa = minuteOfDay <= 12 * 60 ? 'am' : 'pm';
  var mm = (minuteOfDay ~/ 60) % (12);
  if (mm == 0) mm = 12;
  return "$mm:00 $aa";
}

@immutable
class Event {
  Event({
    @required this.startMinuteOfDay,
    @required this.duration,
    @required this.title,
  });

  final int startMinuteOfDay;
  final int duration;

  final String title;

  String get timeRange =>
      "${minuteOfDayToHourMinuteString(startMinuteOfDay)} - ${minuteOfDayToHourMinuteString(startMinuteOfDay + duration)}";
}

class CalendarMonthViewHeader extends StatelessWidget {
  final DateTime month;
  final void Function() prevListener;
  final void Function() nextListener;

  const CalendarMonthViewHeader({
    Key key,
    @required this.month,
    @required this.prevListener,
    @required this.nextListener,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppDimens.sizeSmall),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: AppText.subtitle(
              "${monthToAbbreviatedString(month.month)} ${month.year}",
              textAlign: TextAlign.center,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: CalendarNavButton(
              icon: Icons.chevron_left,
              onClick: prevListener,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: CalendarNavButton(
              icon: Icons.chevron_right,
              onClick: nextListener,
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarPickerDialog extends StatelessWidget {
  final DateTime date;
  final DateTime selected;
  final void Function(DateTime) selectListener;

  const CalendarPickerDialog({Key key, this.date, this.selected, this.selectListener})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: CalendarMonthView(
        date: date,
        selected: selected,
        selectListener: (DateTime dateTime) {
          Navigator.of(context).pop();
          selectListener?.call(dateTime);
        },
      ),
    );
  }
}

class CalendarDayViewHeader extends StatelessWidget {
  final DateTime day;
  final void Function() dayListener;
  final void Function() prevListener;
  final void Function() nextListener;

  const CalendarDayViewHeader({
    Key key,
    @required this.day,
    @required this.dayListener,
    @required this.prevListener,
    @required this.nextListener,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppDimens.sizeSmall),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: AppBorderButton(
              "",
              onClick: dayListener,
              radius: 14,
              color: AppColors.primaryColor.withOpacity(0.6),
              fillColor: AppColors.white,
              paddingVertical: AppDimens.sizeSmallPlus,
              paddingHorizontal: AppDimens.sizeDefaultPlus,
              customChild: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.calendar_today,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(
                    width: AppDimens.sizeSmall,
                  ),
                  AppText.subtitle(
                    "${day.day} ${monthToAbbreviatedString(day.month)} ${day.year}",
                    textAlign: TextAlign.center,
                    textColor: AppColors.primaryColor,
                    textWeight: AppWeight.bold,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: CalendarNavButton(
              icon: Icons.chevron_left,
              onClick: prevListener,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: CalendarNavButton(
              icon: Icons.chevron_right,
              onClick: nextListener,
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarNavButton extends StatelessWidget {
  final IconData icon;
  final void Function() onClick;

  const CalendarNavButton({Key key, this.icon, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: AppBorderRadius.circle,
      child: Container(
        padding: EdgeInsets.all(AppDimens.sizeXXSmall),
        decoration: BoxDecoration(
          borderRadius: AppBorderRadius.circle,
          color: AppColors.textDisabled.withOpacity(0.1),
        ),
        child: Icon(
          icon,
          size: AppDimens.sizeLarge,
          color: AppColors.textPrimary,
        ),
      ),
      onTap: onClick,
    );
  }
}
