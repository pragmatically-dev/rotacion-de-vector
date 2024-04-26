// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

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
  const ScreenSwitcher(
      {super.key, required this.mobile, required this.desktop});
  final Widget mobile, desktop;
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

class DesktopView extends StatefulWidget {
  const DesktopView({
    super.key,
  });

  @override
  State<DesktopView> createState() => _DesktopViewState();
}

class _DesktopViewState extends State<DesktopView> {
  double k = 0;
  var v = VectorR2(x1: 4.0, x2: 2.0);

  @override
  Widget build(BuildContext context) {
    double anguloDeRotacion = pi * 2 * k;
    var vectorRotado = VectorR2.rotar(anguloDeRotacion, v);
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Column(
              children: [
                Center(
                  child: Text("Mueva el valor de K"),
                ),
                SizedBox(
                  height: 20,
                ),
                Slider(
                    value: k,
                    onChanged: (value) => {setState(() => k = value)}),
              ],
            )),
        Expanded(
          flex: 4,
          child: ClipRect(
            child: Stack(
              clipBehavior: Clip.antiAlias,
              children: [
                Center(
                  child: CustomPaint(
                    isComplex: true,
                    painter: VectorPainter(
                        v: vectorRotado,
                        centro: VectorR2(x1: 0, x2: 0),
                        escala:
                            50 // com si dividieras la pantalla en grids 30x30
                        ),
                  ),
                ),
                Positioned(
                  child: Column(
                    children: [
                      Text("Angulo: 2K・𝝿"),
                      Text("Valor de K: ${(k * 10).ceil()}"),
                      Text("Valor del vector: ${vectorRotado.toString()}"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class VectorR2 {
  double x1, x2;
  VectorR2({required this.x1, required this.x2});

  static productoEscalar(VectorR2 v, VectorR2 w) {
    return (v.x1 * w.x1) + (v.x2 * w.x2);
  }

  @override
  String toString() {
    return "(${x1.ceilToDouble()},${x2.ceilToDouble()})";
  }

  static VectorR2 rotar(double alpha, VectorR2 v) {
    Matriz2x2 matrizRotacion = Matriz2x2(
      F1: VectorR2(
        x1: cos(alpha),
        x2: -sin(alpha),
      ),
      F2: VectorR2(
        x1: sin(alpha),
        x2: cos(alpha),
      ),
    );

    return VectorR2(
      x1: productoEscalar(
        matrizRotacion.fila(0),
        v,
      ),
      x2: productoEscalar(
        matrizRotacion.fila(1),
        v,
      ),
    );
  }
}

class Matriz2x2 {
  List<VectorR2>? matriz;
  VectorR2 F1, F2;

  Matriz2x2({required this.F1, required this.F2}) {
    matriz = [F1, F2];
  }
  VectorR2 fila(int i) => matriz?[i] ?? VectorR2(x1: -1, x2: -1);
}

class MobileView extends StatefulWidget {
  const MobileView({
    super.key,
  });

  @override
  State<MobileView> createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
  double k = 0;

  @override
  Widget build(BuildContext context) {
    double anguloDeRotacion = pi * 2 * k;
    var v = VectorR2(x1: 4.0, x2: 2.0);
    var vectorRotado = VectorR2.rotar(anguloDeRotacion, v);
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: ClipRect(
            child: Stack(
              clipBehavior: Clip.antiAlias,
              children: [
                Center(
                  child: CustomPaint(
                    isComplex: true,
                    painter: VectorPainter(
                        v: vectorRotado,
                        centro: VectorR2(x1: 0, x2: 0),
                        escala:
                            50 // com si dividieras la pantalla en grids 30x30
                        ),
                  ),
                ),
                Positioned(
                  child: Column(
                    children: [
                      Text("Angulo: 2K・𝝿"),
                      Text("Valor de K: ${(k * 10).ceil()}"),
                      Text("Valor del vector: ${vectorRotado.toString()}"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              Center(
                child: Text("Mueva el valor de K"),
              ),
              SizedBox(
                height: 20,
              ),
              Slider(
                  value: k, onChanged: (value) => {setState(() => k = value)}),
            ],
          ),
        ),
      ],
    );
  }
}

class VectorPainter extends CustomPainter {
  VectorPainter({required this.v, required this.centro, required this.escala});
  VectorR2 v;
  VectorR2 centro;
  int escala;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2;

    // Origen del vector
    final Offset start = Offset(centro.x1, centro.x2);

    // Destino del vector
    final Offset end = Offset(v.x1 * escala, -v.x2 * escala);

    // Dibujar el vector
    canvas.drawLine(start, end, paint);

    canvas.drawLine(
        Offset(-10.0 * escala, 0),
        Offset(10.0 * escala, 0),
        paint
          ..color = Colors.black
          ..strokeWidth = 0.9);
    canvas.drawLine(
        Offset(0, -10.0 * escala),
        Offset(0, 4.0 * escala),
        paint
          ..color = Colors.black
          ..strokeWidth = 0.5);

    var fix = 1.111;
    for (var i = -10; i <= 10; i++) {
      canvas.drawLine(
          Offset(i.toDouble() * (escala * fix), (-1.0 * 9)),
          Offset((i.toDouble()) * (escala * fix), (1.0 * 9)),
          paint
            ..color = Colors.black
            ..strokeWidth = 0.9);
      canvas.drawLine(
          Offset((-1.0 * 9), (i).toDouble() * (escala * fix)),
          Offset((1.0 * 9), i.toDouble() * (escala * fix)),
          paint
            ..color = Colors.black
            ..strokeWidth = 0.9);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
