import 'package:ayurveda/Screens/HomePage.dart';
import 'package:ayurveda/Widgets/DetailPage.dart';
import 'package:ayurveda/database/myDatabase.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key, required this.heading, required this.items});

  final String heading;
  final List<Map<String, dynamic>> items;

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  bool isSearching = false; // Tracks whether the search mode is active
  bool isSearchAble = true; // check weather search icon is enable or not
  TextEditingController searchController = TextEditingController(); // For search input
  List<Map<String, dynamic>> filteredItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredItems = widget.items;
    if(widget.heading == "स्वास्थ्य युक्तियाँ"){
      isSearchAble = false;
      isSearching = false;
    }
  }

  void _filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredItems = widget.items;
      } else {
        filteredItems = widget.items
            .where((item) =>
        item['name_eng'] != null &&
            item['name_eng'].toLowerCase().contains(query.toLowerCase()) ||
        item['name_hin'] != null &&
            item['name_hin'].toLowerCase().contains(query.toLowerCase())
        ).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
          controller: searchController,
          autofocus: true,
          cursorColor: Colors.yellow,
          decoration: InputDecoration(
            hintText: "Search...",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white60),
          ),
          style: TextStyle(color: Colors.white,fontSize: 18),
          onChanged: _filterItems,
        )
            : Text(widget.heading), // Default title when not searching,
        actions: [
          // Check if the current screen allows the search icon
          isSearchAble
              ? (isSearching
              ? IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              setState(() {
                isSearching = false;
                searchController.clear(); // Clear search input
                filteredItems = widget.items;
              });
            },
          )
              : IconButton(
            icon: Icon(Icons.search),
            onPressed: isSearchAble
                ? () {
              setState(() {
                isSearching = true;
              });
            }
                : null, // Disable the button if isSearchAble is false
          ))
              : SizedBox.shrink(), // No icon for this screen
        ],


        // actions: [
        //   isSearching
        //       ? IconButton(
        //     icon: Icon(Icons.close),
        //     onPressed: () {
        //       setState(() {
        //         isSearching = false;
        //         searchController.clear(); // Clear search input
        //         filteredItems = widget.items;
        //       });
        //     },
        //   )
        //       : IconButton(
        //     icon: Icon(Icons.search),
        //     onPressed: () {
        //       setState(() {
        //         isSearching = true;
        //       });
        //     },
        //   ),
        // ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 9),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                if (filteredItems[index]['description'] == "Empty") {
                  await MyDatabase().copyPasteAssetFileToRoot();
                  List<Map<String, dynamic>> list1 = await MyDatabase()
                      .getSubCatRemedyDetail(filteredItems[index]['id']);
                  List<Map<String, dynamic>> convertedList = createNewList(
                      list1: list1,
                      name: "Sub_Cat_Remedy_Detail_Name",
                      id: "Sub_Cat_Remedy_Detail_Id",
                      description: "Description",
                      region: "Sub_Cat_Remedy_Detail"
                  );
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ListPage(
                          heading: filteredItems[index]['name'], items: convertedList)));
                } else {
                  Map<String, dynamic> detailsMap = {};
                  detailsMap['id'] = filteredItems[index]['id'];
                  detailsMap['description'] = filteredItems[index]['description'];
                  detailsMap['isFavourite'] = filteredItems[index]['isFavourite'];
                  detailsMap['region'] = filteredItems[index]['region'];

                  if (filteredItems[index]['region'] == "Sub_Cat_Remedy_Detail") {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DetailPage(details: detailsMap, heading: widget.heading),
                    ));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailPage(
                          details: detailsMap, heading: filteredItems[index]['name']),
                    ));
                  }
                }
              },
              child: Column(
                children: [
                  ListTile(
                    minTileHeight: 0,
                    minVerticalPadding: 2,
                    title: Text(
                      filteredItems[index]['name']!,
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right,
                        color: Colors.grey.shade400, size: 23,),
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                  )
                ],
              ),
            );
          },
          itemCount: filteredItems.length,
        ),
      ),
    );
  }
}
