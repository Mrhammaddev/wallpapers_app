import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_example/models/photos_model.dart';
import 'package:google_ml_example/view/image_view.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

Widget wallPaper(List<PhotosModel> listPhotos, BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 0.6,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
        children: listPhotos.map((PhotosModel photoModel) {
          return GridTile(
              child: GestureDetector(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => ImageView(
              //               imgPath: photoModel.src!.portrait!,
              //             )));
              pushNewScreen(
                context,
                screen: ImageView(imgPath: photoModel.src!.portrait!),
                withNavBar: false,
              );
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                    imageUrl: photoModel.src!.portrait!,
                    placeholder: (context, url) => Container(
                          color: Color(0xfff5f8fd),
                        ),
                    fit: BoxFit.cover)),
          ));
        }).toList()),
  );
}

Widget brandName(String t1, String t2) {
  return Row(
    // mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        t1,
        style: TextStyle(color: Colors.black87, fontFamily: 'Overpass'),
      ),
      Text(
        t2,
        style: TextStyle(
            color: Color.fromARGB(255, 199, 23, 11), fontFamily: 'Overpass'),
      )
    ],
  );
}
