import 'package:flutter/material.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> alignTween;
  late Animation sizeTween;
  late Animation circularTween;
  bool toggle = false;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    circularTween =
        Tween<double>(begin: 45, end: 0).animate(animationController);
    sizeTween = Tween<double>(begin: 60, end: 100).animate(animationController);
    alignTween = Tween<double>(begin: 0, end: 1).animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Animação"),
        ),
        body: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return Container(
                  padding: const EdgeInsets.all(12),
                  color: Colors.red,
                  width: double.infinity,
                  height: double.infinity,
                  child: Align(
                    alignment: Alignment(
                        1.0 - alignTween.value, 1.0 - (alignTween.value * 2)),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          toggle = !toggle;
                          if (toggle) animationController.forward();
                          if (!toggle) animationController.reverse();
                        });
                      },
                      child: Container(
                        height: 60,
                        width: sizeTween.value,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.all(
                              Radius.circular(circularTween.value)),
                        ),
                      ),
                    ),
                  ));
            }));
  }
}
