part of 'country_bloc.dart';

abstract class CountryEvent extends Equatable {
  const CountryEvent();
}

class CountriesFetched extends CountryEvent {
  @override
  List<Object> get props => [];
}

class CountriesUpdated extends CountryEvent {
  @override
  List<Object> get props => [];
}

class CountriesSearched extends CountryEvent {
  final String query;

  CountriesSearched({this.query});

  @override
  List<Object> get props => [query];
}
