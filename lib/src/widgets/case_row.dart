import 'package:covid19/src/utils/formats.dart';
import 'package:flutter/material.dart';

class CaseRow extends StatelessWidget {
  final Color color;
  final String title;
  final int value;

  const CaseRow({Key key, this.color, this.title, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: <Widget>[
        color != null ? Icon(Icons.fiber_manual_record, color: color,) : Container(),
        SizedBox(width: 5.0,),
        Expanded(child: Text(title, style: TextStyle(fontSize: 18.0),)),
        Text(Formats.f.format(value), style: TextStyle(fontSize: 18.0),)
      ],
    ),
  );
}