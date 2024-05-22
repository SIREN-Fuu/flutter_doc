import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//
// 画面 A
//
class PageStart extends StatelessWidget {
  const PageStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Start 画面'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 進むボタン
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text(
                'Push A-Page >',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                // 画面A Push
                context.push('/a');
              },
            ),
            // Goボタン
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text(
                'Go A-Page >',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                // 画面A Go
                context.go('/a');
              },
            ),
          ],
        ),
      ),
    );
  }
}
