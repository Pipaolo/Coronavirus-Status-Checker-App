import 'package:corona_virus/routes/router.gr.dart';
import 'package:corona_virus/ui/screens/splash_screen/bloc/intro_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/intro_body.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            IntroBody(),
            Positioned(
              bottom: 0,
              right: 0,
              child: FlatButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Next',
                      style: TextStyle(fontSize: ScreenUtil().setSp(50)),
                    ),
                    Icon(
                      Icons.chevron_right,
                      textDirection: TextDirection.ltr,
                    ),
                  ],
                ),
                onPressed: () {
                  BlocProvider.of<IntroBloc>(context)
                    ..add(
                      IntroStored(isOpenedOnce: true),
                    );
                  Router.navigator.pushReplacementNamed(Router.homeScreenRoute);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
