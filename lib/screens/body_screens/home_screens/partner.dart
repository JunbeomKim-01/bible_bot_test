import 'dart:async';
import 'dart:convert';
import 'package:bible_bot/models/style_model.dart';
import 'package:bible_bot/widgets/width_division_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:bible_bot/api/api.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';


List<Marker> _markers = <Marker>[];




const kPrimaryColor = Colors.blue;
//Color(0xFF84AB5C);

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double defaultSize;
  static Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
    // On iPhone 11 the defaultSize = 10 almost
    // So if the screen size increase or decrease then our defaultSize also vary
    defaultSize = orientation == Orientation.landscape
        ? screenHeight * 0.024
        : screenWidth * 0.024;
  }
}
//_buildGoogleMap(context),
class Partner extends StatefulWidget {
  @override
  MapState createState() => MapState();
}

class MapState extends State<Partner> {
  Completer<GoogleMapController> _controller = Completer();
  @override
  void initState() {
    super.initState();
  }
  double to(String format) {
    var D = double.parse(format);
    assert(D is double);
    return D;
  }

  double zoomVal=10.0;
  @override

  Widget build(BuildContext context) {
    StyleModel styleModel=Provider.of<StyleModel>(context);
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: styleModel.getBackgroundColor()['backgroundColorLevel1'],
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
            color: styleModel.getBackgroundColor()['reversalColorLevel1']),
        backgroundColor:
        styleModel.getBackgroundColor()['backgroundColorLevel1'],
        actions: <Widget>[
          /*IconButton(
            icon: Icon(Icons.add),
            color:styleModel.getBackgroundColor()['reversalColorLevel1'],
            onPressed: (){
              _buldGrid(context);
            },
          ) ,*/

        ],
        title: Text(
          '제휴업체 ',
          style: styleModel.getTextStyle()['appBarTextStyle'],
        ),
      ),
      body:Column(
        children: <Widget>[
          Text('업데이트 예정입니다 :)',style: styleModel.getTextStyle()['appBarTextStyle'],),
          WidthDivisionLine(),
          Categories(),
          Flexible(
            child: _buldGrid(context,styleModel),),
        ],
      ),

    );
  }

//Flexible(
//               flex: 7,
//               child:FutureBuilder(
//                 future: Api().getAiliate(),
//                 builder: (BuildContext context,AsyncSnapshot snapshot){
//                   if(!snapshot.hasData){
//                     return Center(child: CupertinoActivityIndicator(),);
//                   }
//                   return GridView.builder(
//                       gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                           maxCrossAxisExtent: 270,
//                           // childAspectRatio: 1.1,
//                           // crossAxisSpacing: 1.1,
//                           mainAxisSpacing: 20),
//                       itemCount: snapshot.data['data']['body'].length,
//                       itemBuilder: (BuildContext context, index) {
//                         return Container(
//                           alignment: Alignment.topCenter,
//                           child: GestureDetector(
//                             onTap: () {
//                               // Navigator.push(context, MaterialPageRoute(builder: (context) => addPartner(context,StyleModel,snapshot,index)));
//                             },
//                             child:Container(
//                               child: new FittedBox(
//                                 child: Material(
//                                   color: Colors.white,
//                                   elevation: 10.0,
//                                   borderRadius: BorderRadius.circular(24.0),
//                                   shadowColor: Color(0x802196F3),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: <Widget>[
//                                       Flexible(
//                                         flex:2,
//                                         child: ClipRRect(
//                                           borderRadius: new BorderRadius.circular(24.0),
//                                           child: Image.memory(base64.decode(
//                                               snapshot.data['data']['body'][index][4]
//                                                   .toString()),fit: BoxFit.fill,),
//                                         ),),
//                                       Flexible(
//                                         flex: 1,
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Column(
//                                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                             children: <Widget>[
//                                               Padding(
//                                                 padding: const EdgeInsets.only(left: 8.0),
//                                                 child: Container(
//                                                     child: Text(snapshot.data['data']['body'][index][0],
//                                                       style: TextStyle(
//                                                           color: Color(0xff6200ee),
//                                                           fontSize: 30.0,
//                                                           fontWeight: FontWeight.bold),
//                                                     )),
//                                               ),
//                                               SizedBox(height:10.0),
//                                               Container(
//                                                 child: Row(
//                                                   children: <Widget>[
//                                                     Container(
//                                                       child: Text('',
//                                                         style: TextStyle(fontSize: 30,fontStyle: FontStyle.italic,fontWeight: FontWeight.w300),),
//                                                     ),
//                                                   ],),
//                                               ),
//                                               SizedBox(height: 10.0,),
//                                               /*Container(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 Container(
//                     child: Text(
//                       "4.1",
//                       style: TextStyle(
//                         color: Colors.black54,
//                         fontSize: 18.0,
//                       ),
//                     )),
//                 Container(
//                   child: Icon(
//                     Icons.star,
//                     color: Colors.amber,
//                     size: 15.0,
//                   ),
//                 ),
//                 Container(
//                   child: Icon(
//                     Icons.star,
//                     color: Colors.amber,
//                     size: 15.0,
//                   ),
//                 ),
//                 Container(
//                   child: Icon(
//                     Icons.star,
//                     color: Colors.amber,
//                     size: 15.0,
//                   ),
//                 ),
//                 Container(
//                   child: Icon(
//                     Icons.star,
//                     color: Colors.amber,
//                     size: 15.0,
//                   ),
//                 ),
//                 Container(
//                   child: Icon(
//                     Icons.star,
//                     color: Colors.amber,
//                     size: 15.0,
//                   ),
//                 ),
//                 Container(
//                     child: Text(
//                       "(946)",
//                       style: TextStyle(
//                         color: Colors.black54,
//                         fontSize: 18.0,
//                       ),
//                     )),
//               ],
//             )),
//         SizedBox(height:5.0),
//         Container(
//             child: Text(
//               "American \u00B7 \u0024\u0024 \u00B7 1.6 mi",
//               style: TextStyle(
//                 color: Colors.black54,
//                 fontSize: 18.0,
//               ),
//             )),
//         SizedBox(height:5.0),
//         Container(
//             child: Text(
//               "Closed \u00B7 Opens 17:00 Thu",
//               style: TextStyle(
//                   color: Colors.black54,
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.bold),
//             )),*/
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ],),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           decoration: BoxDecoration(
//                             //color: Colors.amber,
//                               borderRadius: BorderRadius.circular(15)),
//                         );
//                       });
//                 },
//               ),),
  Widget _buldGrid(BuildContext context,StyleModel styleModel){
    return FutureBuilder(
      future: Api().getAiliate(),
      builder:(BuildContext context,AsyncSnapshot snapshot){
      if(!snapshot.hasData){
        return Center(child: CupertinoActivityIndicator(),);
      }
      if(snapshot.hasError){
        return Center(child: CupertinoActivityIndicator(),);
      }
      return GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              // childAspectRatio: 5 / 2,
              // crossAxisSpacing: 20,
              mainAxisSpacing:10),
          itemCount: snapshot.data['data']['body'].length,
          itemBuilder: (BuildContext context, index) {
            if(snapshot.data==null){
              return Center(child: CupertinoActivityIndicator(),);
            }

            return Container(
              alignment: Alignment.topCenter,
              child: _boxes(context,snapshot,index,styleModel),
              decoration: BoxDecoration(
                //color: Colors.amber,
                  borderRadius: BorderRadius.circular(15)),
            );
          });
    },
    );
  }
  // Widget _buildContainer() {
  //   return Align(
  //     alignment: Alignment.bottomLeft,
  //     child: Container(
  //       margin: EdgeInsets.symmetric(vertical: 20.0),
  //       height: 130.0,
  //       child: ListView(
  //         scrollDirection: Axis.horizontal,
  //         children: <Widget>[
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: _boxes(
  //                 'https://lh5.googleusercontent.com/p/AF1QipNopffaAfF7r1uYKiDWyTUf16FPOwJ3TTmOJ6Ou=w408-h306-k-no', 37.65078009057755, 127.06205199833731
  //                 ,"국시집(시장풍경)"),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: _boxes(
  //                 "https://lh5.googleusercontent.com/p/AF1QipNa5fnaH0U3_dOReY2stJ5beeIas8rW7CzRmplN=w408-h306-k-no",
  //                 37.65017499904077, 127.06218171139746
  //                 ,"밀알 생돈까스"),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: _boxes(
  //                 "https://lh5.googleusercontent.com/p/AF1QipOtHBl7SK7ab-gdTG5GHRkIQDOT5Q8gM-PgcCD2=w426-h240-k-no",
  //                 37.65007633934943, 127.06125358321037
  //                 ,"우거지 품은 순대국"),
  //           ),
  //           Padding(padding: const EdgeInsets.all(8.0),
  //             child:_boxes("https://lh5.googleusercontent.com/p/AF1QipPKQtr1KB6-Bt2cieeCZmeoO80AqMpaOSgtl7t3=w156-h96-p-k-no", 37.65010347859033, 127.06188964982374
  //                 , "하이포크 "),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget _boxes(BuildContext context,AsyncSnapshot snapshot,index,StyleModel styleModel) {
    _markers.add(
        Marker(
            markerId: MarkerId(snapshot.data['data']['body'][index][0]),
            position: LatLng(to(snapshot.data['data']['body'][index][2]),to(snapshot.data['data']['body'][index][3])),
            infoWindow: InfoWindow(
                title: snapshot.data['data']['body'][index][0]
            )
        )
    );
    if(snapshot.data['data']['body'][index][4]==null){
      return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => addPartner(context, snapshot, index,styleModel)),
          );
        },
        child:Container(
          child: new FittedBox(
            child: Material(
              color: Colors.white,
              elevation: 10.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0x802196F3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 200,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image.asset('images/logo.png',
                        fit: BoxFit.fill,),
                      ),
                    ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                                child: Text(snapshot.data['data']['body'][index][0],
                                  style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 20),
                                ),
                            ),
                          ),
                          SizedBox(height:10.0),
                          // Container(
                          //   child: Row(
                          //     children: <Widget>[
                          //       Container(
                          //         child: Text(' ~%off!',
                          //           style: TextStyle(fontSize: 30,fontStyle: FontStyle.italic,fontWeight: FontWeight.w300),),
                          //       ),
                          //     ],),
                          // ),
                          // SizedBox(height: 10.0,),
                          /*Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    child: Text(
                      "4.1",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.0,
                      ),
                    )),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                    child: Text(
                      "(946)",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.0,
                      ),
                    )),
              ],
            )),
        SizedBox(height:5.0),
        Container(
            child: Text(
              "American \u00B7 \u0024\u0024 \u00B7 1.6 mi",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
        SizedBox(height:5.0),
        Container(
            child: Text(
              "Closed \u00B7 Opens 17:00 Thu",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            )),*/
                        ],
                      ),
                    ),
                  ),
                ],),
            ),
          ),
        ),
      );
    }
    return  GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => addPartner(context, snapshot, index,styleModel)),
        );
      },
      child:Container(
        child: new FittedBox(
          child: Material(
            color: Colors.white,
            elevation: 10.0,
            borderRadius: BorderRadius.circular(24.0),
            shadowColor: Color(0x802196F3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 200,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(24.0),
                    child: Image.memory(base64.decode(snapshot.data['data']['body'][index][4]),
                      fit: BoxFit.fill,
                    ),
                  ),),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                              child: Text(snapshot.data['data']['body'][index][0],
                                style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 20),
                        ),
                          ),
                        ),
                        SizedBox(height:10.0),
                        // Container(
                        //   child: Row(
                        //     children: <Widget>[
                        //       Container(
                        //         child: Text(' ~%off!',
                        //           style: TextStyle(fontSize: 30,fontStyle: FontStyle.italic,fontWeight: FontWeight.w300),),
                        //       ),
                        //     ],),
                        // ),
                        // SizedBox(height: 10.0,),
                        /*Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    child: Text(
                      "4.1",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.0,
                      ),
                    )),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                    child: Text(
                      "(946)",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.0,
                      ),
                    )),
              ],
            )),
        SizedBox(height:5.0),
        Container(
            child: Text(
              "American \u00B7 \u0024\u0024 \u00B7 1.6 mi",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
        SizedBox(height:5.0),
        Container(
            child: Text(
              "Closed \u00B7 Opens 17:00 Thu",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            )),*/
                      ],
                    ),
                  ),
                ),
              ],),
          ),
        ),
      ),
    );
  }



  // Widget myDetailsContainer1(String restaurantName) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: <Widget>[
  //       Padding(
  //         padding: const EdgeInsets.only(left: 8.0),
  //         child: Container(
  //             child: Text(restaurantName,
  //               style: TextStyle(
  //                   color: Colors.blue,
  //                   fontSize: 30.0,
  //                   fontWeight: FontWeight.bold),
  //             )),
  //       ),
  //       SizedBox(height:10.0),
  //       Container(
  //         child: Row(
  //           children: <Widget>[
  //             Container(
  //               child: Text(' ~%off!',
  //                 style: TextStyle(fontSize: 30,fontStyle: FontStyle.italic,fontWeight: FontWeight.w300),),
  //             ),
  //           ],),
  //       ),
  //       SizedBox(height: 10.0,),
  //       /*Container(
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: <Widget>[
  //               Container(
  //                   child: Text(
  //                     "4.1",
  //                     style: TextStyle(
  //                       color: Colors.black54,
  //                       fontSize: 18.0,
  //                     ),
  //                   )),
  //               Container(
  //                 child: Icon(
  //                   Icons.star,
  //                   color: Colors.amber,
  //                   size: 15.0,
  //                 ),
  //               ),
  //               Container(
  //                 child: Icon(
  //                   Icons.star,
  //                   color: Colors.amber,
  //                   size: 15.0,
  //                 ),
  //               ),
  //               Container(
  //                 child: Icon(
  //                   Icons.star,
  //                   color: Colors.amber,
  //                   size: 15.0,
  //                 ),
  //               ),
  //               Container(
  //                 child: Icon(
  //                   Icons.star,
  //                   color: Colors.amber,
  //                   size: 15.0,
  //                 ),
  //               ),
  //               Container(
  //                 child: Icon(
  //                   Icons.star,
  //                   color: Colors.amber,
  //                   size: 15.0,
  //                 ),
  //               ),
  //               Container(
  //                   child: Text(
  //                     "(946)",
  //                     style: TextStyle(
  //                       color: Colors.black54,
  //                       fontSize: 18.0,
  //                     ),
  //                   )),
  //             ],
  //           )),
  //       SizedBox(height:5.0),
  //       Container(
  //           child: Text(
  //             "American \u00B7 \u0024\u0024 \u00B7 1.6 mi",
  //             style: TextStyle(
  //               color: Colors.black54,
  //               fontSize: 18.0,
  //             ),
  //           )),
  //       SizedBox(height:5.0),
  //       Container(
  //           child: Text(
  //             "Closed \u00B7 Opens 17:00 Thu",
  //             style: TextStyle(
  //                 color: Colors.black54,
  //                 fontSize: 18.0,
  //                 fontWeight: FontWeight.bold),
  //           )),*/
  //     ],
  //   );
  // }
  Widget _buildGoogleMap(BuildContext context ,AsyncSnapshot snapshot,index) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:  CameraPosition(target: LatLng(to(snapshot.data['data']['body'][index][2]), to(snapshot.data['data']['body'][index][3])), zoom: 16.0),//37.64871447942806, 127.06436281430499
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers:Set<Marker>.of(_markers),
      ),
    );
  }
  // Future<void> _gotoLocation(double lat,double long) async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, long), zoom: 20,tilt: 50.0,
  //     bearing: 45.0,)));
  // }
  Widget addPartner(BuildContext context,AsyncSnapshot snapshot,index,StyleModel styleModel) {
    if(snapshot.data['data']['body'][index][4]==null){
      return Scaffold(
          appBar: AppBar(
              elevation: 0,
              iconTheme: IconThemeData(
                  color: styleModel.getBackgroundColor()['reversalColorLevel1'],),
              backgroundColor:styleModel.getBackgroundColor()['backgroundColorLevel1'],
              title:Text(snapshot.data['data']['body'][index][0],
                style: styleModel.getTextStyle()['appBarTextStyle'],)),
          body: Column(children: <Widget>[
            Flexible(
              flex: 7,
              child: Stack(
                children: <Widget>[
                  ClipPath(
                    clipper: CustomShape(),
                    child:Container(
                      child: _buildGoogleMap(context,snapshot,index),),),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Center(
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('images/logo.png'),
                              )
                          ),
                        ),),
                    ],),
                ],),),
            Flexible(//images/rocket.png
              flex: 3,
              child: Column(
                children: <Widget>[
                Container(
                  child:Container(
                    child: Text(
                        snapshot.data['data']['body'][index][1],
                      style: TextStyle(color: Colors.black,fontSize: 23,fontWeight: FontWeight.bold),
                  ),
                ),),
              ],
              ),
            ),
            // Container(height: 400,child:Text(snapshot.data['data']['body'][index][1]),),
          ],
          ),
      );
    }
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(
              color: styleModel.getBackgroundColor()['reversalColorLevel1'],),
          backgroundColor:styleModel.getBackgroundColor()['backgroundColorLevel1'],
          title:Text(snapshot.data['data']['body'][index][0],
            style: styleModel.getTextStyle()['appBarTextStyle'],)),
      body: Column(children: <Widget>[
        Flexible(
          flex: 7,
          child: Stack(
          children: <Widget>[
            ClipPath(
            clipper: CustomShape(),
            child:Container(
              child: _buildGoogleMap(context,snapshot,index),),),
            Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
                Center(
                  child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: MemoryImage(base64.decode(snapshot.data['data']['body'][index][4])),
                    )
                ),
              ),),
          ],)
        ],),),
        Flexible(
          flex: 3,
            child:Container(
              // decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/rocket.png'),fit: BoxFit.cover)),
              child: Text(
                  snapshot.data['data']['body'][index][1],
                style: TextStyle(color: Colors.black,fontSize: 23,fontWeight: FontWeight.bold),),
            ),
        ),
        // Container(height: 400,child:Text(snapshot.data['data']['body'][index][1]),),
      ],)
    );
  }
}
class CustomShape extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path =Path();
    double height =size.height;
    double width=size.width;
    path.lineTo(0, height-100);
    path.quadraticBezierTo(width/2, height, width, height-100);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}
class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}
class _CategoriesState extends State<Categories> {
  List<String> categories = ["All","음식점", "여가,스포츠", "의류", "공부"];
  // By default first one is selected
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * (2)),
      child: SizedBox(
        height: SizeConfig.defaultSize * 3.5, // 35
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => buildCategoriItem(index),
        ),
      ),
    );
  }

  Widget buildCategoriItem(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: SizeConfig.defaultSize *(2)),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultSize * (2), //20
          vertical: SizeConfig.defaultSize * 0.5, //5
        ),
        decoration: BoxDecoration(
            color:
            selectedIndex == index ? Color(0xFFEFF3EE) : Colors.transparent,
            borderRadius: BorderRadius.circular(
              SizeConfig.defaultSize * 1.6, // 16
            )),
        child: Text(
          categories[index],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selectedIndex == index ? kPrimaryColor : Color(0xFFC2C2B5),
          ),
        ),
      ),
    );
  }
}