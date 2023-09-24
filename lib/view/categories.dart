import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_ml_example/utils/constants.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../data/data.dart';
import '../models/categorie_model.dart';
import '../widget/widget.dart';
import 'categorie_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<CategorieModel> categories = [];
  @override
  void initState() {
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: brandName("Cate", "gories"),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: ListView.separated(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        itemCount: categories.length,
        shrinkWrap: true,
        // scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CategoriesTile(
            imgUrls: categories[index].imgUrl!,
            categorie: categories[index].categorieName!,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 12,
          );
        },
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String imgUrls, categorie;

  CategoriesTile({required this.imgUrls, required this.categorie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushNewScreen(context,
            screen: CategoriesDetailScreen(categorie: categorie),
            withNavBar: false);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => CategorieScreen(
        //               categorie: categorie,
        //             )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 8),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: kIsWeb
                    ? Image.network(
                        imgUrls,
                        height: 100,
                        width: kWidth(context),
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        imageUrl: imgUrls,
                        height: 100,
                        width: kWidth(context),
                        fit: BoxFit.cover,
                      )),
            Container(
              height: 100,
              width: kWidth(context),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Container(
                height: 100,
                width: kWidth(context),
                alignment: Alignment.center,
                child: Text(
                  categorie,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Overpass'),
                ))
          ],
        ),
      ),
    );
  }
}
