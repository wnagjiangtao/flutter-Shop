import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import '../provide/details_info.dart';
import './details_page/details_top_area.dart';
import './details_page/details_explain.dart';
import './details_page/details_tabbar.dart';
import './details_page/detals_web.dart';


class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);
  Future _getBackInfo(BuildContext context )async{
      await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(this.goodsId);
      print('this');  
      return '完成加载';
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            print('返回上一页');
            Navigator.pop(context);
          },
        ),
        title: Text('商品详情页'),
      ),
      body: FutureBuilder(
        future: _getBackInfo(context),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return  SingleChildScrollView(
                // controller: controller,
                child: Column(
                  children: <Widget>[
                    DetailTopArea(),
                    DetailsExplain(),
                    DetailsTabBar(),
                    DetailsWeb(),
                  ],                    
                ),
              );
          
          }else{
            return Text('加载中');
          }
        },
      ),
    );
  }
}