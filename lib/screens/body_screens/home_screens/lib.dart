import 'dart:convert';
import 'package:bible_bot/api/api.dart';
import 'package:bible_bot/models/style_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:bible_bot/models/lib.dart';
import 'package:bible_bot/widgets/width_division_line.dart';
class Lib extends StatelessWidget {
  Future<Library> post;
  String id = Api.id;
  String pw = Api.pw;
  bool status403=false;

//401 -> 세션만료 , 500 -> 구문 분석오류(반납 책이 없음), 250-> 정상 403-> 대출목록 없음
  @override
  /*void didChangeDependencies() {
    //super.didChangeDependencies();
    post = Api().getlib(Api.id, Api.pw) as Future<Library>;
  }*/

  @override
  Widget build(BuildContext context) {
    StyleModel styleModel = Provider.of<StyleModel>(context);
    return Scaffold(
      backgroundColor: styleModel.getBackgroundColor()['backgroundColorLevel1'],
      appBar: AppBar(
        elevation: 1,
        iconTheme: IconThemeData(
            color: styleModel.getBackgroundColor()['reversalColorLevel1']),
        backgroundColor:
            styleModel.getBackgroundColor()['backgroundColorLevel1'],
        title: Text(
          '도서관 ',
          style: styleModel.getTextStyle()['appBarTextStyle'],
        ),
      ),
      body: FutureBuilder(
        future:
        //Api().getlib(id,pw),
        Api().getlib("ygflove95", "dms!15096"),
        //Api().getlib(id, pw),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.data['error']==null){
            status403=false;
          }else{
            status403=true;
          }
          if(snapshot.hasData){
            //print(snapshot.error);
            if(status403){
              return _status403(snapshot, styleModel, context,Api.pw);
            }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '추천도서',
                style: styleModel.getTextStyle()['appBarTextStyle'],
              ),
              Flexible(
                flex: 3,
                child: Swiper(
                  containerHeight: 10.0,
                  autoplay: true,
                  itemWidth: MediaQuery.of(context).size.width * 0.32,
                  itemHeight: MediaQuery.of(context).size.height * 0.4,
                  viewportFraction: 0.8,
                  layout: SwiperLayout.STACK,
                  pagination:
                      SwiperPagination(alignment: Alignment.bottomRight),
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) => Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        //server.getReq(headerkey.toString());
                         _showSnackBar(context,snapshot, index);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          height: 140.0,
                          width: 300.0,
                          decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('images/recom.png'),
                                    fit: BoxFit.cover)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.zero,
                  child:Text(''),
              ),
              Flexible(
                flex: 6,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data['data']['body'].length,
                  itemBuilder: (BuildContext context, int index) {
                    //print(snapshot.data.toString());
                      return Card(
                        color: Colors.grey[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              width: 100.0,
                              height: 135.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.memory(base64.decode(snapshot.data['data']['body'][index][6]['img'].toString()),
                                    fit: BoxFit.fill,
                                    height: 130.0,
                                    width: 100.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  new Text(
                                    //snapshot.data['error']['title'].toString(),
                                    snapshot.data['data']['body'][index][1].toString(),
                                    style: TextStyle(fontWeight: FontWeight.bold)
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Container(
                                    child: Column(children: <Widget>[
                                      Text(
                                        '대출일 :${snapshot.data['data']['body'][index][2]}' ,
                                        /*TextStyle(
                                          fontSize: 15.0,
                                          fontStyle: FontStyle.italic),*/
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Container(
                                        child: Text(
                                          '반납일: ${snapshot.data['data']['body'][index][3]} ',
                                          /*TextStyle(
                                            fontSize: 15.0,
                                            fontStyle: FontStyle.italic),*/
                                        ),
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                ),
              ),
            ],
          );
          }
          else if(snapshot.hasError){
            return _errorView(snapshot.error,styleModel);
          }
          else{
            return Center(child:CupertinoActivityIndicator());
          }
        },
      ),
    );
  }
}
Widget _status403(AsyncSnapshot snapshot,StyleModel styleModel, BuildContext context ,String pw){
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('추천도서',
            style: styleModel.getTextStyle()['appBarTextStyle'],),
          Flexible(flex: 3,
            child: Swiper(
              containerHeight: 10.0,
              autoplay: true,
              itemWidth: MediaQuery.of(context).size.width * 0.32,
              itemHeight: MediaQuery.of(context).size.height * 0.4,
              viewportFraction: 0.8,
              layout: SwiperLayout.STACK,
              pagination:
              SwiperPagination(alignment: Alignment.bottomRight),
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: GestureDetector(
                  onTap: () {
                    //server.getReq(headerkey.toString());
                    _showSnackBar(context, snapshot,index);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      height: 140.0,
                      width: 300.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/recom.png'),
                              fit: BoxFit.cover)),
                    ),
                  ),
                ),
              ),
            ),),
          WidthDivisionLine(),
          Flexible(
            flex: 7,
            child:Center(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Image.asset("images/study.gif", width: 300, height: 300),
                    SizedBox(height: 30),
                    Text('${snapshot.data['error']['title'].toString()}',style: styleModel.getTextStyle()['appBarTextStyle'],),
                    ],
        )
    ),),
        ],
    );
  }

Widget _errorView(String errorMessage,StyleModel styleModel ) {
  return Padding(
      padding: EdgeInsets.all(10),
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/study.gif", width: 300, height: 300),
              SizedBox(height: 30),
              Text(errorMessage,style: styleModel.getTextStyle()['appBarTextStyle'],),
            ],
          )
      )
  );
}
//추천 도서 받아야해
_showSnackBar(BuildContext context,AsyncSnapshot snapshot ,index) {
  final SnackBar objSnackbar = new SnackBar(
    content: Center(
      child: Material(
        elevation: 0,
        type: MaterialType.transparency,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width * 0.7,
          height: 500.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                /*child: new Image.asset(
                  item.images,
                  height: 200.0,
                  width: 150.0,
                ),*/
              ),
              SizedBox(
                height: 10.0,
              ),
              //Text('${item.name}'),
              SizedBox(
                height: 10.0,
              ),
              Text(
               '0', //' ${item.name}',
                style: TextStyle(color: Colors.grey, fontSize: 15.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '소개글 ',//: ${item.title}',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12.0,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ),
  );
  Scaffold.of(context).showSnackBar(objSnackbar);
}
