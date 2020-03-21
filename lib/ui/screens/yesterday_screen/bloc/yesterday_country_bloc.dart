import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:corona_virus/data/model/covid_country.dart';
import 'package:corona_virus/data/repository/country_repository.dart';
import 'package:corona_virus/ui/screens/country_screen/bloc/country_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'yesterday_country_event.dart';
part 'yesterday_country_state.dart';

class YesterdayCountryBloc
    extends Bloc<YesterdayCountryEvent, YesterdayCountryState> {
  final CountryRepository countryRepository;
  final CountryBloc countryBloc;
  StreamSubscription subscription;
  List<CovidCountry> countriesYesterday = [];

  YesterdayCountryBloc({this.countryRepository, this.countryBloc}) {
    subscription = countryBloc.listen((state) {
      if (state is CountrySuccess) {
        add(CountriesYesterdayFetched());
      }
    });
  }

  @override
  YesterdayCountryState get initialState => YesterdayCountryInitial();

  @override
  Stream<YesterdayCountryState> mapEventToState(
    YesterdayCountryEvent event,
  ) async* {
    if (event is CountriesYesterdayFetched) {
      yield YesterdayCountryLoading();
      try {
        if (countriesYesterday.isEmpty) {
          countriesYesterday = await countryRepository.fetchYesterdaysResult();
        }
        yield YesterdayCountrySuccess(countries: countriesYesterday);
      } catch (e) {
        yield YesterdayCountryError(errorText: e.toString());
      }
    } else if (event is CountriesYesterdaySearched) {
      yield YesterdayCountryLoading();
      try {
        yield YesterdayCountrySuccess(
          countries: countriesYesterday
              .where(
                (element) => element.name.toLowerCase().startsWith(
                      event.query.toLowerCase(),
                    ),
              )
              .toList(),
        );
      } catch (e) {
        yield YesterdayCountryError(errorText: e.toString());
      }
    }
  }

  @override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }
}
