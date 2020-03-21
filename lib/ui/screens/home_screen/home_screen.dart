import 'package:corona_virus/routes/router.gr.dart';
import 'package:corona_virus/ui/screens/widgets/info_dialog_widget.dart';
import 'package:corona_virus/ui/screens/yesterday_screen/bloc/yesterday_country_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants.dart';
import '../../../data/model/covid_country.dart';
import '../country_screen/bloc/country_bloc.dart';
import '../widgets/country_card_widget.dart';
import '../widgets/country_search_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  void choiceAction(String choice, BuildContext context) {
    if (choice == Constants.aboutUs) {
      showDialog(
          context: context,
          builder: (context) {
            return InfoDialogWidget();
          });
    } else if (choice == Constants.seeYesterday) {
      if (context.bloc<CountryBloc>().state is CountrySuccess) {
        Router.navigator.pushNamed(Router.yesterdayScreenRoute);
        BlocProvider.of<YesterdayCountryBloc>(context)
          ..add(CountriesYesterdayFetched());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coronavirus Tracker'),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (string) => choiceAction(string, context),
            itemBuilder: (context) {
              return Constants.choices
                  .map((e) => PopupMenuItem<String>(
                        value: e,
                        child: Text(e),
                      ))
                  .toList();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<CountryBloc>(context)..add(CountriesUpdated(false));
          return null;
        },
        child: BlocBuilder<CountryBloc, CountryState>(
          builder: (context, state) {
            if (state is CountryLoading) {
              return _buildLoadingState();
            } else if (state is CountrySuccess) {
              return _buildSuccessState(state.countries, context);
            } else if (state is CountryError) {
              return _buildErrorState(state.errorText, context);
            } else if (state is CountryInitial) {
              return Container();
            }
            return Container();
          },
        ),
      ),
    );
  }

  _buildLoadingState() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _buildErrorState(String errorText, BuildContext context) {
    if (errorText.contains('SocketException')) {
      return Center(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.error,
                    color: Colors.blue,
                    size: ScreenUtil().setSp(400),
                  ),
                  Text(
                    'Failed to connect to the server, do you have internet connection? Please try again later.',
                    style: GoogleFonts.montserrat(
                      fontSize: ScreenUtil().setSp(50),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height,
              ),
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.error,
                    color: Colors.blue,
                    size: ScreenUtil().setSp(400),
                  ),
                  Text(
                    'Woops, something bad happened. Please try again later.',
                    style: GoogleFonts.montserrat(
                      fontSize: ScreenUtil().setSp(50),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height,
              ),
            ),
          ],
        ),
      );
    }
  }

  _buildSuccessState(List<CovidCountry> countries, BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        CountrySearchBarWidget(
          isYesterday: false,
        ),
        SliverGrid(
          delegate: SliverChildBuilderDelegate((context, index) {
            return CountryCardWidget(
              country: countries[index],
            );
          }, childCount: countries.length),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        )
      ],
    );
  }
}
