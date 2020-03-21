import 'package:corona_virus/data/repository/country_repository.dart';
import 'package:corona_virus/routes/router.gr.dart';
import 'package:corona_virus/ui/screens/splash_screen/bloc/intro_bloc.dart';
import 'package:corona_virus/ui/screens/yesterday_screen/bloc/yesterday_country_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/country_screen/bloc/country_bloc.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<CountryRepository>(
      create: (context) => CountryRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CountryBloc>(
            create: (context) => CountryBloc(
              RepositoryProvider.of<CountryRepository>(context),
            )..add(CountriesFetched()),
          ),
          BlocProvider<IntroBloc>(
            create: (context) => IntroBloc()..add(IntroAppStarted()),
          ),
          BlocProvider<YesterdayCountryBloc>(
            create: (context) => YesterdayCountryBloc(
              countryBloc: BlocProvider.of<CountryBloc>(context),
              countryRepository:
                  RepositoryProvider.of<CountryRepository>(context),
            ),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Router.onGenerateRoute,
          navigatorKey: Router.navigator.key,
          initialRoute: Router.splashScreenRoute,
        ),
      ),
    );
  }
}
