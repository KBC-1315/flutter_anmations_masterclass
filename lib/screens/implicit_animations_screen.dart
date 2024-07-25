import 'package:flutter/material.dart';

class ImplicitAnimationsScreen extends StatefulWidget {
  const ImplicitAnimationsScreen({super.key});

  @override
  State<ImplicitAnimationsScreen> createState() =>
      _ImplicitAnimationsScreenState();
}

class _ImplicitAnimationsScreenState extends State<ImplicitAnimationsScreen> {
  bool _visible = true;
  void _trigger() {
    setState(() {
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _visible ? Colors.white : Colors.black,
        appBar: AppBar(
          title: const Text("Implicit Animations"),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(_visible ? 200 : 0)),
                  child: AnimatedAlign(
                    alignment:
                        _visible ? Alignment.topRight : Alignment.topLeft,
                    duration: const Duration(seconds: 1),
                    child: Container(
                      width: 5,
                      height: 400,
                      decoration: BoxDecoration(
                        color: _visible ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: _trigger,
              child: const Text("Go!"),
            ),
          ],
        )));
  }
}
