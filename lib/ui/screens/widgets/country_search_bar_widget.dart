import 'package:corona_virus/ui/screens/country_screen/bloc/country_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CountrySearchBarWidget extends StatefulWidget {
  CountrySearchBarWidget({Key key}) : super(key: key);

  @override
  _CountrySearchBarWidgetState createState() => _CountrySearchBarWidgetState();
}

class _CountrySearchBarWidgetState extends State<CountrySearchBarWidget> {
  final TextEditingController _searchbarController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              suffixIcon: (_searchbarController.text.isNotEmpty)
                  ? IconButton(
                      icon: Icon(
                        FontAwesomeIcons.timesCircle,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          _searchbarController.text = '';
                          BlocProvider.of<CountryBloc>(context)
                            ..add(CountriesFetched());
                        });
                      },
                    )
                  : null,
              hintText: 'Search Countries',
            ),
            controller: _searchbarController,
            onChanged: _onChanged,
          ),
        ),
      ]),
    );
  }

  void _onChanged(String string) {
    if (string.isNotEmpty) {
      BlocProvider.of<CountryBloc>(context)
        ..add(CountriesSearched(query: string));
    } else {
      BlocProvider.of<CountryBloc>(context)..add(CountriesFetched());
    }
  }
}
