import 'package:flutter/material.dart';

class ErrorBoxWidget extends StatefulWidget {
  final String? title;
  final String? img;
  const ErrorBoxWidget({Key? key, this.title, this.img}) : super(key: key);

  @override
  State<ErrorBoxWidget> createState() => _ErrorBoxWidgetState();
}

class _ErrorBoxWidgetState extends State<ErrorBoxWidget> {
  // final navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            child: ClipRect(
              child: Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      widget.img == null
                          ? Image.asset(
                              'assets/icon/alert.png',
                              fit: BoxFit.fill,
                            )
                          : Image.asset(
                              widget.img.toString(),
                              fit: BoxFit.fill,
                            ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "ERROR",
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.44,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(widget.title ?? "Oops Something Went Wrong",
                          style: TextStyle(
                            color: const Color(0xff2A2A2A),
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          )),
                      SizedBox(
                        height: 12,
                      ),
                      const Divider(
                        color: Color(0xff2A2A2A),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        child: Text(
                          "OK",
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.10,
                              color: const Color(0xFFD60505)),
                        ),
                        onTap: () {
                          //navigationService.back();
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  )),
            ),
            onTap: () {
              //navigationService.back();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
