import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 画面 B
///
/// {@category Pages}
/// {@category Pages_UI}
/// {@subCategory Basics}
class PageB extends StatelessWidget {
  const PageB(this.message, {super.key});
  final String message;

  @override
  Widget build(BuildContext context) {
    // 画面全体
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'B画面',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 戻るボタン
                  createButton(
                    text: '<= pop 戻る',
                    color: Colors.red,
                    onPressed: () {
                      // 前の画面 へ戻る
                      if (context.canPop()) {
                        context.pop();
                      }
                    },
                  ),
                  // C画面 Go
                  createButton(
                    text: 'Push C-Page >',
                    color: Colors.green,
                    onPressed: () {
                      // 画面C Go
                      context.push('/c');
                    },
                  ),
                  // Start画面 Go
                  createButton(
                    text: 'Go Start-Page >',
                    color: Colors.blue,
                    onPressed: () {
                      // 画面A Go
                      context.go('/');
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: message.isNotEmpty
                    ? Text(
                        'ページ遷移で渡されたデータは "$message" です',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const Text(
                        'ページ遷移で渡されたデータはありません',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget createButton({
    required String text,
    required Color color,
    required void Function() onPressed,
  }) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: color),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
