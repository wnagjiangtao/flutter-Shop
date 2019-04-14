import 'package:flutter/material.dart';
import '../model/category.dart';


class ChildCategory with ChangeNotifier{

  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0;
  String categoryId = '4'; //大类ID
  String subId ='';  //小类ID
  int page=1;  //列表页数，当改变大类或者小类时进行改变
  String noMoreText=''; //显示更多的标识

  getChildCategory(List<BxMallSubDto> list,String id){

    page=1;
    noMoreText = ''; 
    subId='';
    categoryId = id;
    childIndex = 0;
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId='00';
    all.mallCategoryId='00';
    all.mallSubName = '全部';
    all.comments = 'null';

    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  changeChildIndex(int index,String id){
    page=1;
    noMoreText = ''; 
    subId = id;
    childIndex = index;
    notifyListeners();
  }

  addPage(){
    page++;
  }

  changeNoMore(String text){
    noMoreText=text;
    notifyListeners();
  }
}