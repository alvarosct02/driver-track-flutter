import 'dart:math';

import 'package:driver_track/data/models/trip.dart';
import 'package:driver_track/data/models/user.dart';
import 'package:driver_track/ui/profile/profile_screen.dart';
import 'package:driver_track/ui/trips/list/trip_item_layout.dart';
import 'package:driver_track/ui/utils/app_switch.dart';
import 'package:driver_track/ui/utils/base_bloc_events.dart';
import 'package:driver_track/ui/utils/base_bloc_state.dart';
import 'package:driver_track/ui/utils/dialog_manager.dart';
import 'package:driver_track/ui/utils/navigator_manager.dart';
import 'package:driver_track/ui/utils/styles.dart';
import 'package:driver_track/ui/widgets/background.dart';
import 'package:driver_track/ui/widgets/labels.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'trip_list_bloc.dart';

class TripListScreen extends StatefulWidget {
  static const String route = "/home";

  @override
  State<StatefulWidget> createState() => _TripListScreenState();
}

class ThemeColor {
  List<Color> gradient;
  Color backgroundColor;
  Color toggleButtonColor;
  Color toggleBackgroundColor;
  Color textColor;
  List<BoxShadow> shadow;

  ThemeColor({
    this.gradient,
    this.backgroundColor,
    this.toggleBackgroundColor,
    this.toggleButtonColor,
    this.textColor,
    this.shadow,
  });
}

class _TripListScreenState extends BaseBlocState<TripListScreen, TripListBloc> {
  bool showLoading = false;

  AppSwitch airportSwitch;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    bloc = TripListBloc();
    super.initState();
  }

  @override
  void handleNavigationEvent(NavEvent event) {
    switch (event.runtimeType) {
      case NavToMain:
        NavigatorManager().getKey().currentState.pushReplacementNamed('/main');
        break;
      default:
    }
  }

  void _onRefresh() {
    bloc.getTrips();
    bloc.getUserInfo();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: AppGradientBackground(),
          width: double.maxFinite,
          height: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: AppDimens.sizeDefault,
          ),
          child: SmartRefresher(
            enablePullDown: true,
            controller: _refreshController,
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: AppDimens.sizeLarge),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      AppText.display1(
                        'Project Taxi',
                        textAlign: TextAlign.center,
                      ),
                      Align(
                        alignment: const Alignment(1.0, 0.0),
                        child: RawMaterialButton(
                          onPressed: () {
                            NavigatorManager()
                                .getKey()
                                .currentState
                                .pushNamed(ProfileScreen.route);
                          },
                          constraints: BoxConstraints(minWidth: 0),
                          elevation: 2.0,
                          fillColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            size: AppDimens.sizeLarge,
                            color: AppColors.primaryColor,
                          ),
                          padding: EdgeInsets.all(AppDimens.sizeSmall),
                          shape: CircleBorder(),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: AppDimens.sizeDefault),
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.5),
                      borderRadius: AppBorderRadius.regular,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimens.sizeDefault,
                      vertical: AppDimens.sizeDefault,
                    ),
                    child: StreamBuilder<User>(
                      stream: bloc.userStream.stream,
                      initialData: User(),
                      builder: (context, snapshot) {
                        var user = snapshot.data;
                        if (user == null) { return Container(); }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppSwitch(
                              initialState: user.isAvailable(),
                              label: '',
                              valueWhenEnable: user.isBusy() ? 'Ocupado': 'Disponible',
                              valueWhenDisable: 'No Disponible',
                              onChangedListener: bloc.changeUserAvailability,
                            ),
                            SizedBox(height: AppDimens.sizeDefault),
                            airportSwitch = AppSwitch(
                              initialState: user.isAtAirport(),
                              label: '',
                              valueWhenEnable: 'En Aeropuerto',
                              valueWhenDisable: 'En Aeropuerto',
                              onChangedListener: (enable) {
                                changeAirportAvailability(context, enable);
                              },
                            ),
                          ],
                        );
                      }
                    ),
                  ),
                  SizedBox(height: AppDimens.sizeDefault),
                  StreamBuilder<List<Trip>>(
                    stream: this.bloc.trips.stream,
                    initialData: [],
                    builder: (context, snapshot) {
                      return snapshot.data.isEmpty
                          ? _emptyListView("No tienes ningún\nviaje pasado")
                          : ListView.separated(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: snapshot.data.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(height: AppDimens.sizeSmall);
                              },
                              itemBuilder: (context, i) {
                                return TripListItemLayout(
                                    snapshot.data[i], bloc.openTripDetail);
                              },
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _emptyListView(String text) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.sizeDefault,
        vertical: AppDimens.sizeDefault,
      ),
      child: Center(
        child: AppText.subtitle(
          text,
          opacity: 0.6,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),
    );
  }

  static const AIRPORT_LATITUDE = -12.022280;
  static const AIRPORT_LONGITUDE = -77.106996;
  static const ALLOWED_DISTANCE_IN_METERS = 300;

  void changeServiceAvailability(BuildContext context, bool enabled) async {
    bloc.changeUserAvailability(enabled);

  }

  void changeAirportAvailability(BuildContext context, bool enabled) async {
    if (enabled) {
      final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
      var position = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      debugPrint(position.toString());
      final distanceInMeters = calculateDistanceInMeters(position.latitude,
          position.longitude, AIRPORT_LATITUDE, AIRPORT_LONGITUDE);
      debugPrint(distanceInMeters.toString());

      // if (distanceInMeters <= ALLOWED_DISTANCE_IN_METERS) {
      if (distanceInMeters <= ALLOWED_DISTANCE_IN_METERS) {
        bloc.changeAirportAvailability(enabled);
      } else {
        DialogManager()
            .showAlert(context, message: 'Debes estar cerca del aeropuerto');
        bloc.forceDisableAtAirport();

      }
    }
  }

  double calculateDistanceInMeters(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)) * 1000;
  }
}
