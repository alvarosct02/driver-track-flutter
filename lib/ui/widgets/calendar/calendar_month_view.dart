import 'package:calendar_views/month_view.dart';
import 'package:flutter/material.dart';
import 'package:driver_track/extensions.dart';
import 'package:driver_track/ui/utils/styles.dart';
import 'package:driver_track/ui/widgets/calendar/calendar_utils.dart';
import 'package:driver_track/ui/widgets/labels.dart';

class CalendarMonthView extends StatefulWidget {
  final DateTime date;
  final DateTime selected;
  final void Function(DateTime) selectListener;

  const CalendarMonthView({Key key, this.date, this.selected, this.selectListener})
      : super(key: key);

  @override
  _CalendarMonthViewState createState() => new _CalendarMonthViewState();
}

class _CalendarMonthViewState extends State<CalendarMonthView> {
  DateTime _month;
  DateTime _selected;

  int _firstWeekday;

  bool _shouldShowHeader;

  bool _showExtendedDaysBefore;
  bool _showExtendedDaysAfter;

  @override
  void initState() {
    super.initState();

    _month = widget.date ?? DateTime.now();
    _selected = widget.selected;

    _firstWeekday = DateTime.monday;

    _shouldShowHeader = true;

    _showExtendedDaysBefore = true;
    _showExtendedDaysAfter = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimens.sizeSmallPlus),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppBorderRadius.regular,
        border: Border.all(
          width: 1.5,
          color: AppColors.textPrimary.withOpacity(0.6),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CalendarMonthViewHeader(
              month: _month,
              prevListener: () {
                setState(() {
                  var newDate =
                      new DateTime(_month.year, _month.month - 1, _month.day);
                  _month = newDate;
                });
              },
              nextListener: () {
                setState(() {
                  var newDate =
                      new DateTime(_month.year, _month.month + 1, _month.day);
                  _month = newDate;
                });
              }),
          SizedBox(
            height: AppDimens.sizeDefault,
          ),
          Container(
            height: 300,
            child: MonthView(
              month: _month,
              firstWeekday: _firstWeekday,
              dayOfMonthBuilder: _dayOfMonthBuilder,
              headerItemBuilder:
                  _shouldShowHeader ? _monthViewHeaderItemBuilder : null,
              showExtendedDaysBefore: _showExtendedDaysBefore,
              showExtendedDaysAfter: _showExtendedDaysAfter,
            ),
          ),
        ],
      ),
    );
  }

  Widget _monthViewHeaderItemBuilder(BuildContext context, int weekday) {
    return Container(
      margin: EdgeInsets.only(bottom: AppDimens.sizeDefault),
      child: new Center(
        child: AppText.caption(
          weekdayToAbbreviatedString(weekday),
          textWeight: AppWeight.bold,
          opacity: 0.6,
        ),
      ),
    );
  }

  Widget _dayOfMonthBuilder(BuildContext context, DayOfMonth dayOfMonth) {
    bool isSelected = _selected.compareDayOnly(dayOfMonth.day);

    return InkWell(
      onTap: () {
        setState(() {
          widget.selectListener?.call(dayOfMonth.day);
          _selected = dayOfMonth.day;
        });
      },
      child: new Container(
        child: Stack(
          children: <Widget>[
            if (isSelected)
              Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    margin: EdgeInsets.all(AppDimens.sizeSmall),
                    decoration: BoxDecoration(
                      borderRadius: AppBorderRadius.circle,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            Center(
              child: AppText.caption("${dayOfMonth.day.day}",
                  textWeight: AppWeight.bold,
                  textColor:
                      isSelected ? AppColors.white : AppColors.textPrimary,
                  opacity: dayOfMonth.isExtended ? 0.25 : 1),
            ),
          ],
        ),
      ),
    );
  }
}
