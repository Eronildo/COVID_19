import 'package:covid19/src/blocs/app_bloc.dart';
import 'package:covid19/src/pages/home_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var appBloc = AppBloc();
  @override
  Widget build(BuildContext context) {
    setOnlyPortrait();
    return Provider<AppBloc>.value(
      value: appBloc,
      child: MaterialApp(
        title: 'COVID-19 Global Cases',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        home: HomePage(),
      ),
    );
  }

  void setOnlyPortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    appBloc.dispose();
    super.dispose();
  }
}