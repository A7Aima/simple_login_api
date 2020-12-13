import 'package:flutter/material.dart';

class RectangularButtonsHealth extends StatelessWidget {
  final Function onPressed;
  final String label;

  const RectangularButtonsHealth({
    Key key,
    @required this.onPressed,
    @required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        onPressed: onPressed,
        child: Text(label.toUpperCase()),
        textColor: Colors.white,
        color: Colors.red,
      ),
    );
  }
}
