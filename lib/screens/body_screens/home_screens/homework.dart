import 'dart:async';
import 'package:bible_bot/models/style_model.dart';
import 'package:bible_bot/widgets/width_division_line.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';


class Homework extends StatefulWidget {
  @override
  _HomeworkState createState() => _HomeworkState();
}

class _HomeworkState extends State<Homework> {
  @override
  Widget build(BuildContext context) {
    StyleModel styleModel = Provider.of<StyleModel>(context);
    return Scaffold(
      backgroundColor: styleModel.getBackgroundColor()['backgroundColorLevel1'],
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
            color: styleModel.getBackgroundColor()['reversalColorLevel1']),
        backgroundColor:
        styleModel.getBackgroundColor()['backgroundColorLevel1'],
        title: Text(
          '과제',
          style: styleModel.getTextStyle()['appBarTextStyle'],
        ),
      ),
      body: Column(children: <Widget>[
        Flexible(
          flex: 2,
          child: Container(),),
        WidthDivisionLine(),
        Flexible(
          flex: 8,
          child:ListView.builder(
              itemCount: 7,
              itemBuilder: (context,index){
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),child: ListTile(
                  trailing: IconButton(icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => moreview()),
                      );
                    },),
                  subtitle: Text('new과제:마감-6/14\nnew퀴즈:마감-6/20'),
                  leading: Text('전공선택.${index+1}'),
                  title: Text('현재 주차:1주차'),
                ),);
              }),),
      ],),
    );
  }
}

/*class body extends StatelessWidget {
  final List<String> items=List<String>.generate(10000, (i) => "Item $i");
  @override
  Widget build(BuildContext context,StyleModel styleModel) {
    return Column(children: <Widget>[
      Flexible(
        flex: 2,
        child: Container(),),
      WidthDivisionLine(),
      Flexible(
        flex: 8,
        child:ListView.builder(
          itemCount: 7,
            itemBuilder: (context,index){
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),child: ListTile(
                trailing: IconButton(icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => moreview()),
            );
            },),
              subtitle: Text('new과제:마감-6/14\nnew퀴즈:마감-6/20'),
              leading: Text('전공선택.${index+1}'),
              title: Text('현재 주차:1주차'),
            ),);
            }),),
    ],);
  }
}*/
class moreview extends StatefulWidget {
  @override
  _moreviewState createState() => _moreviewState();
}

class _moreviewState extends State<moreview> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      child: DefaultTabController(
        length: 2,
        child: new Scaffold(
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverAppBar(
                  automaticallyImplyLeading: true,
                  /*backgroundColor: styleModel
                      .getBackgroundColor()['backgroundColorLevel1'],*/
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back,),
                        /*color: styleModel
                            .getBackgroundColor()['reversalColorLevel1']),*/
                    onPressed: () => Navigator.pop(context),
                  ),
                  /*brightness:
                  styleModel.getBrightness()['appBarBrightness'],*/
                  title: Text(
                    "전공",
                   /* style: styleModel.getTextStyle()['appBarTextStyle'],*/
                  ),
                  floating: true,
                  pinned: true,
                  snap: true,
                  bottom: new TabBar(
                    tabs: [
                      new Tab(text: "과제"),
                      new Tab(text: "퀴즈",),
                    ],
                    /*labelStyle:
                    styleModel.getTextStyle()['bodyTitleTextStyle'],
                    unselectedLabelStyle:
                    styleModel.getTextStyle()['bodyTextStyle'],
                    indicatorColor:
                    styleModel.getBackgroundColor()['greenLevel1'],
                    indicatorWeight: 3.0,
                    labelColor: styleModel
                        .getBackgroundColor()['reversalColorLevel1'],
                    unselectedLabelColor:
                    styleModel.getBackgroundColor()['greyLevel2'],*/
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: <Widget>[
              Container(child: ListView.builder(itemCount: 15,itemBuilder: (context,index){
                return Card(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                ),child: ListTile(title: Text('${index+1}주차'),
                  subtitle: Text('<프로그래밍 예제 풀기>마감-~3/20\n<ppt만들기>마감:4/10'),
                ),);
              }),),
              Container(child: ListView.builder(itemCount: 15,itemBuilder: (context,index){
                return Card(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                ),child:ListTile(title: Text('${index+1}주차'),
                  subtitle: Text(' <퀴즈풀기> 마감-~3/20\n'),
                ),);
              }),),
            ],),
          ),
        ),
      ),
      data: MediaQuery.of(context).copyWith(textScaleFactor: 0.9),);
  }
}

/*
list뷰를 이용함-> 리스트 클릭시 과제,퀴즈 -> 택1하면 화면 넘어감
*/