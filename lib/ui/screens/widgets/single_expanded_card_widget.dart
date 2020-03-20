import 'package:flutter/material.dart';

class SingleExpandedCardWidget extends StatelessWidget {
  final String title;
  final String content;
  final TextStyle titleTextStyle;
  final TextStyle contentTextStyle;
  final Color color;

  const SingleExpandedCardWidget({
    Key key,
    @required this.title,
    @required this.content,
    @required this.titleTextStyle,
    @required this.contentTextStyle,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        color: (color != null) ? color : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: <Widget>[
              Text(
                content,
                style: contentTextStyle,
              ),
              Text(title, style: titleTextStyle)
            ],
          ),
        ),
      ),
    );
  }
}
