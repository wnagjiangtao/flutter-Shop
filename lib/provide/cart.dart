import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/cartInfo.dart';

class CartProvide with ChangeNotifier{
     String cartString = '[]';
     List<CartInfoMode> cartList = [];
     double allPrice = 0;    //总价格
     int allGoodsCount = 0;  //总数量
     bool isAllCheck= true; //是否全选

    save(goodsId,goodsName,count,price,images)async{
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    var temp = cartString==null?[]:json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    var isHave = false;
    int ival = 0;

    allPrice = 0;
    allGoodsCount = 0;
    tempList.forEach((item){
      if(item['goodList'] == goodsId){
        tempList[ival]['count'] = item['count']+1;
        cartList[ival].count++;
        isHave = true;
      }
      if(item['isCheck']){
        allPrice+= (cartList[ival].price* cartList[ival].count);
        allGoodsCount+= cartList[ival].count;
      }
      ival++;
    });
    if(!isHave){
      Map<String,dynamic> newGoods = {
        'goodsId':goodsId,
        'goodsName':goodsName,
        'count':count,
        'price':price,
        'images':images,
        'isCheck': true,
      };
      print('herre');
      tempList.add(newGoods);
      cartList.add(new CartInfoMode.fromJson(newGoods));
      allPrice+= (count * price);
      allGoodsCount+=count;
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
    print(cartString);
    if(cartString ==null){
      cartList=[];
    }else{
      List<Map> temList = (json.decode(cartString.toString()) as List).cast();
      allGoodsCount = 0;
      allPrice = 0;
      isAllCheck = true;
      temList.forEach((item){
        if(item['isCheck']){
          allPrice+=(item['count']*item['price']);
          allGoodsCount+=item['count'];
          print(allGoodsCount);
        }else{
          isAllCheck = false;
        }
        cartList.add(new CartInfoMode.fromJson(item));
      });

    }

    notifyListeners();
  }

  deleteOneGoods(String goodsId)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int delIndex = 0;

    tempList.forEach((item){
      if(item['goodsId'] == goodsId){
        delIndex = tempIndex;
      }
      tempIndex++;
    });

    tempList.removeAt(delIndex);
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  changeCheckState(CartInfoMode cartItem) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item){
      if(item['goodsId'] == cartItem.goodsId){
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList[changeIndex] = cartItem.toJson();
     print(tempList);
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  changeAllCheckBtnState(bool isCheck) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    List<Map> newList = [];
    
    print('aadf');
    for(var item in tempList){
      var newItem = item;
      newItem['isCheck'] = true;
      newList.add(newItem);
    }

    cartString = json.encode(newList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  addOrReduceAction(var cartItem,String todo)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;

    tempList.forEach((item){
      if(item['goodsId'] == cartItem.goodsId){
        changeIndex = tempIndex;
      }
      tempIndex++;
    });

    if(todo == 'add'){
      cartItem.count++;
    }else if(cartItem.count>1){
      cartItem.count--;
    }

    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }
}