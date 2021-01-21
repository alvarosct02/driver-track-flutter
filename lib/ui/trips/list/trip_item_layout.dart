import 'package:driver_track/data/models/trip.dart';
import 'package:driver_track/ui/utils/styles.dart';
import 'package:driver_track/ui/widgets/background.dart';
import 'package:driver_track/ui/widgets/labels.dart';
import 'package:flutter/material.dart';

class TripListItemLayout extends StatelessWidget {
  final Trip _trip;
  void Function(Trip) onTripClicked;

  TripListItemLayout(this._trip, this.onTripClicked);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          onTripClicked(_trip);
        },
        child: Container(
          width: double.infinity,
          decoration: AppFlatCard(),
          padding: EdgeInsets.symmetric(
            horizontal: AppDimens.sizeDefault,
            vertical: AppDimens.sizeSmallPlus,
          ),
          child: Container(
//            color: Colors.red,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.title(
                          _trip.clientName,
                          maxLines: 2,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: AppDimens.sizeSmall),
                        AppText.body(
                          "${_trip.date} ${_trip.hour}",
                          textAlign: TextAlign.start,
                          maxLines: 3,
                          textWeight: AppWeight.semibold,
                          textColor: AppColors.textSecondary,
                          opacity: 0.6,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
