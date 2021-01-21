import 'package:flutter/material.dart';

class DialogManager {
  static final DialogManager _instance = DialogManager._internal();

  GlobalKey<State> _dialogKey = new GlobalKey<State>();

  factory DialogManager() {
    return _instance;
  }

  DialogManager._internal();

  Future<void> show(BuildContext context, {String message = ""}) {
    if (_dialogKey.currentContext != null) {
      hide();
    }
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
            onWillPop: () async => false,
            child: _renderLoadingDialog(_dialogKey, message),
          );
        });
  }

  void hide() {
    if (_dialogKey.currentContext != null) {
      Navigator.of(_dialogKey.currentContext, rootNavigator: true).pop();
    }
    _dialogKey = new GlobalKey<State>();
  }

  Future<void> showAlert(BuildContext context, {String message = ""}) {
    if (_dialogKey.currentContext != null) {
      hide();
    }
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog  (
                    content: Text(message),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Ok'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ]
                    )
            );
        });
  }

  _renderLoadingDialog(GlobalKey<State<StatefulWidget>> dialogKey, String message) {
    return SimpleDialog(
        key: dialogKey,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        children: <Widget>[
          Center(
            child: Column(children: [
              CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                message,
                style: TextStyle(color: Colors.white),
              )
            ]),
          )
        ]);
  }
}
