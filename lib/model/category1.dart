class CategoryBigModel {
  String mallCategoryId;             //类别编号
  String mallCategoryName;          //类别名称
  List<dynamic>  bxMallSubDto;       //类别列表
  String image;                     //类别图片
  Null comments;                    //列表描述

  CategoryBigModel({
    this.mallCategoryId,
    this.mallCategoryName,
    this.image,
    this.comments,
    this.bxMallSubDto,
  });

  factory CategoryBigModel.fromJson(dynamic json){
    return CategoryBigModel(
      mallCategoryId: json['mallCategoryId'],
      mallCategoryName:json['mallCategoryName'],
      comments:json['comments'],
      image:json['image'],
      bxMallSubDto:json['bxMallSubDto']
    );
  }
}

class CategoryBigListModel {
  List<CategoryBigModel> data;
  CategoryBigListModel(this.data);
  factory CategoryBigListModel.formJson(List json){
    return CategoryBigListModel(
      json.map((i)=>CategoryBigModel.fromJson((i))).toList()
    );
  }
}