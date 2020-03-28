import 'package:covid19/src/models/country.dart';
import 'package:covid19/src/utils/formats.dart';

class Data {
  final List<Country> countries;
  final String date;

  static int totalConfirmed = 0;
  static int totalRecovered = 0;
  static int totalDeaths = 0;

  Data(this.countries, this.date);

  Data.fromJson(Map<String, dynamic> json) :
    countries = _getCountriesFromJson(json),
    date = Formats.d.format(DateTime.parse(json['Date']));

  static List<Country> _getCountriesFromJson(Map<String, dynamic> json) {
    _clearTotals();
    List<Country> listCountries = new List<Country>();
    var jsonList = json['Countries'];
    jsonList.forEach((countryJson) {
      var country = Country.fromJson(countryJson);
      _calculateTotals(country);
      // Remove empty datas
      if (country.name.isNotEmpty)
        listCountries.add(country);
    });
    // Order List by 'Total Confirmed'
    listCountries.sort((a, b) => b.totalConfirmed.compareTo(a.totalConfirmed));
    return listCountries;
  }

  static void _clearTotals() {
    totalConfirmed = 0;
    totalRecovered = 0;
    totalDeaths = 0;
  }

  static void _calculateTotals(Country country) {
    totalConfirmed += country.totalConfirmed;
    totalRecovered += country.totalRecovered;
    totalDeaths += country.totalDeaths;
  }
}