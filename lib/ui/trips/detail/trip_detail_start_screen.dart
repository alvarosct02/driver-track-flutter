import 'package:driver_track/data/models/trip.dart';
import 'package:driver_track/ui/trips/detail/trip_detail_start_bloc.dart';
import 'package:driver_track/ui/utils/base_bloc_state.dart';
import 'package:driver_track/ui/utils/navigator_manager.dart';
import 'package:driver_track/ui/utils/styles.dart';
import 'package:driver_track/ui/widgets/buttons.dart';
import 'package:driver_track/ui/widgets/input_fields.dart';
import 'package:driver_track/ui/widgets/labels.dart';
import 'package:flutter/material.dart';

class TripDetailStartScreen extends StatefulWidget {
  final Trip trip;

  const TripDetailStartScreen({Key key, this.trip}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TripDetailStartScreenState();
}

class _TripDetailStartScreenState
    extends BaseBlocState<TripDetailStartScreen, TripDetailStartBloc> {
  TextEditingController tripCodeController = TextEditingController();

  @override
  void initState() {
    bloc = TripDetailStartBloc(widget.trip);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: AppGradientBackground(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AppText.caption("Codigo del viaje"),
          Container(
            // padding: EdgeInsets.symmetric(horizontal: AppDimens.sizeDefault),
            child: TextField(
              controller: tripCodeController,
              // keyboardType: keyboardType,
              // obscureText: obscureText,
              // readOnly: readOnly,
              style: AppTextStyles.display2.copyWith(letterSpacing: 6),
              // minLines: minLines,
              maxLines: 1,
              maxLength: 5,
              decoration: AppInputDecoration(""),
            ),
          ),
          SizedBox(height: AppDimens.sizeSmall),
          Container(
            width: double.maxFinite,
            // padding: EdgeInsets.symmetric(horizontal: pad),
            child: AppRaisedButton(
              'Validar',
              paddingVertical: AppDimens.sizeSmallPlus,
              onClick: validateManualCode,
            ),
          ),
          SizedBox(height: AppDimens.sizeDefault),
          Container(
            width: double.maxFinite,
            // padding: EdgeInsets.symmetric(horizontal: pad),
            child: AppBorderButton(
              'Escanear QR',
              paddingVertical: AppDimens.sizeSmallPlus,
              onClick: validateQRCode,
            ),
          ),
          StreamBuilder<bool>(
            stream: this.bloc.validationError.stream,
            initialData: false,
            builder: (context, snapshot) {
              if (snapshot.data) {
                return Container(
                  margin: EdgeInsets.only(top: AppDimens.sizeDefault),
                  child: AppText.caption(
                    "El código es incorrecto",
                    textColor: AppColors.red,
                  ),
                );
              } else {
                return Container();
              }
              return Container();
            },
          )
        ],
      ),
    );
  }

  void validateManualCode() async {
    var result =
        await bloc.validateManualCode(tripCodeController.text.toString());
    if (result) {
      NavigatorManager().getKey().currentState.pop(true);
    }
  }

  void validateQRCode() async {
    var result = await bloc.validateQRCode();
    if (result) {
      NavigatorManager().getKey().currentState.pop(true);
    }
  }
}
