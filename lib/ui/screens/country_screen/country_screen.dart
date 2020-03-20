import 'package:corona_virus/core/colors.dart';
import 'package:corona_virus/data/model/covid_country.dart';
import 'package:corona_virus/ui/screens/widgets/single_expanded_card_widget.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CountryDetailedScreen extends StatelessWidget {
  final CovidCountry country;
  const CountryDetailedScreen({Key key, this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          country.name,
          style: GoogleFonts.montserrat(
            fontSize: ScreenUtil().setSp(70),
          ),
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        actions: <Widget>[
          if (country.countryCode.isNotEmpty)
            Padding(
                padding: const EdgeInsets.all(10),
                child: Flags.getMiniFlag(country.countryCode, 40, 40)),
        ],
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _buildTotalCasesWidget(),
              _buildTotalRecoveredCard(),
              _buildTotalDeathsCard(),
              _buildActiveCasesAndNewCases(),
              _buildSeriousCriticalAndNewDeathsCard(),
            ],
          ),
        ),
      ),
    );
  }

  _buildTotalCasesWidget() {
    return Hero(
      tag: country.name,
      child: SingleExpandedCardWidget(
        title: 'Total Cases',
        titleTextStyle: GoogleFonts.montserrat(
          fontSize: ScreenUtil().setSp(60),
        ),
        content: country.totalCases.toString(),
        contentTextStyle: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          fontSize: ScreenUtil().setSp(120),
        ),
      ),
    );
  }

  _buildActiveCasesAndNewCases() {
    return Container(
      height: ScreenUtil().setHeight(450),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Card(
                color: lightBlue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      country.activeCases.toString(),
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(100),
                      ),
                    ),
                    Text(
                      'Active Cases',
                      style: GoogleFonts.montserrat(
                        fontSize: ScreenUtil().setSp(40),
                      ),
                    ),
                  ],
                )),
          ),
          Expanded(
            child: Card(
                color: lightYellow,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '+ ${country.newCases.toString()}',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(100),
                      ),
                    ),
                    Text(
                      'New Cases',
                      style: GoogleFonts.montserrat(
                        fontSize: ScreenUtil().setSp(40),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  _buildTotalRecoveredCard() {
    return SingleExpandedCardWidget(
        title: 'Total Recovered',
        titleTextStyle: GoogleFonts.montserrat(
          fontSize: ScreenUtil().setSp(40),
        ),
        content: country.totalRecovered.toString(),
        contentTextStyle: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          fontSize: ScreenUtil().setSp(100),
        ),
        color: lightGreen);
  }

  _buildTotalDeathsCard() {
    return SingleExpandedCardWidget(
        title: 'Total Deaths',
        titleTextStyle: GoogleFonts.montserrat(
          fontSize: ScreenUtil().setSp(40),
        ),
        content: country.totalDeaths.toString(),
        contentTextStyle: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          fontSize: ScreenUtil().setSp(100),
        ),
        color: lightRed);
  }

  _buildSeriousCriticalAndNewDeathsCard() {
    return Container(
      height: ScreenUtil().setHeight(450),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Card(
                color: lightBlue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      country.seriousOrCritical.toString(),
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(100),
                      ),
                    ),
                    Text(
                      'Serious and Critical Cases',
                      style: GoogleFonts.montserrat(
                        fontSize: ScreenUtil().setSp(40),
                      ),
                    ),
                  ],
                )),
          ),
          Expanded(
            child: Card(
                color: lightYellow,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '+ ${country.newDeaths.toString()}',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(100),
                      ),
                    ),
                    Text(
                      'New Deaths',
                      style: GoogleFonts.montserrat(
                        fontSize: ScreenUtil().setSp(40),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
