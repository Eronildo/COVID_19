import 'package:flutter/material.dart';

class BarRow extends StatelessWidget {
  final double screenWidth;
  final int totalActive;
  final int totalRecovered;
  final int totalDeaths;
  final int totalConfirmed;

  final double _minWidth = 5;

  const BarRow({
    Key key,
    this.screenWidth,
    this.totalActive,
    this.totalRecovered,
    this.totalDeaths,
    this.totalConfirmed}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          _getBarItem(Colors.yellow, totalActive, const EdgeInsets.only(right: 3.0)),
          _getBarItem(Colors.green, totalRecovered, const EdgeInsets.symmetric(horizontal: 3.0)),
          _getBarItem(Colors.grey[700], totalDeaths, const EdgeInsets.only(left: 3.0)),
        ],
      ),
    );

  Widget _getBarItem(Color color, int value, EdgeInsets padding) {
    return value > 0 ? Padding(
      padding: padding,
      child: Container(
        height: 5.0,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(25.0)
        ),
        width: _getWidth(value),
      ),
    ) : Container();
  }

  double _getWidth(int value) {
    var width = (screenWidth * value) / totalConfirmed;
    return width < _minWidth && width > 0 ? _minWidth : width;
  }
}
