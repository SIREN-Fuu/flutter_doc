import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/page_a.dart';
import '../pages/page_b.dart';
import '../pages/page_c.dart';
import '../pages/page_start.dart';

final router = GoRouter(
  // アプリが起動したときのページ
  initialLocation: '/',

  // パスと画面の組み合わせ
  routes: [
    // 起動時のスタートページ
    GoRoute(
      path: '/',
      name: 'start',
      builder: (context, state) => const PageStart(),
    ),

    //ページWidget内で「context.push('/a');」とすることでPageA()に遷移
    GoRoute(
      path: '/a',
      name: 'a',
      builder: (context, state) => const PageA(),
    ),
    //ページWidget内で「context.push('/b');」とすることでPageB()に遷移
    //ページWidget内で「context.push('/b', extra: '本日は晴天なり');」
    //とすることでPageB(message)に遷移
    GoRoute(
      path: '/b',
      name: 'b',
      builder: (context, state) {
        // state.extraはnull許容型なので、nullの場合は空文字を返す
        // ?? はnull許容型の値がnullの場合に右辺の値を返す演算子
        final message = (state.extra as String?) ?? '';
        return PageB(message);
      },
    ),
    //ページWidget内で「context.go('/c');」とすることでPageC()に遷移
    //goで遷移した場合は、戻るボタンが表示されず戻ることができない
    //このサンプルの場合は「context.go('/');」としなければ戻ることができない
    GoRoute(
      path: '/c',
      name: 'c',
      builder: (context, state) => const PageC(),
    ),
  ],

  // 画面が見つからないときのページ
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: const PageStart(),
  ),
);
