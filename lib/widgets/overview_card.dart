import 'package:flutter/material.dart';

class OverviewCard extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const OverviewCard({
    this.flex = 1,
    required this.titleText,
    required this.subText,
    required this.midContent,
    this.buttonText = "Button",
    this.cardBackgroundColor = const Color.fromRGBO(40, 94, 163, 1),
    required this.cardTheme,
    required this.buttonFunction,
  });
  final int flex;
  final String titleText;
  final RichText subText;
  final Widget midContent;
  final String buttonText;
  final Color cardBackgroundColor;
  final Color cardTheme;
  final VoidCallback buttonFunction;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Card(
          color: const Color.fromRGBO(40, 94, 163, 1),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12)),
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: cardTheme, width: 6.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 6.0, left: 24, right: 16, bottom: 4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title Text
                  Row(
                    children: [
                      Text(
                        titleText,
                        style: TextStyle(
                          fontSize: 15,
                          color: cardTheme,
                        ),
                      ),
                    ],
                  ),

                  // Content in the middle of the Card
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: midContent,
                  ),

                  // Button at the bottom of the Card
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      subText,
                      TextButton(
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: cardTheme,
                            textStyle: const TextStyle(fontSize: 10)),
                        //shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(8)),
                        onPressed: buttonFunction,
                        //color: cardTheme,
                        child: Text(buttonText),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}