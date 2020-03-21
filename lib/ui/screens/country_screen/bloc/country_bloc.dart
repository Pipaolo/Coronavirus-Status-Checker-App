import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:corona_virus/data/model/covid_country.dart';
import 'package:corona_virus/data/repository/country_repository.dart';
import 'package:equatable/equatable.dart';

part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final CountryRepository countryRepository;
  List<CovidCountry> countriesPresent = [];

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
        countriesPresent = await countryRepository.fetchCurrentResult();
        yield CountrySuccess(countries: countriesPresent);
      } catch (e) {
        yield CountryError(errorText: e.toString());
      }
    } else if (event is CountriesUpdated) {
      yield CountryLoading();
      try {
        countriesPresent =
            await countryRepository.updateCountries(event.isYesterday);
        yield CountrySuccess(countries: countriesPresent);
      } catch (e) {
        yield CountryError(errorText: e.toString());
      }
    } else if (event is CountriesSearched) {
      yield CountryLoading();
      try {
        yield CountrySuccess(
          countries: countriesPresent.where(
            (element) => element.name.toLowerCase().startsWith(
                  event.query.toLowerCase(),
                ),
          ),
        );
      } on SocketException catch (e) {
        yield CountryError(errorText: e.toString());
      }
    }
  }
}
