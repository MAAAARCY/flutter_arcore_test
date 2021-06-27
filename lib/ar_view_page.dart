import 'dart:async';
import 'dart:typed_data';

import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'episode.dart';

class ARViewPage extends StatefulWidget {
  ARViewPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ARViewPageState createState() => _ARViewPageState();
}


class _ARViewPageState extends State<ARViewPage> {

  ArCoreController arCoreController;
  Map<int, ArCoreAugmentedImage> augmentedImagesMap = Map();
  Uint8List bytedata;
  String path = "images/earth.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
        type: ArCoreViewType.AUGMENTEDIMAGES,
        //enableTapRecognizer: true,
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) async{
    arCoreController = controller;
    arCoreController.onTrackingImage = _handleOnTrackingImage;
    loadImagesDatabase();
  }

  loadSingleImage() async {
    final ByteData bytes =
    await rootBundle.load(path);
    arCoreController.loadSingleAugmentedImage(
        bytes: bytes.buffer.asUint8List());
  }

  loadImagesDatabase() async {
    final ByteData bytes = await rootBundle.load('images/images.imgdb');
    arCoreController.loadAugmentedImagesDatabase(
        bytes: bytes.buffer.asUint8List());
  }

  _handleOnTrackingImage(ArCoreAugmentedImage augmentedImage) {
    if (!augmentedImagesMap.containsKey(augmentedImage.index)) {
      augmentedImagesMap[augmentedImage.index] = augmentedImage;
      //_addSphere(augmentedImage);
      //_addCube(augmentedImage);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => EpisodePage()));
    }
  }

  Future _addSphere(ArCoreAugmentedImage augmentedImage) async {
    final ByteData textureBytes = await rootBundle.load(path);

    final material = ArCoreMaterial(
      color: Color.fromARGB(120, 66, 134, 244),
      textureBytes: textureBytes.buffer.asUint8List(),
    );
    final sphere = ArCoreSphere(
      materials: [material],
      radius: augmentedImage.extentX / 2,
    );
    final node = ArCoreNode(
      shape: sphere,
    );
    arCoreController.addArCoreNodeToAugmentedImage(node, augmentedImage.index);
  }

  Future _addCube(ArCoreAugmentedImage augmentedImage) async {
    final ByteData textureBytes = await rootBundle.load("images/fited.png");

    final material = ArCoreMaterial(
      color: Color.fromARGB(120, 66, 134, 244),
      textureBytes: textureBytes.buffer.asUint8List(),
    );
    final sphere = ArCoreCube(
      materials: [material],
      size: vector.Vector3(augmentedImage.extentX, 0.01, augmentedImage.extentZ),
    );
    final node = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(augmentedImage.centerPose.translation.x, augmentedImage.centerPose.translation.y, augmentedImage.centerPose.translation.z), //augmentedImage.centerPose.translation.z
      //rotation: vector.Vector4(augmentedImage.centerPose.rotation.x, augmentedImage.centerPose.rotation.y, augmentedImage.centerPose.rotation.z, augmentedImage.centerPose.rotation.w),
    );
    arCoreController.addArCoreNodeToAugmentedImage(node, augmentedImage.index);
  }
}