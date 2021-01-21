import 'package:driver_track/ui/splash/splash_bloc.dart';
import 'package:driver_track/ui/utils/base_bloc_state.dart';
import 'package:driver_track/ui/widgets/background.dart';
import 'package:driver_track/ui/widgets/logo.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseBlocState<SplashScreen, SplashBloc> {
  @override
  void initState() {
    bloc = SplashBloc();
    super.initState();
    bloc.init();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          decoration: const AppBackground(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Container(
                child: const AppLogo(
                  height: 300.0,
                ),
                padding: EdgeInsets.all(80.0),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              )
            ],
          ),
        ),
      );
}
