import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_ml_example/models/photos_model.dart';
import 'package:google_ml_example/widget/scroll_behaviour.dart';
import 'package:google_ml_example/widget/widget.dart';
import 'package:http/http.dart' as http;

import '../utils/api_key.dart';

class SearchView extends StatefulWidget {
  final String search;

  SearchView({required this.search});

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<PhotosModel> photos = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;

  getSearchWallpaper(String searchQuery) async {
    try {
      isLoading = true;
      var response = await http.get(
          Uri.parse(
              "https://api.pexels.com/v1/search?query=$searchQuery&per_page=200&page=1"),
          headers: {"Authorization": pexels_apiKEY});
      //print(value.body);
      // Map result = jsonDecode(value.body);
      // setState(() {
      //   photos = result['photos'];
      // });
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        // log("Success------------${response.body}");
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        jsonData["photos"].forEach((element) {
          //print(element);
          PhotosModel photosModel = PhotosModel();
          photosModel = PhotosModel.fromMap(element);
          photos.add(photosModel);
          //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
        });
      } else {
        Get.snackbar("Error", "Try again");
        log(response.body + "------error-----------------");
      }
    } catch (e) {
      // log("failed---------------------------");
    }
  }

  @override
  void initState() {
    getSearchWallpaper(widget.search);
    searchController.text = widget.search;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(widget.search, ""),
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
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

// Container(
//   decoration: BoxDecoration(
//     color: Color(0xfff5f8fd),
//     borderRadius: BorderRadius.circular(30),
//   ),
//   margin: EdgeInsets.symmetric(horizontal: 24),
//   padding: EdgeInsets.symmetric(horizontal: 24),
//   child: Row(
//     children: <Widget>[
//       Expanded(
//           child: TextFormField(
//         onFieldSubmitted: (value) {
//           FocusScope.of(context).requestFocus(FocusNode());
//           getSearchWallpaper(searchController.text);
//         },
//         controller: searchController,
//         decoration: InputDecoration(
//             hintText: "Search wallpapers",
//             border: InputBorder.none),
//       )),
//       InkWell(
//           onTap: () {
//             getSearchWallpaper(searchController.text);
//           },
//           child: Container(child: Icon(Icons.search)))
//     ],
//   ),
// ),
// SizedBox(
//   height: 30,
// ),
