import 'package:ayurveda/Screens/AboutUs.dart';
import 'package:ayurveda/Screens/Favourite.dart';
import 'package:ayurveda/Screens/FeedbackScreen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

import '../Widgets/ListPage.dart';
import '../database/myDatabase.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String appUrl = 'https://play.google.com/store/apps/details?id=com.aswdc_ayurveda';

  Future<void> _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _redirectToPlayStore() async {
    String query = "pub:Darshan University";
    String url = "market://search?q=$query";
    if(await canLaunchUrl(Uri.parse(url))){
      await launchUrl(Uri.parse(url));
    }else{
      throw 'Could not redirect';
    }
  }

  final List<Map<String, dynamic>> menu = [
    {"menuName": "रोग और उपचार", "menuIcon": Icons.medical_services},
    {"menuName": "स्वास्थ्य युक्तियाँ", "menuIcon": Icons.tips_and_updates},
    {"menuName": "आयुर्वेदिक औषधियां", "menuIcon": Icons.eco},
    {"menuName": "पसंदीदा", "menuIcon": Icons.star}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Ayurveda'),
        actions: [
          PopupMenuButton<String>(icon: Icon(Icons.more_vert),
            onSelected: (value) {
              if(value == 'About us'){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AboutUs(),));
              }else if(value == 'Check for update'){
                _launchUrl(appUrl);
              }else if(value == 'Other Apps'){
                _redirectToPlayStore();
              }else if(value == 'Feedback'){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => FeedbackScreen()));
              }else if(value == 'Share'){
                Share.share("Download Ayurveda app from Google Play Store. $appUrl");
              }
            },itemBuilder: (context) =>
            [
              PopupMenuItem<String>(
                value: 'Check for update',
                child: Text('Check for update',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
              ),
              PopupMenuItem<String>(
                value: 'Feedback',
                child: Text('Feedback',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
              ),
              PopupMenuItem<String>(
                value: 'Share',
                child: Text('Share',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
              ),
              PopupMenuItem<String>(
                value: 'Other Apps',
                child: Text('Other Apps',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
              ),
              PopupMenuItem<String>(
                value: "About us",
                child: Text('About us',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
              ),
            ]
            ,)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset('assets/images/img4.webp',height: 200,
                  width: (MediaQuery.of(context).size.width >= 500)? 400 : MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10,right: 10,),
              child:
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width > 800
                      ? 4
                      : MediaQuery.of(context).size.width > 600
                      ? 3
                      : 2, // Default to 2 for smaller screens
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.6, // Ensures all containers have the same aspect ratio
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      if(index == 0){
                        await MyDatabase().copyPasteAssetFileToRoot();
                        List<Map<String, dynamic>> l1 = await MyDatabase().getMedicineDetail();
                        String name = 'Disease_Name';
                        String des = 'Discription';
                        String id = 'Disease_Medicine_Detail_Id';
                        List<Map<String, dynamic>> convertedList = createNewList(list1: l1,name: name,description: des, id: id, region: "Disease_Medicines_Detail");
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ListPage(heading: menu[0]['menuName'], items: convertedList,))
                        );
                      }
                      else if(index == 1){
                        await MyDatabase().copyPasteAssetFileToRoot();
                        List<Map<String, dynamic>> l1 = await MyDatabase().getRemedies();
                        String name = 'Remedy_Name';
                        String id = 'Remedy_Id';
                        List<Map<String, dynamic>> convertedList = createNewList(list1: l1,name: name, id: id, region: "Remedies");
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ListPage(heading: menu[1]['menuName'], items: convertedList))
                        );
                      }
                      else if(index == 2){
                        await MyDatabase().copyPasteAssetFileToRoot();
                        List<Map<String, dynamic>> l1 = await MyDatabase().getCategoryDetail();
                        String name = 'Detail_Cat_Name';
                        String des = 'Remark';
                        String id = 'Detail_Cat_Id';
                        List<Map<String, dynamic>> convertedList = createNewList(list1: l1,name: name,description: des, id: id,region: "Category_Detail");
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ListPage(heading: menu[2]['menuName'], items: convertedList,))
                        );
                      }
                      else if(index == 3){
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Favourite())
                        );
                      }
                      else{
                        print("============ Routing not working =============");
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            menu[index]["menuIcon"],
                            color: Theme.of(context).primaryColor,
                            size: MediaQuery.of(context).size.width > 800? 50 : MediaQuery.of(context).size.width * 0.09,
                          ),
                          SizedBox(height: 2),
                          Text(
                            menu[index]["menuName"],
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: MediaQuery.of(context).size.width >= 900 ? 25 : MediaQuery.of(context).size.width >= 600?20: MediaQuery.of(context).size.width * 0.05),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: menu.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> createNewList(
    {required List<Map<String, dynamic>> list1,required String name, String description="",required String id, required String region}){
  List<Map<String, dynamic>> convertedList = list1.map((item) {
    return {
      'name': item[name],
      'id':item[id],

      if(description == "")
        'description': "Empty"
      else
        'description': item[description],

      if(description == "")
        'isFavourite': null
      else
        'isFavourite': item['IsFavourite'],

      'region': region,
      'name_eng': item['Name_ENG'],
      'name_hin': item['Name_HIN']

    };
  }).toList();
  return convertedList;
}
