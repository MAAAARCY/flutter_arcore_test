import 'package:flutter/material.dart';

import 'ar_view_page.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("memory share"),
              ElevatedButton(
                child: Text("Go AR!"),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ARViewPage(title: 'flutter ARCore'))),
              ),
            ]
        ),
      ),
    );
  }
}