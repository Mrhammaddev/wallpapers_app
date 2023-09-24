// ignore_for_file: unused_field

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:google_ml_example/utils/constants.dart';
import 'package:wallpaper/wallpaper.dart';

class ImageView extends StatefulWidget {
  final String imgPath;

  ImageView({required this.imgPath});

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  // late bool goToHome;
  // String _platformVersion = 'Unknown';
  // String _wallpaperUrlBoth = "";
  @override
  void initState() {
    super.initState();
    // goToHome = false;
    // initPlatformState();
  }

  // Future<void> initPlatformState() async {
  //   String platformVersion;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   // We also handle the message potentially returning null.
  //   try {
  //     platformVersion =
  //         await AsyncWallpaper.platformVersion ?? 'Unknown platform version';
  //   } on PlatformException {
  //     platformVersion = 'Failed to get platform version.';
  //   }

  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;

  //   setState(() {
  //     _platformVersion = platformVersion;
  //   });
  // }

  // Future<void> setWallpaper() async {
  //   setState(() {
  //     _wallpaperUrlBoth = 'Loading';
  //   });
  //   String result;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     result = await AsyncWallpaper.setWallpaper(
  //       url: widget.imgPath,
  //       wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
  //       goToHome: goToHome,
  //       toastDetails: ToastDetails.success(),
  //       errorToastDetails: ToastDetails.error(),
  //     )
  //         ? 'Wallpaper set'
  //         : 'Failed to get wallpaper.';
  //   } on PlatformException {
  //     result = 'Failed to get wallpaper.';
  //   }

  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;

  //   setState(() {
  //     _wallpaperUrlBoth = result;
  //   });
  // }

  Stream<String>? progressString;
  String? res;
  bool downloading = false;

  Future<void> setWallpaper(BuildContext context) async {
    progressString = Wallpaper.imageDownloadProgress(widget.imgPath);

    progressString!.listen((data) {
      setState(() {
        res = data;

        downloading = true;
      });

      // print("DataReceived: " + data);
    }, onDone: () async {
      await Wallpaper.bothScreen();

      setState(() {
        downloading = false;
      });

      // print("Wallpaper set successfully!");
    }, onError: (error) {
      setState(() {
        downloading = false;
      });

      // print("Some Error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: CachedNetworkImage(
              imageUrl: widget.imgPath,
              placeholder: (context, url) => Container(
                color: Color(0xfff5f8fd),
              ),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 30,
            left: 15,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  padding: EdgeInsets.all(8),
                  decoration:
                      BoxDecoration(color: mainColor, shape: BoxShape.circle),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                    onTap: () {
                      setWallpaper(context);
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xff1C1B1B),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white24, width: 1),
                                borderRadius: BorderRadius.circular(40),
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0x36FFFFFF),
                                      Color(0x0FFFFFFF)
                                    ],
                                    begin: FractionalOffset.topLeft,
                                    end: FractionalOffset.bottomRight)),
                            child: downloading == true
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    "Set Wallpaper",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  )),
                      ],
                    )),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.white60,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // _save() async {
  //   await _askPermission();
  //   var response = await Dio().get(widget.imgPath,
  //       options: Options(responseType: ResponseType.bytes));
  //   final result =
  //       await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
  //   print(result);
  //   Navigator.pop(context);
  // }

  // _askPermission() async {
  //   if (Platform.isIOS) {
  //     /*Map<PermissionGroup, PermissionStatus> permissions =
  //         */
  //     await Permission.photos;
  //   } else {
  //     /* PermissionStatus permission = */
  //     Permission.storage;
  //   }
  // }
}
