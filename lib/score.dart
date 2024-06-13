import 'styled_button.dart';
import 'package:flutter/material.dart';
import 'text_styles.dart';
import 'about.dart';

class Score extends StatelessWidget {
  const Score(
      {super.key,
      required this.totalScore,
      required this.round,
      required this.onStartOver});

  final int totalScore;
  final int round;
  final VoidCallback onStartOver;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StyledButton(
          icon: Icons.refresh,
          onPressed: () {
            onStartOver();
          },
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 32, right: 32),
            child: Column(
              children: [
                Text(
                  'Score: ',
                  style: LabelTextStyle.bodyMedium(context),
                ),
                Text(
                  '$totalScore',
                  style: ScoreNumberTextStyle.headlineMedium(context),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: Column(
            children: [
              Text(
                'Round: ',
                style: LabelTextStyle.bodyMedium(context),
              ),
              Text(
                '$round',
                style: ScoreNumberTextStyle.headlineMedium(context),
              ),
            ],
          ),
        ),
        StyledButton(
          icon: Icons.info,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AboutPage(),
              ),
            );
          },
        )
      ],
    );
  }
}
