import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ignore: must_be_immutable
class NetworkError extends StatelessWidget {
  // final navigationService = locator<NavigationService>();
  String? icon;
  String? content;
  String? subContant;

  NetworkError({
    Key? key,
    this.icon,
    this.content,
    this.subContant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Spacer(
              flex: 1,
            ),
            Image.asset(icon!),
            const Spacer(
              flex: 1,
            ),
            Text(
              content!,
              style: TextStyle(
                  color: const Color(0xff1B1D1E),
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Raleway',
                  letterSpacing: -0.33,
                  fontSize: 15),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              subContant!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: const Color(0xff36393C),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Raleway',
                  letterSpacing: -0.33,
                  fontSize: 15),
            ),
            const Spacer(
              flex: 2,
            )
          ]),
    );
  }
}
