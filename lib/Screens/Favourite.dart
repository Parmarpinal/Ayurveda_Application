import 'package:flutter/material.dart';

import '../Widgets/FavouriteCategory.dart';
import '../Widgets/FavouriteMedicine.dart';
import '../Widgets/FavouriteSubCatRemedy.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  List<Widget> pages = [
    FavouriteMedicine(),
    FavouriteSubCatRemedy(),
    FavouriteCategory(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('पसंदीदा'),
            bottom: TabBar(
              tabs: [
                Text('रोग और उपचार'),
                Text('स्वास्थ्य युक्तियाँ'),
                Text('आयुर्वेदिक औषधियां')
              ],
              onTap: (value) {
                setState(() {});
              },
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: Colors.white60,
              labelColor: Colors.white,
              labelStyle: TextStyle(fontWeight: FontWeight.w600),
              indicatorColor: Colors.red,
              dividerHeight: 0,
              dividerColor: Colors.green,
            ),
          ),
          body: TabBarView(children: pages),
        ));
  }
}
