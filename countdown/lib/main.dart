import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('倒计时'),),
        body: MyHomePage(),
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Duration time;
  var seconds = 0;
  Timer countdownTimer;
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Center(
        child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('定时'),
            onPressed: () {
              showCupertinoModalPopup<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                      height: 200,
                      color: CupertinoColors.white,
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          color: CupertinoColors.black,
                          fontSize: 22.0,
                        ),
                        child: CupertinoTimerPicker(
                          //initialTimerDuration: time,
                          //minuteInterval: 5,
                          mode: CupertinoTimerPickerMode.ms,
                          onTimerDurationChanged: (Duration newTimer) {
                            setState(() {
                              time = newTimer;
                              seconds = time.inSeconds;
                              // flag = true;
                            });
                          },
                        ),
                      ));
                },
              );
            },
          ),
          RaisedButton(
            child: Text('开始倒计时'),
            onPressed: () {
              if (countdownTimer != null) {
                return;
              }
              countdownTimer =
                  new Timer.periodic(new Duration(seconds: 1), (timer) {
                setState(() {
                  if (seconds > 0) {
                    seconds--;
                  } else {
                    countdownTimer.cancel();
                    countdownTimer = null;
                  }
                });
              });
            },
          ),
          Text(
            '倒计时： $seconds' + '秒',
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
      ) 
      
    );
  }
}
