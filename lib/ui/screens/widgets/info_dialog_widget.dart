import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoDialogWidget extends StatelessWidget {
  const InfoDialogWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: ScreenUtil().setHeight(1100),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              height: ScreenUtil().setHeight(800),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Made by: Paolo Matthew G. Tolentino',
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Disclaimer: All the data that is shown here is from Worldometers.com. I don\'t own nor claim the data at hand.',
                  ),
                  const SizedBox(height: 20),
                  Text(
                      'This App is made out of pure Flutter, special thanks to the Flutter Dev team for creating this wonderful framework.')
                ],
              ),
            ),
            Positioned(
              top: 10,
              left: 0,
              right: 0,
              child: CircleAvatar(
                radius: ScreenUtil().setSp(120),
                child: Icon(
                  Icons.info_outline,
                  size: ScreenUtil().setSp(150),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
