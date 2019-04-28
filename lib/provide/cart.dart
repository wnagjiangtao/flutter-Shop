import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/cartInfo.dart';

class CartProvide with ChangeNotifier{
     String cartString = '[]';
     List<CartInfoMode> cartList = [];

    save(goodsId,goodsName,count,price,images)async{
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    var temp = cartString==null?[]:json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    var isHave = false;
    int ival = 0;
    tempList.forEach((item){
      if(item['goodList'] == goodsId){
        tempList[ival]['count'] = item['count']+1;
        cartList[ival].count++;
        isHave = true;
      }
      ival++;
    });
    if(!isHave){
      Map<String,dynamic> newGoods = {
        'goodsId':goodsId,
        'goodsName':goodsName,
        'count':count,
        'price':price,
        'images':images
      };
      print('herre');
      tempList.add(newGoods);
      cartList.add(new CartInfoMode.fromJson(newGoods));
    }
    cartString = json.encode(tempList).toString();
    print(cartString);
    prefs.setString('cartInfo', cartString);
  }

  remove()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    prefs.remove('cartInfo');
    notifyListeners();
  }

  getCartInfo()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    cartList = [];
    if(cartString ==null){
      cartList=[];
    }else{
      List<Map> temList = (json.decode(cartString.toString()) as List).cast();
      temList.forEach((item){
        cartList.add(new CartInfoMode.fromJson(item));
      });

    }
    notifyListeners();
  }
}