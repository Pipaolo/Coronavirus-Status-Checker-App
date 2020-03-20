import 'package:corona_virus/data/model/covid_country.dart';
import 'package:corona_virus/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CountryCardWidget extends StatelessWidget {
  final CovidCountry country;
  const CountryCardWidget({Key key, this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: country.name,
      flightShuttleBuilder: (
        BuildContext flightContext,
        Animation<double> animation,
        HeroFlightDirection flightDirection,
        BuildContext fromHeroContext,
        BuildContext toHeroContext,
      ) {
        return SingleChildScrollView(
          child: fromHeroContext.widget,
        );
      },
      child: Card(
        child: InkWell(
          onTap: () => _goToCountryDetailPage(context),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Text(
                      country.name,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(40),
                      ),
                    ),
                    Divider(
                      endIndent: 40,
                      indent: 40,
                      thickness: 2,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      country.totalCases.toString(),
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(80),
                      ),
                    ),
                    Text(
                      'Cases',
                      style: GoogleFonts.montserrat(
                        fontSize: ScreenUtil().setSp(40),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _goToCountryDetailPage(BuildContext context) {
    FocusScope.of(context).unfocus();
    Router.navigator.pushNamed(Router.countryDetailedScreenroute,
        arguments: CountryDetailedScreenArguments(
          country: this.country,
        ));
  }
}
