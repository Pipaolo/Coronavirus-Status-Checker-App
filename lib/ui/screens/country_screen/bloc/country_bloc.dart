import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:corona_virus/data/model/covid_country.dart';
import 'package:corona_virus/data/repository/repository.dart';
import 'package:equatable/equatable.dart';

part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final CountryRepository countryRepository;

  CountryBloc(this.countryRepository);
  @override
  CountryState get initialState => CountryInitial();

  @override
  Stream<CountryState> mapEventToState(
    CountryEvent event,
  ) async* {
    if (event is CountriesFetched) {
      yield CountryLoading();
      try {
        final countries = await countryRepository.fetchCountries();
        yield CountrySuccess(countries: countries);
      } catch (e) {
        yield CountryError(errorText: e.toString());
      }
    } else if (event is CountriesUpdated) {
      yield CountryLoading();
      try {
        final countries = await countryRepository.updateCountries();
        yield CountrySuccess(countries: countries);
      } catch (e) {
        yield CountryError(errorText: e.toString());
      }
    } else if (event is CountriesSearched) {
      yield CountryLoading();
      try {
        final countries = await countryRepository.searchCountries(event.query);
        yield CountrySuccess(countries: countries);
      } catch (e) {
        yield CountryError(errorText: e.toString());
      }
    }
  }
}
