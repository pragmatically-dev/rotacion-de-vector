// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScreenType {
  static const double desktop = 1054;
  static const double mobile = 700;

  const ScreenType();
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Concepto de Rotacion de vector'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).colorScheme.inversePrimary.withBlue(100),
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          ScreenSwitcher(
            mobile: MobileView(),
            desktop: DesktopView(),
          ),
        ],
      ),
    );
  }
}

class ScreenSwitcher extends StatelessWidget {
  const ScreenSwitcher({
    super.key,
    required  this.mobile,
    required  this.desktop
  });
   final Widget mobile,desktop;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, dimensions) {
      return SizedBox(
        child: AnimatedSwitcher(
          duration: Durations.medium2,
          reverseDuration: Durations.long3,
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.bounceInOut,
          child: switch (dimensions.maxWidth) {
            <= ScreenType.mobile => mobile,
            _ => desktop,
          },
        ),
      );
    });
  }
}

class DesktopView extends StatelessWidget {
  const DesktopView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Placeholder(),
        ),
        Expanded(
          flex: 4,
          child: Placeholder(),
        ),
      ],
    );
  }
}

class MobileView extends StatelessWidget {
  const MobileView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Placeholder(),
        ),
        Expanded(
          flex: 3,
          child: Placeholder(),
        ),
      ],
    );
  }
}
