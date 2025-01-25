import 'dart:io';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ayurveda/database/myDatabase.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:path_provider/path_provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.details, required this.heading});

  final Map<String, dynamic> details;
  final String heading;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Map<String, dynamic> detailMap = {};
  final ScreenshotController _screenshotController = ScreenshotController();

  Future<void> takeScreenShotAndShare() async {
    var image = await _screenshotController.capture();
    print(image);
    if(image != null){
      final directory = await getApplicationDocumentsDirectory();
      var imagePath = await File('${directory.path}/screenshot.png');
      await imagePath.writeAsBytes(image);
      Share.shareXFiles([XFile(imagePath.path)], text: 'Screenshot shared successfully');
    }
  }

  @override
  void initState() {
    super.initState();
    detailMap['isFavourite'] = widget.details['isFavourite'];
    detailMap['region'] = widget.details['region'];
    detailMap['description'] = widget.details['description'];
    detailMap['id'] = widget.details['id'];
    print('==================================\n'+detailMap.toString());
    print('id = '+detailMap['id'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.heading),
          actions: [
            IconButton(onPressed: takeScreenShotAndShare, icon: Icon(Icons.share),color: Colors.white,),
            // ShareButton(screenshotController: _screenshotController),
            IconButton(
                onPressed: () async {
                  //Update Category detail
                  if(detailMap['region'] == 'Category_Detail'){
                    print('yesssssssssssss');
                    print('before = '+detailMap['isFavourite'].toString());
                    int n = await MyDatabase().updateFavouriteCategory(
                        detailMap['id'],
                        detailMap['isFavourite'] == 1 ? 0 : 1
                    );
                    print('after = '+detailMap['isFavourite'].toString());
                    List<Map<String, dynamic>> op = await MyDatabase().getCategoryDetailItem(detailMap['id']);
                    print('new ===================' + op[0]['IsFavourite'].toString());
                    setState(() {
                      detailMap['isFavourite'] = op[0]['IsFavourite'];
                    });
                  }

                  //update sub cat remedy detail
                  else if(detailMap['region'] == 'Sub_Cat_Remedy_Detail'){
                    int n = await MyDatabase().updateFavouriteSubRemedy(
                        detailMap['id'],
                        detailMap['isFavourite'] == 1 ? 0 : 1
                    );
                    List<Map<String, dynamic>> op = await MyDatabase().getSubRemedyDetailItem(detailMap['id']);
                    setState(() {
                      detailMap['isFavourite'] = op[0]['IsFavourite'];
                    });

                  }

                  //update medicine detail
                  else if(detailMap['region'] == 'Disease_Medicines_Detail'){
                    int n = await MyDatabase().updateFavouriteMedicine(
                        detailMap['id'],
                        detailMap['isFavourite'] == 1 ? 0 : 1
                    );
                    List<Map<String, dynamic>> op = await MyDatabase().getMedicineDetailItem(detailMap['id']);
                    setState(() {
                      detailMap['isFavourite'] = op[0]['IsFavourite'];
                    });

                  }

                },
                icon: detailMap['isFavourite'] == 1
                    ? Icon(
                  Icons.star,
                  size: 28,
                  color: Colors.yellow,
                )
                    : Icon(
                  Icons.star_border,
                  size: 28,
                  color: Colors.white,
                ))
          ],
        ),
        body:

        Screenshot(
          controller: _screenshotController,
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(10),
              child: HtmlWidget(detailMap['description'].toString(),textStyle: TextStyle(fontSize: 17),),
            ),
          ),
        )
    );
  }
}
