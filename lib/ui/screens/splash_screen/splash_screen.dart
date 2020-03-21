import 'package:corona_virus/data/repository/country_repository.dart';
import 'package:corona_virus/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bloc/intro_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final CountryRepository repository = CountryRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return BlocListener<IntroBloc, IntroState>(
      listener: (context, state) {
        if (state is IntroNotOpenedOnce) {
          Future.delayed(
            Duration(seconds: 1),
            () =>
                Router.navigator.pushReplacementNamed(Router.introScreenRoute),
          );
        } else if (state is IntroOpenedOnce) {
          Future.delayed(
            Duration(seconds: 1),
            () => Router.navigator.pushReplacementNamed(Router.homeScreenRoute),
          );
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 100),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(8, 10),
                  ),
                ]),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  'assets/images/experiment-results.svg',
                  width: ScreenUtil().setWidth(600),
                  height: ScreenUtil().setHeight(600),
                  color: Colors.white,
                ),
                const SizedBox(height: 50),
                Text(
                  'Coronavirus Tracker',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(70),
                  ),
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}
