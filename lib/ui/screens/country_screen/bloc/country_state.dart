part of 'country_bloc.dart';

abstract class CountryState extends Equatable {
  const CountryState();
}

class CountryInitial extends CountryState {
  @override
  List<Object> get props => [];
}

class CountryLoading extends CountryState {
  @override
  List<Object> get props => [];
}

class CountryError extends CountryState {
  final String errorText;

  CountryError({this.errorText});
  @override
  List<Object> get props => [errorText];
}

class CountrySuccess extends CountryState {
  final List<CovidCountry> countries;

  CountrySuccess({this.countries});

  @override
  List<Object> get props => [countries];
}
