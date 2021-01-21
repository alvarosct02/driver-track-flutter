
import 'package:flutter/cupertino.dart';

/// Wrapper for stateful functionality to provide onInit calls in stateles widget
class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;

  bool initCompleted = false;

  StatefulWrapper({@required this.onInit, @required this.child});
  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}
class _StatefulWrapperState extends State<StatefulWrapper> {

  @override
  void initState() {
    if(widget.onInit != null) {
      widget.onInit();
      setState(() {
        widget.initCompleted = true;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.initCompleted ? widget.child : Container();
  }

}