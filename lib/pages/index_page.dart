import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'home_page.dart';
import 'category_page.dart';
import 'cart_page.dart';
import 'member_page.dart';
import '../provide/currentIndex.dart';

class IndexPage extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      title:Text('首页'),
      icon: Icon(CupertinoIcons.home), 
    ),
    BottomNavigationBarItem(
      title:Text('分类'),
      icon: Icon(CupertinoIcons.search), 
    ),
    BottomNavigationBarItem(
      title:Text('购物车'),
      icon: Icon(CupertinoIcons.shopping_cart), 
    ),
    BottomNavigationBarItem(
      title:Text('会员中心'),
      icon: Icon(CupertinoIcons.profile_circled), 
    ),
  ];

  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    return Container(
      child: Provide<CurrentIndexProvide>(
        builder: (context,child,val){
          int currentIndex = Provide.value<CurrentIndexProvide>(context).currentIndex;
          return Scaffold(
            backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              items: bottomTabs,
              onTap: (index){
                Provide.value<CurrentIndexProvide>(context).changeIndex(index);
              },
            ),
            body: IndexedStack(
              index: currentIndex,
              children: tabBodies,
            ),
          );
        },
     ),
    );
  }
}
