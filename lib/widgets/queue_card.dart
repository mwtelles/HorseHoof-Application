import 'package:flutter/material.dart';
import 'overview_card.dart';

class QueueCard extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const QueueCard({
    required this.cardTheme,
    required this.titleText,
    required this.contentText,
    required this.inQueue,
    required this.buttonText,
    required this.svgPath,
    required this.buttonFunction,
    this.svgSemanticLabel = 'Icon',
  });

  final Color cardTheme;
  final String titleText;
  final String contentText;
  final int inQueue;
  final String buttonText;
  final String svgPath;
  final String svgSemanticLabel;
  final VoidCallback buttonFunction;

  @override
  Widget build(BuildContext context) {
    return OverviewCard(
      flex: 0,
      cardTheme: cardTheme,
      titleText: titleText,
      midContent: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 40,
                width: 40,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contentText,
                  style: const TextStyle(fontSize: 10),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: inQueue.toString(),
                        style: TextStyle(
                          color: cardTheme,
                          fontFamily: 'B612Mono',
                        ),
                      ),
                      const TextSpan(text: ' ocorrência'),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      buttonText: buttonText,
      buttonFunction: buttonFunction, subText: RichText(
      text: const TextSpan(
        text: '',
        style: TextStyle(
            fontSize: 20.0
        ),
        children: <TextSpan>[
          TextSpan(text: 'Total de ocorrências', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    ),
    );
  }
}