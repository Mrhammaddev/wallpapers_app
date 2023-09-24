import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_ml_example/models/photos_model.dart';
import 'package:google_ml_example/widget/scroll_behaviour.dart';
import 'package:google_ml_example/widget/widget.dart';
import 'package:http/http.dart' as http;

import '../utils/api_key.dart';

class CategoriesDetailScreen extends StatefulWidget {
  final String categorie;

  CategoriesDetailScreen({required this.categorie});

  @override
  _CategoriesDetailScreenState createState() => _CategoriesDetailScreenState();
}

class _CategoriesDetailScreenState extends State<CategoriesDetailScreen> {
  List<PhotosModel> photos = [];
  bool isLoading = false;

  getCategorieWallpaper() async {
    setState(() {
      isLoading = true;
    });
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=${widget.categorie}&per_page=200"),
        headers: {"Authorization": pexels_apiKEY}).then((value) {
      //print(value.body);
      // Map result = jsonDecode(value.body);
      // setState(() {
      //   photos = result['photos'];
      // });

      if (value.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        Map<String, dynamic> jsonData = jsonDecode(value.body);
        jsonData["photos"].forEach((element) {
          //print(element);
          PhotosModel photosModel = PhotosModel();
          photosModel = PhotosModel.fromMap(element);
          photos.add(photosModel);
          //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
        });
      } else {
        setState(() {
          isLoading = false;
        });
        Get.snackbar("", "Check your connection");
      }
    });
  }

  @override
  void initState() {
    getCategorieWallpaper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(widget.categorie, ""),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: (isLoading)
            ? SpinKitFadingCube(
                color: Color.fromARGB(255, 199, 23, 11),
                size: 23.0,
              )
            : wallPaper(photos, context),
      ),
    );
  }
}
