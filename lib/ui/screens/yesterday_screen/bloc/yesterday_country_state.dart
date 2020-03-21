part of 'yesterday_country_bloc.dart';

abstract class YesterdayCountryState extends Equatable {
  const YesterdayCountryState();
}

class YesterdayCountryInitial extends YesterdayCountryState {
  @override
  List<Object> get props => [];
}

class YesterdayCountryLoading extends YesterdayCountryState {
  @override
  List<Object> get props => [];
}

class YesterdayCountrySuccess extends YesterdayCountryState {
  final List<CovidCountry> countries;

  YesterdayCountrySuccess({@required this.countries});
  @override
  List<Object> get props => [countries];
}

class YesterdayCountryError extends YesterdayCountryState {
  final String errorText;

  YesterdayCountryError({@required this.errorText});
  @override
  List<Object> get props => [errorText];
}
