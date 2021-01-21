import 'package:driver_track/data/models/trip.dart';
import 'package:driver_track/ui/trips/detail/trip_detail_start_screen.dart';
import 'package:driver_track/ui/utils/base_bloc_state.dart';
import 'package:driver_track/ui/utils/navigator_manager.dart';
import 'package:driver_track/ui/utils/styles.dart';
import 'package:driver_track/ui/widgets/background.dart';
import 'package:driver_track/ui/widgets/buttons.dart';
import 'package:driver_track/ui/widgets/labels.dart';
import 'package:driver_track/ui/widgets/text_view.dart';
import 'package:flutter/material.dart';

import 'trip_detail_bloc.dart';

class TripDetailScreen extends StatefulWidget {
  final Trip trip;

  const TripDetailScreen({Key key, this.trip}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TripDetailScreenState();
}

class _TripDetailScreenState
    extends BaseBlocState<TripDetailScreen, TripDetailBloc> {
  Trip trip;

  @override
  void initState() {
    bloc = TripDetailBloc(widget.trip);
    trip = widget.trip;
    super.initState();
  }

  Future<bool> navBack() async {
    NavigatorManager().getKey().currentState.pop(bloc.trip);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: navBack,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            height: double.maxFinite,
            decoration: AppGradientBackground(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: AppDimens.sizeLarge),
                  Container(
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: <Widget>[
                        Center(
                          child: AppText.title(
                            'Detalle del viaje',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: AppDimens.sizeDefault,
                          ),
                          child: AppBackButton(
                            isLight: true,
                            onClick: () async {
                              await navBack();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: AppDimens.sizeLarge,
                      horizontal: AppDimens.sizeDefault,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(
                            horizontal: AppDimens.sizeDefault,
                            vertical: AppDimens.sizeDefault,
                          ),
                          decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(0.5),
                              borderRadius: AppBorderRadius.regular),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AppTextView(
                                'Cliente',
                                trip.clientName,
                              ),
                              AppTextView(
                                'Fecha',
                                trip.date,
                              ),
                              AppTextView(
                                'Hora',
                                trip.hour,
                              ),
                              // if (trip.price != null) AppTextView(
                              //   "Precio del viaje",
                              //   "S/. " + trip.price.toStringAsFixed(2),
                              //   paddingBelow: AppDimens.none,
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(height: AppDimens.sizeDefault),
                        bottomActionButton(),
                        SizedBox(
                          height: AppDimens.sizeDefault,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomActionButton() {
    return StreamBuilder<TripStatus>(
      stream: this.bloc.tripStatus.stream,
      initialData: trip.getTripStatus(),
      builder: (context, snapshot) {
        if (snapshot.data == TripStatus.PENDING) {
          return startTripView();
        } else if (snapshot.data == TripStatus.IN_PROGRESS) {
          return endTripView();
        }
        return Container();
      },
    );
  }

  Widget startTripView() => ConstrainedBox(
        constraints: BoxConstraints(minWidth: 250),
        child: AppRaisedButton(
          'Iniciar viaje',
          fillColor: AppColors.white,
          textColor: AppColors.textPrimary,
          onClick: openStartTripScreen,
        ),
      );

  Widget endTripView() => ConstrainedBox(
        constraints: BoxConstraints(minWidth: 250),
        child: AppRaisedButton(
          'Terminar viaje',
          fillColor: AppColors.white,
          textColor: AppColors.textPrimary,
          onClick: bloc.endTrip,
        ),
      );

  void openStartTripScreen() async {
    try {
      var result = await showDialog<bool>(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            content: TripDetailStartScreen(trip: trip),
          );
        },
      );
      if (result) {
        bloc.startTrip();
      }
    } on Exception catch (err) {
      debugPrint(err.toString());
    }
  }
}
