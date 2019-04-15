import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:fluro/fluro.dart';

import './pages/index_page.dart';

import './provide/counter.dart';
import './provide/child_category.dart';
import './provide/category_goods_list.dart';


import './routers/routes.dart';
import './routers/application.dart';



// void main() => runApp(MyApp());

void main(){
  var counter = Counter();
  var providers = Providers();
  var categoryGoodsListProvide = CategoryGoodsListProvide();
  var childCategory = ChildCategory();
  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide));
  runApp(ProviderNode(child: MyApp(),providers: providers,));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
        title: 'shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink,
        ),
        home: IndexPage(),
      ),
    );
  }
}