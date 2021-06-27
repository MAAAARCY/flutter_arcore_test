import 'package:flutter/material.dart';

class EpisodePage extends StatefulWidget {

  @override
  _EpisodePageState createState() => _EpisodePageState();
}

class _EpisodePageState extends State<EpisodePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Episode"),
      ),
      body: Center(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("エモい"),
              ElevatedButton(
                child: Text("Back"),
                onPressed: () => Navigator.pop(context),
              ),
            ]
        ),
      ),
    );
  }
}