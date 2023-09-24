// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import 'package:google_ml_example/controller/home_controller.dart';
// import 'package:google_ml_example/utils/constants.dart';
// import 'package:google_ml_example/view/search_view.dart';
// import 'package:google_ml_example/widget/widget.dart';

// class EmotionDetectorScreen extends StatefulWidget {
//   const EmotionDetectorScreen({Key? key}) : super(key: key);

//   @override
//   _EmotionDetectorScreenState createState() => _EmotionDetectorScreenState();
// }

// class _EmotionDetectorScreenState extends State<EmotionDetectorScreen> {
//   final _homeController = HomeController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: brandName("Emotion", "Detector"),
//         elevation: 0.0,
//         backgroundColor: Colors.white,
//       ),
//       body: GetBuilder<HomeController>(
//         init: _homeController,
//         initState: (_) async {
//           await _homeController.loadCamera();
//           _homeController.startImageStream();
//         },
//         builder: (_) {
//           return Container(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   _.cameraController != null &&
//                           _.cameraController!.value.isInitialized
//                       ? Container(
//                           alignment: Alignment.center,
//                           width: MediaQuery.of(context).size.width,
//                           height: MediaQuery.of(context).size.height * 0.5,
//                           child: CameraPreview(_.cameraController!))
//                       : Center(
//                           child: SpinKitFadingCircle(
//                           color: Color.fromARGB(255, 199, 23, 11),
//                           size: 50.0,
//                         )),
//                   SizedBox(height: 15),
//                   // Text(
//                   //   '${_.label}',
//                   //   style: TextStyle(
//                   //     fontSize: 20,
//                   //   ),
//                   // ),
//                   SizedBox(height: 10),
//                   (_.label == "Not face detected")
//                       ? Text(
//                           "${_.label}",
//                           style: TextStyle(fontSize: 18),
//                         )
//                       : SizedBox(
//                           width: kWidth(context) / 3,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           SearchView(search: '${_.label}')));
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Theme.of(context).primaryColor,
//                               padding: EdgeInsets.symmetric(vertical: 15),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15),
//                               ),
//                             ),
//                             child: Text("${_.label}",
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                 )),
//                           ),
//                         ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
