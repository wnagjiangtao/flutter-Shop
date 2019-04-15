import 'package:flutter/material.dart';
import '../pages/details_page.dart';
import 'package:fluro/fluro.dart';

Handler detaislHandler = Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>>params){
    String goodsId = params['id'].first;
    print('${goodsId}');
    return DetailsPage(goodsId);
  }
);