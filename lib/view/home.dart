import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_ml_example/data/data.dart';
import 'package:google_ml_example/models/categorie_model.dart';
import 'package:google_ml_example/view/search_view.dart';
import 'package:google_ml_example/widget/widget.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import '../models/photos_model.dart';
import '../utils/api_key.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategorieModel> categories = [];

  int noOfImageToLoad = 50;
  List<PhotosModel> photos = [];
  int page = 1;
  bool isLoading = false;
  bool isLoadingWall = false;

  getTrendingWallpaper() async {
    setState(() {
      isLoading = true;
    });
    await http.get(Uri.parse("https://api.pexels.com/v1/curated?per_page=20"),
        headers: {"Authorization": pexels_apiKEY}).then((value) {
      //print(value.body);
      // Map result = jsonDecode(value.body);
      // setState(() {
      //   photos = result['photos'];
      // });

      if (value.statusCode == 200) {
        setState(() {
          isLoadingWall = false;
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
          isLoadingWall = false;
        });
        Get.snackbar("", "Check your connection");
      }
    });
  }

  loadmore() async {
    setState(() {
      isLoading = true;
      page = page + 1;
    });
    String url = 'https://api.pexels.com/v1/curated?per_page=10&page=$page';
    await http.get(Uri.parse(url),
        headers: {'Authorization': pexels_apiKEY}).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //print(element);
        PhotosModel photosModel = PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
        //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    //getWallpaper();
    getTrendingWallpaper();
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: brandName("Wallpapers", "Point"),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: NotificationListener(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            loadmore();
          }
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextFormField(
                      controller: searchController,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (searchController.text != "") {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchView(
                                            search: searchController.text,
                                          )))
                              .then((value) => searchController.clear());
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Search wallpapers",
                          border: InputBorder.none),
                    )),
                    InkWell(
                        onTap: () {
                          if (searchController.text != "") {
                            FocusScope.of(context).requestFocus(FocusNode());
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SearchView(
                                              search: searchController.text,
                                            )))
                                .then((value) => searchController.clear());
                          }
                        },
                        child: Container(child: Icon(Icons.search)))
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              // Container(
              //   height: 80,
              //   child: ListView.builder(
              //       padding: EdgeInsets.symmetric(horizontal: 24),
              //       itemCount: categories.length,
              //       shrinkWrap: true,
              //       scrollDirection: Axis.horizontal,
              //       itemBuilder: (context, index) {
              //         /// Create List Item tile
              //         return CategoriesTile(
              //           imgUrls: categories[index].imgUrl!,
              //           categorie: categories[index].categorieName!,
              //         );
              //       }),
              // ),
              wallPaper(photos, context),
              if (isLoading)
                SpinKitThreeBounce(
                  color: Color.fromARGB(255, 199, 23, 11),
                  size: 50.0,
                ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
