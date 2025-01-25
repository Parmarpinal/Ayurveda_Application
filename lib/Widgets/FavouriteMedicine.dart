import 'package:ayurveda/Widgets/DetailPage.dart';
import 'package:ayurveda/database/myDatabase.dart';
import 'package:flutter/material.dart';

class FavouriteMedicine extends StatefulWidget {
  const FavouriteMedicine({super.key});

  @override
  State<FavouriteMedicine> createState() => _FavouriteMedicineState();
}

class _FavouriteMedicineState extends State<FavouriteMedicine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      FutureBuilder(future: MyDatabase().copyPasteAssetFileToRoot(), builder: (context, snapshot1) {
        if(snapshot1.hasData){
          return FutureBuilder(future: MyDatabase().getFavouriteMedicine(), builder: (context, snapshot) {
            if(snapshot.hasData){
              return
                Padding(
                  padding: const EdgeInsets.only(top: 9),
                  child: ListView.builder(itemBuilder: (context, index) {
                    return
                      InkWell(
                        onTap: (){
                          Map<String, dynamic> detailsMap = {};
                          detailsMap['id'] = snapshot.data![index]['Disease_Medicine_Detail_Id'];
                          detailsMap['description'] = snapshot.data![index]['Discription'];
                          detailsMap['isFavourite'] = snapshot.data![index]['IsFavourite'];
                          detailsMap['region'] = 'Disease_Medicines_Detail';

                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage(details: detailsMap, heading: snapshot.data![index]['Disease_Name']),)).then((val){
                            setState(() {

                            });
                          });

                        },
                        child: Column(
                          children: [
                            ListTile(
                              minTileHeight: 0,
                              minVerticalPadding: 2,
                              title: Text(snapshot.data![index]['Disease_Name'],style: TextStyle(fontSize: 20),),
                              trailing: Icon(Icons.keyboard_arrow_right,
                                  color: Colors.grey.shade400, size: 23),
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                            )
                          ],
                        ),
                      );
                  },
                    itemCount: snapshot.data!.length,
                  ),
                );
            }
            else if(snapshot.hasError){
              return Center(child: Text(snapshot.error.toString()));
            }
            else{
              return CircularProgressIndicator();
            }
          },
          );
        }
        else if(snapshot1.hasError){
          return Center(child: Text(snapshot1.error.toString()));
        }
        else{
          return CircularProgressIndicator();
        }
      },),
    );
  }
}
