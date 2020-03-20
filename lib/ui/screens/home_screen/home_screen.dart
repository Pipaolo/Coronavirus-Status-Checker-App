import 'package:corona_virus/ui/screens/widgets/info_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/covid_country.dart';
import '../country_screen/bloc/country_bloc.dart';
import '../widgets/country_card_widget.dart';
import '../widgets/country_search_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coronavirus Tracker'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return InfoDialogWidget();
                  });
            },
          ),
        ],
      ),
      body: BlocBuilder<CountryBloc, CountryState>(
        builder: (context, state) {
          if (state is CountryLoading) {
            return _buildLoadingState();
          } else if (state is CountrySuccess) {
            return _buildSuccessState(state.countries, context);
          } else if (state is CountryError) {
            return _buildErrorState(state.errorText);
          } else if (state is CountryInitial) {
            return Container();
          }
          return Container();
        },
      ),
    );
  }

  _buildLoadingState() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _buildErrorState(String errorText) {
    print(errorText);
    return Center(
      child: Text('Oops Something Went Wrong. '),
    );
  }

  _buildSuccessState(List<CovidCountry> countries, BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<CountryBloc>(context)..add(CountriesUpdated());
          return null;
        },
        child: CustomScrollView(
          slivers: <Widget>[
            CountrySearchBarWidget(),
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
        ));
  }
}
