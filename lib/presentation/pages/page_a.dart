import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 画面 A
///
/// {@category Pages}
/// {@category Pages_UI}
/// {@subCategory Basics}
class PageA extends StatelessWidget {
  const PageA({super.key});

  @override
  Widget build(BuildContext context) {
    // 画面全体
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'A画面',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 戻るボタン
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text(
                  '<= pop 戻る',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  // 前の画面 へ戻る
                  if (context.canPop()) {
                    context.pop();
                  }
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text(
                  'Push B-Page >',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  // 画面B Push
                  context.push('/b');
                },
              ),

              // 進むボタン
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text(
                  'Go B-Page >',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  // 画面B Go
                  context.go('/b');
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text(
                'Push B-Page with Message(本日は晴天なり) >',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                // 画面B Push
                context.push('/b', extra: '本日は晴天なり');
              },
            ),
          ),
        ],
      ),
    );
  }
}
