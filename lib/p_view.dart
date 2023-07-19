import 'dart:async';
import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:project/main.dart';

class Data {
  final String title;
  final String description;
  final String imgURL;
  final IconData iconData;

  Data({
    required this.title,
    required this.description,
    required this.imgURL,
    required this.iconData,
  });
}

class PView extends StatefulWidget {
  const PView({Key? key}) : super(key: key);

  @override
  State<PView> createState() => _PViewState();
}

class _PViewState extends State<PView> {
  @override
  void initState() {
    // TODO: implement initState
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentIndex < 3) _currentIndex++;
      _controller.animateToPage(
        _currentIndex,
        duration: const Duration(seconds: 2),
        curve: Curves.easeIn,
      );
    });
  }

  final PageController _controller = PageController(
    initialPage: 0,
  );

  final pageIndexNotifier = ValueNotifier<int>(0);

  List<Data> MyData = [
    Data(
      title: "title 1",
      description: "Lets Do It My Friend",
      imgURL: 'assets/q1.jpg',
      iconData: Icons.download,
    ),
    Data(
      title: "title 2",
      description: "Lets Do It My hommy",
      imgURL: 'assets/q2.jpg',
      iconData: Icons.abc_outlined,
    ),
    Data(
      title: "title 3",
      description: "Lets Do It My bro",
      imgURL: 'assets/q3.jpg',
      iconData: Icons.access_alarms,
    ),
    Data(
      title: "title 4",
      description: "Lets Do It My hee",
      imgURL: 'assets/q4.jpg',
      iconData: Icons.accessibility_new_sharp,
    ),
  ];
  int _currentIndex = 0;

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/a': (ctx) => MyHomePage(),
        // '/s' : (ctx)=> MyHomePage(),
      },
      home: Scaffold(
        body: Stack(children: [
          Builder(
            builder: (ctx) => PageView(
              controller: _controller,
              onPageChanged: (val) {
                setState(() {
                  _currentIndex = val;
                  if (_currentIndex == 3) {
                    Future.delayed(Duration(seconds: 3),
                        () => Navigator.of(ctx).pushNamed('/a'));
                  }
                });
              },
              children: MyData.map((item) => Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: ExactAssetImage('assets/q1.jpg'),
                          fit: BoxFit.cover),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item.iconData,
                          size: 130,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          item.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          item.description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
            ),
          ),
          Indicator(_currentIndex),
          Builder(
            builder: (ctx) => Align(
              alignment: Alignment(0, 0.93),
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.of(ctx).pushReplacementNamed('/a');
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool('x', true);
                    },
                    child: const Text("Get Started"),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final int index;

  Indicator(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 0.6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildContainer(0, Colors.black),
          buildContainer(1, Colors.black),
          buildContainer(2, Colors.black),
          buildContainer(3, Colors.black),
        ],
      ),
    );
  }

  Widget buildContainer(int i, Color color) {
    return index != i
        ? Container(
            margin: EdgeInsets.all(4),
            height: 15,
            width: 15,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ))
        : Icon(Icons.star);
  }
}
