import 'package:flutter/material.dart';
import 'package:github_search/features/user_search/presentation/pages/user_search_page.dart';

import 'dependency_injection.dart';

void main() {
  init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GithubSearch',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: UserSearchPage(),
    );
  }
}

