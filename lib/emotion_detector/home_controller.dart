// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_ml_example/emotion_detector/face_model.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';

// import '../controller/camera_controller.dart';
// import 'face_detention_controller.dart';

// class HomeController extends GetxController {
//   CameraManager? _cameraManager;
//   CameraController? cameraController;
//   FaceDetetorController? _faceDetect;
//   bool _isDetecting = false;
//   List<FaceModel>? faces;

//   String? label = 'Normal';

//   HomeController() {
//     _cameraManager = CameraManager();
//     _faceDetect = FaceDetetorController();
//   }

//   Future<void> loadCamera() async {
//     cameraController = await _cameraManager?.load();
//     update();
//   }

//   Future<void> startImageStream() async {
//     CameraDescription camera = cameraController!.description;

//     cameraController?.startImageStream((cameraImage) async {
//       if (_isDetecting) return;

//       _isDetecting = true;

//       final WriteBuffer allBytes = WriteBuffer();
//       for (Plane plane in cameraImage.planes) {
//         allBytes.putUint8List(plane.bytes);
//       }
//       final bytes = allBytes.done().buffer.asUint8List();

//       final Size imageSize =
//           Size(cameraImage.width.toDouble(), cameraImage.height.toDouble());

//       final InputImageRotation imageRotation =
//           InputImageRotationMethods.fromRawValue(camera.sensorOrientation) ??
//               InputImageRotation.Rotation_0deg;

//       final InputImageFormat inputImageFormat =
//           InputImageFormatMethods.fromRawValue(cameraImage.format.raw) ??
//               InputImageFormat.NV21;

//       final planeData = cameraImage.planes.map(
//         (Plane plane) {
//           return InputImagePlaneMetadata(
//             bytesPerRow: plane.bytesPerRow,
//             height: plane.height,
//             width: plane.width,
//           );
//         },
//       ).toList();

//       final inputImageData = InputImageData(
//         size: imageSize,
//         imageRotation: imageRotation,
//         inputImageFormat: inputImageFormat,
//         planeData: planeData,
//       );

//       final inputImage = InputImage.fromBytes(
//         bytes: bytes,
//         inputImageData: inputImageData,
//       );

//       processImage(inputImage);
//     });
//   }

//   Future<void> processImage(inputImage) async {
//     faces = await _faceDetect?.processImage(inputImage);

//     if (faces != null && faces!.isNotEmpty) {
//       FaceModel? face = faces?.first;
//       label = detectSmile(face?.smile);
//     } else {
//       label = 'Not face detected';
//     }
//     _isDetecting = false;
//     update();
//   }

//   String detectSmile(smileProb) {
//     if (smileProb > 0.75) {
//       return 'Smile 😊';
//     } else {
//       return 'Sad 🙁';
//     }
//   }
// }
