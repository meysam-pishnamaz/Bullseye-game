import 'package:bullseye/hit_me_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'prompt.dart';
import 'control.dart';
import 'score.dart';
import 'game_model.dart';
import 'dart:math';
import 'styled_button.dart';

void main() {
  runApp(const BullsEyeApp());
}

class BullsEyeApp extends StatelessWidget {
  const BullsEyeApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    return const MaterialApp(
      title: 'Bullseye',
      home: GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late GameModel _model;

  @override
  void initState() {
    super.initState();
    _model = GameModel(_newTargetValue());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 48, bottom: 32),
                child: Prompt(targetValue: _model.target),
              ),
              Control(model: _model),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: HitMeButton(
                  text: 'HIT ME',
                  onPressed: () {
                    _showAlert(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Score(
                  totalScore: _model.totalScore,
                  round: _model.round,
                  onStartOver: () => _startNewGame(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _pointsForCurrentRound() {
    var bonus = 0;
    const maximumScore = 100;
    var difference = _differenceAmount();
    if (difference == 0) {
      bonus = 100;
    } else if (difference == 1) {
      bonus = 50;
    }
    return maximumScore - difference + bonus;
  }

  String _alertTitle() {
    var difference = _differenceAmount();
    String title;
    if (difference == 0) {
      title = 'perfect!';
    } else if (difference < 5) {
      title = 'You almost had it!';
    } else if (difference <= 10) {
      title = 'Not bad.';
    } else {
      title = 'Are you even trying?';
    }
    return title;
  }

  int _differenceAmount() => (_model.target - _model.current).abs();

  int _newTargetValue() => (Random().nextInt(100) + 1);

  void _startNewGame() {
    setState(() {
      _model.totalScore = GameModel.scoreStart;
      _model.round = GameModel.roundStart;
      _model.current = GameModel.sliderStart;
      _model.target = _newTargetValue();
    });
  }

  void _showAlert(BuildContext context) {
    var okButton = StyledButton(
      icon: Icons.close,
      onPressed: () {
        Navigator.of(context).pop();
        setState(() {
          _model.totalScore += _pointsForCurrentRound();
          _model.target = _newTargetValue();
          _model.round++;
        });
      },
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_alertTitle()),
          content: Text('The Slider value is ${_model.current}.\n'
              'you scored ${_pointsForCurrentRound()} points this round. '),
          actions: [
            okButton,
          ],
          elevation: 5,
        );
      },
    );
  }
}
