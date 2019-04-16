import 'package:flutter/material.dart';
import '../model/details.dart';
import 'dart:convert';
import '../service/service_method.dart';

class DetailsInfoProvide with ChangeNotifier{
  DetailsModel goodsInfo = null;

  getGoodsInfo(String id){
    var formData = {'goodId':id};
    request('getGoodDetailById',formData: formData).then((val){
      var data = json.decode(val.toString());
      print(data);

      goodsInfo = DetailsModel.fromJson(data);
      notifyListeners();
    });
  }

  
}

