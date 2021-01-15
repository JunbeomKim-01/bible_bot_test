import 'dart:async';
import 'package:bible_bot/models/style_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';


class Map extends StatefulWidget {
  @override
  MapState createState() => MapState();
}

class MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }
  double zoomVal=10.0;
  @override

  Widget build(BuildContext context) {
    StyleModel styleModel=Provider.of<StyleModel>(context);
    return Scaffold(
      backgroundColor: styleModel.getBackgroundColor()['backgroundColorLevel1'],
      appBar: AppBar(
        elevation: 1,
        iconTheme: IconThemeData(
            color: styleModel.getBackgroundColor()['reversalColorLevel1']),
        backgroundColor:
        styleModel.getBackgroundColor()['backgroundColorLevel1'],
        title: Text(
          '제휴업체 ',
          style: styleModel.getTextStyle()['appBarTextStyle'],
        ),
      ),
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          _zoomminusfunction(),
          _zoomplusfunction(),
          _buildContainer(),
        ],
      ),
    );
  }
  Widget _zoomminusfunction() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
          icon: Icon(Icons.expand_more,color:Color(0xff6200ee)),
          onPressed: () {
            zoomVal--;
            _minus( zoomVal);
          }),
    );
  }
  Widget _zoomplusfunction() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          icon: Icon(Icons.expand_less,color:Color(0xff6200ee)),
          onPressed: () {
            zoomVal++;
            _plus(zoomVal);
          }),
    );
  }
  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(37.64871447942806, 127.06436281430499), zoom: zoomVal)));
  }
  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(37.64871447942806, 127.06436281430499), zoom: zoomVal)));
  }


  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                 'https://www.google.com/maps/uv?pb=!1s0x357cb9148acb7fd5%3A0xea76e490fd385a5d!3m1!7e115!4shttps%3A%2F%2Flh5.googleusercontent.com%2Fp%2FAF1QipMbzhhR2iyak0-PdnwcL8cKavMqEUvGRi7-_Gba%3Dw260-h175-n-k-no!5z64W47JuQIOunm-ynkSAtIEdvb2dsZSDqsoDsg4k!15sCgIgAQ&imagekey=!1e10!2sAF1QipMbzhhR2iyak0-PdnwcL8cKavMqEUvGRi7-_Gba&hl=ko#', 37.656604494993715, 127.06553379897117,"노원목고기집"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://www.google.com/maps/uv?pb=!1s0x357cb9154d29b099:0x8c2cc43dcb8e9b98!3m1!7e115!4shttps://lh5.googleusercontent.com/p/AF1QipNgv-CT7rfkEqjv3ziSRKJIYCggeSESUL5Asgw%3Dw260-h175-n-k-no!5z64W47JuQIOunm-ynkSAtIEdvb2dsZSDqsoDsg4k!15zQ2dJZ0FRPT0&imagekey=!1e10!2sAF1QipNgv-CT7rfkEqjv3ziSRKJIYCggeSESUL5Asgw&hl=ko",
                  37.956604494993715, 128.06553379897117,"시골애"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://www.google.com/maps/uv?pb=!1s0x357cb9148acc7fb3:0x9e3890a3e563933a!3m1!7e115!4shttps://lh5.googleusercontent.com/p/AF1QipPt7DtXf00DJiqqsTEqPlJjYjISIn49L1-Bub4o%3Dw260-h175-n-k-no!5z64W47JuQIOunm-ynkSAtIEdvb2dsZSDqsoDsg4k!15zQ2dJZ0FRPT0&imagekey=!1e10!2sAF1QipPt7DtXf00DJiqqsTEqPlJjYjISIn49L1-Bub4o&hl=ko",
                  38.656604494993715, 129.06553379897117,"명동찌개마을"),
            ),
            SizedBox(width: 10.0),
            Padding(padding: const EdgeInsets.all(8.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat,double long,String restaurantName) {
    return  GestureDetector(
      onTap: () {
        _gotoLocation(lat,long);
      },
      child:Container(
        child: new FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0x802196F3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 180,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(_image),
                      ),
                    ),),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myDetailsContainer1(restaurantName),
                    ),
                  ),
                ],),
          ),
        ),
      ),
    );
  }

  Widget myDetailsContainer1(String restaurantName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(restaurantName,
                style: TextStyle(
                    color: Color(0xff6200ee),
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              )),
        ),
        SizedBox(height:5.0),
        Container(
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
            )),
      ],
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:  CameraPosition(target: LatLng(37.64871447942806, 127.06436281430499), zoom: 16.2),//37.64871447942806, 127.06436281430499
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          KBUMarker,MokGOGIMarker,SIGOLMarker,
        },
      ),
    );
  }
  Future<void> _gotoLocation(double lat,double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, long), zoom: 15,tilt: 50.0,
      bearing: 45.0,)));
  }
}

Marker KBUMarker=Marker(
  markerId: MarkerId('한국성서대'),
  position: LatLng(37.64871447942806,127.06436281430499),
  infoWindow: InfoWindow(title:'한국성서대'),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
);
Marker MokGOGIMarker = Marker(
  markerId: MarkerId('노원목고기집'),
  position: LatLng(37.656604494993715, 127.06553379897117),
  infoWindow: InfoWindow(title: '노원목고기집'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker SIGOLMarker = Marker(
  markerId: MarkerId('시골애'),
  position: LatLng(37.656604494993715, 127.08553379897117),
  infoWindow: InfoWindow(title: '시골애'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker MUENMarker = Marker(
  markerId: MarkerId('명동찌개마을'),
  position: LatLng(37.356604494993715, 127.16553379897117),
  infoWindow: InfoWindow(title: '명동찌개마을'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

//노원 Marker

Marker noone1Marker = Marker(
  markerId: MarkerId('아무 맛집'),
  position: LatLng(39.656604494993715, 127.06553379897117),
  infoWindow: InfoWindow(title: '아무 맛집'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker noone2Marker = Marker(
  markerId: MarkerId('맛집이여'),
  position: LatLng(40.656604494993715, 128.06553379897117),
  infoWindow: InfoWindow(title: '맛집이여'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker noone3Marker = Marker(
  markerId: MarkerId('맛있어요'),
  position: LatLng(35.656604494993715, 123.06553379897117),
  infoWindow: InfoWindow(title: '맛있어요'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);