import 'package:board_bar/model/Player.dart';
import 'package:board_bar/widget/BasicCounterCard.dart';
import 'package:board_bar/widget/TimerWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicCounter extends StatefulWidget {
  @override
  _BasicCounterState createState() => _BasicCounterState();
}

class _BasicCounterState extends State<BasicCounter> {
  List<Player> _playerList = [];
  int _counter = 0;

  @override
  void initState() {
    // TODO: implement initState
    _playerList.add(Player(name: "Player 1", score: 0));
    _playerList.add(Player(name: "Player 2", score: 0));
    super.initState();
  }

  void _incrementCounter(Player player) {
    setState(() {
      player.score++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff9e0b2),
      appBar: AppBar(
        title: Text('Basic Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TimerWidget(),

            BasicCounterCard(playerName: "April", score: 99),
            BasicCounterCard(playerName: "Lucy", score: 99),
            BasicCounterCard(playerName: "Bruce", score: 99),
            BasicCounterCard(playerName: "Urine", score: 99)
          ],
        ),
      ),
    );
  }
}
