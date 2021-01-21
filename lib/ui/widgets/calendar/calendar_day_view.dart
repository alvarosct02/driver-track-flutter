import 'package:calendar_views/calendar_views.dart';
import 'package:flutter/material.dart';
import 'package:driver_track/ui/utils/styles.dart';
import 'package:driver_track/ui/widgets/calendar/calendar_utils.dart';
import 'package:driver_track/ui/widgets/labels.dart';

class CalendarDayView extends StatefulWidget {
  final void Function(DateTime dateTime) selectListener;

  const CalendarDayView({Key key, this.selectListener}) : super(key: key);

  @override
  _CalendarDayViewState createState() => _CalendarDayViewState();
}

class _CalendarDayViewState extends State<CalendarDayView> {
  DateTime _day;
  int _minimumMinuteOfDay;
  int _maximumMinuteOfDay;

  @override
  void initState() {
    super.initState();

    _minimumMinuteOfDay = 8 * 60;
    _maximumMinuteOfDay = 24 * 60;

    _day = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CalendarDayViewHeader(
              day: _day,
              dayListener: () {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    child: CalendarPickerDialog(
                      date: _day,
                      selected: _day,
                      selectListener: (DateTime date){
                        setState(() {
                          _day = date;
                        });
                      },
                    ));
              },
              prevListener: () {
                setState(() {
                  var newDate =
                      new DateTime(_day.year, _day.month, _day.day - 1);
                  _day = newDate;
                });
              },
              nextListener: () {
                setState(() {
                  var newDate =
                      new DateTime(_day.year, _day.month, _day.day + 1);
                  _day = newDate;
                });
              }),
          Container(
            child: DayViewEssentials(
              widths: DayViewWidths(
                timeIndicationAreaWidth: 70,
                mainAreaStartPadding: 0,
                mainAreaEndPadding: 0,
              ),
              properties: DayViewProperties(
                days: <DateTime>[
                  DateTime.now(),
                ],
                minimumMinuteOfDay: _minimumMinuteOfDay,
                maximumMinuteOfDay: _maximumMinuteOfDay,
              ),
              child: DayViewSchedule(
                heightPerMinute: 1,
                bottomExtensionHeight: 60,
                topExtensionHeight: 30,
                components: <ScheduleComponent>[
                  TimeIndicationComponent.intervalGenerated(
                    generatedTimeIndicatorBuilder:
                        _generatedTimeIndicatorBuilder,
                  ),
                  SupportLineComponent.intervalGenerated(
                    generatedSupportLineBuilder: _generatedSupportLineBuilder,
                  ),
                  EventViewComponent(
                    getEventsOfDay: _getEventsOfDay,
                  )
                  // EventViewComponent(
                  //   getEventsOfDay: _getEventsOfDay,
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Positioned _generatedTimeIndicatorBuilder(
    BuildContext context,
    ItemPosition itemPosition,
    ItemSize itemSize,
    int minuteOfDay,
  ) {
    bool shouldShow = _minimumMinuteOfDay <= minuteOfDay &&
        minuteOfDay <= _maximumMinuteOfDay;

    return Positioned(
      top: itemPosition.top,
      left: itemPosition.left,
      width: itemSize.width,
      height: itemSize.height,
      child: !shouldShow
          ? Container()
          : Container(
              child: Align(
                alignment: Alignment.center,
                child: AppText.caption(
                  minuteOfDayToHourMinuteString(minuteOfDay),
                  textWeight: AppWeight.semibold,
                  textAlign: TextAlign.end,
                  opacity: 0.6,
                ),
              ),
            ),
    );
  }

  Positioned _generatedSupportLineBuilder(
    BuildContext context,
    ItemPosition itemPosition,
    double itemWidth,
    int minuteOfDay,
  ) {
    bool shouldShow = _minimumMinuteOfDay <= minuteOfDay &&
        minuteOfDay <= _maximumMinuteOfDay;
    bool isFirst = _minimumMinuteOfDay == minuteOfDay;
    bool isLast = _maximumMinuteOfDay == minuteOfDay;

    return Positioned(
      top: itemPosition.top,
      left: itemPosition.left,
      width: itemWidth,
      child: !shouldShow
          ? Container()
          : InkWell(
              onTap: () {
                debugPrint("${minuteOfDayToHourMinuteString(minuteOfDay)}");
                var date = DateTime(_day.year, _day.month, _day.day, minuteOfDay ~/ 60, 0, 0,0, 0);
                widget.selectListener?.call(date);
              },
              child: Container(
                height: isLast ? 30 : 61.5,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1.5, color: AppColors.textHint),
                    left: BorderSide(width: 1.5, color: AppColors.textHint),
                    right: BorderSide(width: 1.5, color: AppColors.textHint),
                    bottom: BorderSide(width: 1.5, color: AppColors.textHint),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isFirst ? 14 : 0),
                    topRight: Radius.circular(isFirst ? 14 : 0),
                    bottomLeft: Radius.circular(isLast ? 14 : 0),
                    bottomRight: Radius.circular(isLast ? 14 : 0),
                  ),
                ),
              ),
            ),
    );
  }

  Positioned _eventBuilder(
    BuildContext context,
    ItemPosition itemPosition,
    ItemSize itemSize,
    Event event,
  ) {
    return Positioned(
      top: itemPosition.top,
      left: itemPosition.left,
      width: itemSize.width,
      height: itemSize.height,
      child: ClipRRect(
        borderRadius: AppBorderRadius.small,
        child: Container(
          color: AppColors.steel,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                  width: double.maxFinite,
                  color: AppColors.black.withOpacity(0.1),
                  padding: EdgeInsets.symmetric(
                    vertical: AppDimens.sizeXSmall,
                    horizontal: AppDimens.sizeSmall,
                  ),
                  child: AppText.label(
                    event.timeRange,
                    size: 10,
                    textColor: AppColors.white,
                  )),
              Expanded(
                  child: Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(
                        vertical: AppDimens.sizeXSmall,
                        horizontal: AppDimens.sizeSmall,
                      ),
                      child: AppText.caption(
                        "${event.title}",
                        textWeight: AppWeight.semibold,
                        textColor: AppColors.white,
                      ))),
            ],
          ),
        ),
      ),
    );
  }

  List<StartDurationItem> _getEventsOfDay(DateTime day) {
    List<Event> events = eventsOfDay1;

    return events
        .map(
          (event) => new StartDurationItem(
            startMinuteOfDay: event.startMinuteOfDay,
            duration: event.duration,
            builder: (context, itemPosition, itemSize) => _eventBuilder(
              context,
              itemPosition,
              itemSize,
              event,
            ),
          ),
        )
        .toList();
  }

  List<Event> eventsOfDay1 = <Event>[
    Event(startMinuteOfDay: 9 * 60, duration: 120, title: "Dpto 501"),
  ];
}
