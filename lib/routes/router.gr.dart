// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:corona_virus/ui/screens/splash_screen/splash_screen.dart';
import 'package:corona_virus/ui/screens/home_screen/home_screen.dart';
import 'package:corona_virus/ui/screens/intro_screen/intro_screen.dart';
import 'package:corona_virus/ui/screens/country_screen/country_screen.dart';
import 'package:corona_virus/data/model/covid_country.dart';

class Router {
  static const splashScreenRoute = '/';
  static const homeScreenRoute = '/home-screen-route';
  static const introScreenRoute = '/intro-screen-route';
  static const countryDetailedScreenroute = '/country-detailed-screenroute';
  static final navigator = ExtendedNavigator();
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.splashScreenRoute:
        if (hasInvalidArgs<Key>(args)) {
          return misTypedArgsRoute<Key>(args);
        }
        final typedArgs = args as Key;
        return MaterialPageRoute<dynamic>(
          builder: (_) => SplashScreen(key: typedArgs),
          settings: settings,
        );
      case Router.homeScreenRoute:
        if (hasInvalidArgs<Key>(args)) {
          return misTypedArgsRoute<Key>(args);
        }
        final typedArgs = args as Key;
        return MaterialPageRoute<dynamic>(
          builder: (_) => HomeScreen(key: typedArgs),
          settings: settings,
        );
      case Router.introScreenRoute:
        if (hasInvalidArgs<Key>(args)) {
          return misTypedArgsRoute<Key>(args);
        }
        final typedArgs = args as Key;
        return MaterialPageRoute<dynamic>(
          builder: (_) => IntroScreen(key: typedArgs),
          settings: settings,
        );
      case Router.countryDetailedScreenroute:
        if (hasInvalidArgs<CountryDetailedScreenArguments>(args)) {
          return misTypedArgsRoute<CountryDetailedScreenArguments>(args);
        }
        final typedArgs = args as CountryDetailedScreenArguments ??
            CountryDetailedScreenArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => CountryDetailedScreen(
              key: typedArgs.key, country: typedArgs.country),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//CountryDetailedScreen arguments holder class
class CountryDetailedScreenArguments {
  final Key key;
  final CovidCountry country;
  CountryDetailedScreenArguments({this.key, this.country});
}
