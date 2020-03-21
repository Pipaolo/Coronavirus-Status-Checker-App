import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:iso_countries/iso_countries.dart';

import '../model/covid_country.dart';

class CountryRepository {
  Future<List<CovidCountry>> fetchYesterdaysResult() async {
    return await populateCountries(true);
  }

  Future<List<CovidCountry>> fetchCurrentResult() async {
    return await populateCountries(false);
  }

  Future<List<CovidCountry>> populateCountries(bool isYesterday) async {
    final client = Client();
    Response response = await client
        .get('https://www.worldometers.info/coronavirus/#countries');

    var document = parse(response.body);

    List<Element> statistics = document.querySelectorAll(
        '#main_table_countries_${(isYesterday) ? 'yesterday' : 'today'}>tbody>tr');

    statistics.removeLast();

    final List<List<String>> rawCountries = statistics
        .map((e) => e.children
            .map(
              (e) => (e.text.trim() == '')
                  ? '0'
                  : e.text
                      .trim()
                      .replaceAll(',', '')
                      .replaceAll(' and ', ' & ')
                      .replaceAll('USA', 'United States')
                      .replaceAll('UK', 'United Kingdom')
                      .replaceAll('S. Korea', 'South Korea')
                      .replaceAll('UAE', 'United Arab Emirates')
                      .replaceAll('DRC', 'Dominican Republic')
                      .replaceAll('CAR', 'Central African Republic')
                      .replaceAll('Faeroe Islands', 'Faroe Islands')
                      .replaceAll('Macao', 'Macau'),
            )
            .toList())
        .toList();

    List<Country> countryCodes = await IsoCountries.iso_countries;

    List<CovidCountry> countries = rawCountries.map((e) {
      String countryCode = '';
      for (var country in countryCodes) {
        if (country.name.toLowerCase().contains(e[0].toLowerCase())) {
          countryCode = country.countryCode;
          break;
        } else if (country.name.toLowerCase().contains('macedonia')) {
          countryCode = country.countryCode;
        }
      }
      return CovidCountry(
        name: e[0],
        countryCode: countryCode ?? '',
        totalCases: int.parse(e[1]),
        newCases: int.parse(e[2]),
        totalDeaths: int.parse(e[3]),
        newDeaths: int.parse(e[4]),
        totalRecovered: int.parse(e[5]),
        activeCases: int.parse(e[6]),
        seriousOrCritical: int.parse(e[7]),
        totalCasesDividedByOneMillionPopulation: double.parse(e[8]),
      );
    }).toList();

    return countries;
  }

  Future<List<CovidCountry>> updateCountries(bool isYesterday) async {
    final client = Client();
    Response response = await client
        .get('https://www.worldometers.info/coronavirus/#countries');

    var document = parse(response.body);

    List<Element> statistics = document.querySelectorAll(
        '#main_table_countries_${(isYesterday) ? 'yesterday' : 'today'}>tbody>tr');

    statistics.removeLast();

    final List<List<String>> rawCountries = statistics
        .map((e) => e.children
            .map(
              (e) => (e.text.trim() == '')
                  ? '0'
                  : e.text
                      .trim()
                      .replaceAll(',', '')
                      .replaceAll(' and ', ' & ')
                      .replaceAll('USA', 'United States')
                      .replaceAll('UK', 'United Kingdom')
                      .replaceAll('S. Korea', 'South Korea')
                      .replaceAll('UAE', 'United Arab Emirates')
                      .replaceAll('DRC', 'Dominican Republic')
                      .replaceAll('CAR', 'Central African Republic')
                      .replaceAll('Faeroe Islands', 'Faroe Islands')
                      .replaceAll('Macao', 'Macau'),
            )
            .toList())
        .toList();

    List<Country> countryCodes = await IsoCountries.iso_countries;

    List<CovidCountry> countries = rawCountries.map((e) {
      String countryCode = '';
      for (var country in countryCodes) {
        if (country.name.toLowerCase().contains(e[0].toLowerCase())) {
          countryCode = country.countryCode;
          break;
        } else if (country.name.toLowerCase().contains('macedonia')) {
          countryCode = country.countryCode;
        }
      }
      return CovidCountry(
        name: e[0],
        countryCode: countryCode ?? '',
        totalCases: int.parse(e[1]),
        newCases: int.parse(e[2]),
        totalDeaths: int.parse(e[3]),
        newDeaths: int.parse(e[4]),
        totalRecovered: int.parse(e[5]),
        activeCases: int.parse(e[6]),
        seriousOrCritical: int.parse(e[7]),
        totalCasesDividedByOneMillionPopulation: double.parse(e[8]),
      );
    }).toList();

    return countries;
  }
}
