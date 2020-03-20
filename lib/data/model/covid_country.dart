import 'package:freezed_annotation/freezed_annotation.dart';
part 'covid_country.freezed.dart';

@freezed
abstract class CovidCountry with _$CovidCountry {
  const factory CovidCountry({
    @required final String name,
    @required final String countryCode,
    @required final int totalCases,
    @required final int newCases,
    @required final int totalDeaths,
    @required final int newDeaths,
    @required final int totalRecovered,
    @required final int activeCases,
    @required final int seriousOrCritical,
    @required final double totalCasesDividedByOneMillionPopulation,
  }) = _CovidCountry;
}
