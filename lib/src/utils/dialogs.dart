import 'package:covid19/src/models/country.dart';
import 'package:covid19/src/widgets/bar_row.dart';
import 'package:covid19/src/widgets/case_row.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static showCountryDetails(BuildContext context, Country country) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0.0),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                    child: Text(country.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),),
                  ),
                  DefaultTextStyle(
                    style: TextStyle(color: Colors.red),
                    child: CaseRow(
                      color: null,
                      title: "Total Confirmed",
                      value: country.totalConfirmed,
                    ),
                  ),
                  BarRow(
                    screenWidth: MediaQuery.of(context).size.width - 120,
                    totalConfirmed: country.totalConfirmed,
                    totalActive: country.totalConfirmed - (country.totalRecovered + country.totalDeaths),
                    totalRecovered: country.totalRecovered,
                    totalDeaths: country.totalDeaths,
                  ),
                  CaseRow(
                    color: Colors.yellow,
                    title: "Total Active",
                    value: country.totalConfirmed - (country.totalRecovered + country.totalDeaths),
                  ),
                  CaseRow(
                    color: Colors.green,
                    title: "Total Recovered",
                    value: country.totalRecovered,
                  ),
                  CaseRow(
                    color: Colors.grey[700],
                    title: "Total Deaths",
                    value: country.totalDeaths,
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}