import 'package:driver_track/ui/utils/base_bloc_state.dart';
import 'package:driver_track/ui/utils/styles.dart';
import 'package:driver_track/ui/widgets/background.dart';
import 'package:driver_track/ui/widgets/buttons.dart';
import 'package:driver_track/ui/widgets/input_fields.dart';
import 'package:driver_track/ui/widgets/labels.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'login_bloc.dart';

class LoginScreen extends StatefulWidget {
  static const String route = "/login";

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseBlocState<LoginScreen, LoginBloc> {
  bool showLoading = false;
  bool isKeyboardVisible = false;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    bloc = LoginBloc();
    super.initState();

    if (!kReleaseMode) {
      usernameController.text= 'driver1@hotmail.com';
      passwordController.text= '123456';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const AppBackground(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: LoginFormLayout(this),
          ),
        ),
      ),
    );
  }
}

class LoginFormLayout extends StatelessWidget {
  final _LoginScreenState state;

  LoginFormLayout(this.state);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppDimens.sizeXLarge,
        horizontal: AppDimens.sizeLarge,
      ),
      child: Column(
        children: <Widget>[
          AppText.display1(
            'Inicia sesión',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppDimens.sizeDefault),
          AppLabel(
            'Ingresa tus credenciales para iniciar sesión',
            textStyle: AppTextStyles.body,
          )..textAlign = TextAlign.center,
          SizedBox(height: AppDimens.sizeLargePlus),
          AppTextField(
            controller: state.usernameController,
            hint: 'Correo Electrónico',
            keyboardType: TextInputType.emailAddress,
          ),
          Container(margin: const EdgeInsets.only(top: AppDimens.sizeLarge)),
          AppTextField(
            controller: state.passwordController,
            hint: 'Contraseña',
            obscureText: true,
            icon: Icon(Icons.lock),
          ),
          Container(
            padding: EdgeInsets.only(top: AppDimens.sizeLarge),
            width: double.infinity,
            child: AppRaisedButton(
              "Iniciar sesión",
              onClick: () {
                state.bloc.login(
                  state.usernameController.text,
                  state.passwordController.text,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
