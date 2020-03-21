import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/model/covid_country.dart';
import '../widgets/country_card_widget.dart';
import '../widgets/country_search_bar_widget.dart';
import 'bloc/yesterday_country_bloc.dart';

class YesterdayScreen extends StatelessWidget {
  const YesterdayScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yesterdays Result'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<YesterdayCountryBloc>(context)
            ..add(CountriesYesterdayFetched());
          return null;
        },
        child: BlocBuilder<YesterdayCountryBloc, YesterdayCountryState>(
          builder: (context, state) {
            if (state is YesterdayCountryLoading) {
              return _buildLoadingState();
            } else if (state is YesterdayCountrySuccess) {
              return _buildSuccessState(state.countries, context);
            } else if (state is YesterdayCountryError) {
              return _buildErrorState(state.errorText, context);
            } else if (state is YesterdayCountryInitial) {
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
        child: Padding(
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
      );
    }
  }

  _buildSuccessState(List<CovidCountry> countries, BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        CountrySearchBarWidget(
          isYesterday: true,
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
