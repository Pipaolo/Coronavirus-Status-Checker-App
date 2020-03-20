import 'package:auto_route/auto_route_annotations.dart';
import 'package:corona_virus/ui/screens/country_screen/country_screen.dart';
import 'package:corona_virus/ui/screens/home_screen/home_screen.dart';
import 'package:corona_virus/ui/screens/intro_screen/intro_screen.dart';
import 'package:corona_virus/ui/screens/splash_screen/splash_screen.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  SplashScreen splashScreenRoute;

  HomeScreen homeScreenRoute;
  IntroScreen introScreenRoute;
  CountryDetailedScreen countryDetailedScreenroute;
}
