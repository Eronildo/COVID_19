import 'package:covid19/src/blocs/app_bloc.dart';
import 'package:covid19/src/models/country.dart';
import 'package:covid19/src/models/data.dart';
import 'package:covid19/src/utils/dialogs.dart';
import 'package:covid19/src/utils/formats.dart';
import 'package:covid19/src/widgets/bar_row.dart';
import 'package:covid19/src/widgets/case_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appBloc = Provider.of<AppBloc>(context);
    return StreamBuilder<bool>(
      stream: appBloc.getLoading,
      builder: (context, snapshotLoading) {
        return Scaffold(
          appBar: AppBar(
            title: Text('COVID-19'),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: (snapshotLoading.hasData && snapshotLoading.data) ? null :
                () {
                  appBloc.setData();
                }
              ),
            ],
          ),
          body: StreamBuilder<Data>(
            stream: appBloc.getData,
            builder: (context, AsyncSnapshot<Data> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData)
                  return Center(child: Text('NO DATA!'),);
                else {
                  var data = snapshot.data;
                  return Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, left: 15.0, right: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _getHeader(context),
                            Divider(),
                            _getListOfCountries(context, data),
                            Divider(),
                            _getFooter(data.date),
                          ],
                        ),
                      ),
                      _getDataLoading(snapshotLoading),
                    ]
                  );
                }
              }
            },
          ),
        );
      }
    );
  }

  Widget _getDataLoading(AsyncSnapshot<bool> snapshotLoading) {
    return (snapshotLoading.hasData && snapshotLoading.data) ?
      Container(
        color: Colors.black26,
        child: Center(child: CircularProgressIndicator()),
      ) : Container();
  }

  Widget _getHeader(BuildContext context) => Padding(
    padding: const EdgeInsets.only(right: 8.0),
    child: Column(
      children: <Widget>[
        Text('Total Confirmed',
          style: TextStyle(fontSize: 20, color: Colors.white54, fontWeight: FontWeight.bold),
        ),
        Text(Formats.f.format(Data.totalConfirmed),
          style: TextStyle(fontSize: 30, color: Colors.red, fontWeight: FontWeight.bold),
        ),
        BarRow(
          screenWidth: MediaQuery.of(context).size.width - 50,
          totalConfirmed: Data.totalConfirmed,
          totalActive: Data.totalConfirmed - (Data.totalRecovered + Data.totalDeaths),
          totalRecovered: Data.totalRecovered,
          totalDeaths: Data.totalDeaths,
        ),
        CaseRow(
          color: Colors.yellow,
          title: "Total Active",
          value: Data.totalConfirmed - (Data.totalRecovered + Data.totalDeaths),
        ),
        CaseRow(
          color: Colors.green,
          title: "Total Recovered",
          value: Data.totalRecovered,
        ),
        CaseRow(
          color: Colors.grey[700],
          title: "Total Deaths",
          value: Data.totalDeaths,
        ),
      ],
    ),
  );

  Widget _getListOfCountries(BuildContext context, Data data) => Expanded(
      child: ListView(
        children: data.countries.map(
          (country) => _getCountryCard(context, country)
        ).toList(),
      ),
    );

  Widget _getFooter(String date) => Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Text("Last Updated at: $date",
        style: TextStyle(fontSize: 14, color: Colors.white54, fontWeight: FontWeight.bold)
      ),
    );
  
  Widget _getCountryCard(BuildContext context, Country country) {
    return InkWell(
      onTap: () {
        Dialogs.showCountryDetails(context, country);
      },
      child: Card(
        child: ListTile(
          title: Text(country.name, style: TextStyle(fontSize: 18.0),),
          trailing: Text(Formats.f.format(country.totalConfirmed), style: TextStyle(fontSize: 18.0),),
        ),
      ),
    );
  }
}
