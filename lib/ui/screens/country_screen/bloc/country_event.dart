part of 'country_bloc.dart';

abstract class CountryEvent extends Equatable {
  const CountryEvent();
}

class CountriesFetched extends CountryEvent {
  @override
  List<Object> get props => [];
}

class CountriesUpdated extends CountryEvent {
  final bool isYesterday;

  CountriesUpdated(this.isYesterday);
  @override
  List<Object> get props => [isYesterday];
}

class CountriesSearched extends CountryEvent {
  final String query;

  CountriesSearched({this.query});

  @override
  List<Object> get props => [query];
}
