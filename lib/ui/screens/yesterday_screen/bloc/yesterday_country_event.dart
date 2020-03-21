part of 'yesterday_country_bloc.dart';

abstract class YesterdayCountryEvent extends Equatable {
  const YesterdayCountryEvent();
}

class CountriesYesterdayFetched extends YesterdayCountryEvent {
  @override
  List<Object> get props => [];
}

class CountriesYesterdaySearched extends YesterdayCountryEvent {
  final String query;

  CountriesYesterdaySearched({this.query});

  @override
  List<Object> get props => [query];
}
