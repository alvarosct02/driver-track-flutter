import 'package:driver_track/data/models/trip.dart';
import 'package:driver_track/data/models/user.dart';
import 'package:driver_track/ui/utils/base_bloc_state.dart';
import 'package:driver_track/ui/utils/styles.dart';
import 'package:driver_track/ui/widgets/background.dart';
import 'package:driver_track/ui/widgets/buttons.dart';
import 'package:driver_track/ui/widgets/labels.dart';
import 'package:driver_track/ui/widgets/text_view.dart';
import 'package:flutter/material.dart';

import 'profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  static const String route = "/profile";

  const ProfileScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends BaseBlocState<ProfileScreen, ProfileBloc> {
  @override
  void initState() {
    bloc = ProfileBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          'Mi Perfil',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: AppDimens.sizeDefault,
                        ),
                        child: AppBackButton(isLight: true),
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
                        child: StreamBuilder<User>(
                            stream: bloc.userStream.stream,
                            initialData: null,
                            builder: (context, snapshot) {
                              var user = snapshot.data;
                              if (user == null) return Container();
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  AppTextView(
                                    'Nombres',
                                    user.firstName,
                                  ),
                                  AppTextView(
                                    'Apellidos',
                                    user.lastName,
                                  ),
                                  AppTextView(
                                    'Correo',
                                    user.email,
                                  ),
                                  AppTextView(
                                    'Empresa',
                                    user.companyName,
                                  ),
                                  AppText.body("Información del vehículo",
                                  textWeight: AppWeight.bold,
                                  vSpace: AppDimens.sizeDefault,),
                                  AppTextView(
                                    'Marca',
                                    user.carBrand,
                                  ),
                                  AppTextView(
                                    'Modelo',
                                    user.carModel,
                                  ),
                                  AppTextView(
                                    'Placa',
                                    user.carPlate,
                                  ),
                                ],
                              );
                            }),
                      ),
                      SizedBox(height: AppDimens.sizeDefault),
                      Align(
                        alignment: Alignment.centerRight,
                        child: AppRaisedButton(
                          'Cerrar Sesión',
                          fillColor: AppColors.white,
                          paddingHorizontal: AppDimens.sizeLarge,
                          textColor: AppColors.textPrimary,
                          onClick: bloc.logout,
                        ),
                      ),
                      SizedBox(height: AppDimens.sizeDefault),
                    ],
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
