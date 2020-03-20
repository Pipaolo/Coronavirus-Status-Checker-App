import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroBody extends StatelessWidget {
  const IntroBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 100,
        horizontal: 20,
      ),
      child: Container(
        padding: const EdgeInsets.all(18),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue,
        ),
        child: Column(
          children: <Widget>[
            Text(
              'About The App',
              style: GoogleFonts.montserrat(
                fontSize: ScreenUtil().setSp(80),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: SvgPicture.asset(
                'assets/images/icons8-about.svg',
                height: ScreenUtil().setHeight(800),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                'The purpose of this app is to provide people with updated data about the current widespread of Coronavirus to different countries.',
                style: GoogleFonts.montserrat(
                  fontSize: ScreenUtil().setSp(60),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
