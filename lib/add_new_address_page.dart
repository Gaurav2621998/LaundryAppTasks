
import 'package:flutter/material.dart';
import 'package:flutterapp/AddressScreen.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'add_new_address.dart';
import 'addresscard/expandablecard.dart';
import 'addresscard/expandablecardpage.dart';
import 'common_widget.dart';

class AddNewAddress extends StatefulWidget {
  @override
  _AddNewAddressState createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  CameraPosition lastcameraPosition;
  String name, flatNo, address;


  String _mapStyle='assets/mapStyle.json';



  @override
  Future didChangeDependencies() async {
    super.didChangeDependencies();
    var location = await Geolocator().getCurrentPosition();

    var address = await Geocoder.local.findAddressesFromCoordinates(
        Coordinates(location.latitude, location.longitude));
    lastcameraPosition =
        CameraPosition(target: LatLng(location.latitude, location.longitude));
    print(address.first.addressLine);
   // newAddressBloc.newAddressFromCoordinate(address?.first?.addressLine);
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Add Address"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
       resizeToAvoidBottomPadding: false,
        body: ExpandableCardPage(
          page:_page() ,
          expandableCard: ExpandableCard(
            backgroundColor: Colors.white,
            padding: EdgeInsets.only(top: 0, left: 20, right: 20),
            maxHeight: 500,
            // maxHeight: MediaQuery.of(context).size.height - 100,
            minHeight: 250,
            hasRoundedCorners: true,
            hasShadow: true,
            children: <Widget>[
                _buildBottomSheet()
            ],
          ),
        ),

    );
  }


  Widget gettextfield(){
    return TextField(
      minLines: 2,
      maxLines: 2,
      decoration: InputDecoration(
        labelText: "Your Location"
      ),

    );
  }

  Widget _page() => slidinguppanel();


  Widget slidinguppanel(){
    return SlidingUpPanel(
      body: FutureBuilder<Position>(
          future: getCurrentLocation(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: <Widget>[
                  GoogleMap(
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                      zoom: 15,
                      target: LatLng(
                          snapshot.data.latitude, snapshot.data.longitude),
                    ),
                    onCameraMove: (CameraPosition postion) {
                      lastcameraPosition = postion;
                    },

                    onMapCreated: (GoogleMapController controller) {
                      //controller.setMapStyle(_mapStyle);

                    },
                    mapType: MapType.normal,
                    onCameraIdle: () async {
                      var address = await Geocoder.local
                          .findAddressesFromCoordinates(Coordinates(
                          lastcameraPosition?.target?.latitude,
                          lastcameraPosition?.target?.longitude));

                      newAddressBloc.newAddressFromCoordinate(
                          address.first.addressLine);
                    },
                  ),
                  pin(),
//                      Center(
//                        child: Image.asset(
//                          "assets/images/marker.png",
//                          scale: 15,
//                        ),
//                      ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      minHeight: 100,
      maxHeight: 300,
    );
  }

  Widget pin() {
    return IgnorePointer(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.place, size: 56),
            Container(
              decoration: ShapeDecoration(
                shadows: [
                  BoxShadow(
                    blurRadius: 4,
                    color: Colors.black38,
                  ),
                ],
                shape: CircleBorder(
                  side: BorderSide(
                    width: 4,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            SizedBox(height: 56),
          ],
        ),
      ),
    );
  }

  Widget buildcard() {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: ExpandableCardPage(
        page:_page() ,
        expandableCard: ExpandableCard(

          backgroundColor: Colors.white,
          padding: EdgeInsets.only(top: 5, left: 20, right: 20),
          maxHeight: 400,
          // maxHeight: MediaQuery.of(context).size.height - 100,
          minHeight: 150,
          hasRoundedCorners: true,
          hasShadow: true,
          children: <Widget>[
            SizedBox(height: 10),
            _buildBottomSheet(),
        ]
        ),
      ),
    );
  }



  Widget _buildBottomSheet() {
    return StreamBuilder<String>(
        stream: newAddressBloc.getAddressFromCoordinate,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            address = snapshot.data;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left:16,top:4,bottom:4,right: 4),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextField(
                          minLines: 2,
                          maxLines: 2,
                          controller:
                              TextEditingController(text: "${snapshot.data}"),
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: "Your Location",

                          ),
                          style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:10,left:20),
                          child: Column(
                              children: [

                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                
                                  children: [
                                       Image.asset(
                                    'assets/images/location_icon.png',
                                    width: 30,
                                    height: 30,
                                    
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(labelText: "LandMark"),
                                  onChanged: (val) {
                                    val = val.trim();

                                    if (flatNo != null && val != "" && flatNo != "") {
                                      newAddressBloc.flatAndName(true);
                                    }
                                    if (val == "") {
                                      newAddressBloc.flatAndName(false);
                                    }
                                    name = val;
                                  },
                                )
                                    ),
                                  ],),

                                  Row(
                                  mainAxisSize: MainAxisSize.min,
                                
                                  children: [
                                       Image.asset(
                                    'assets/images/location_icon.png',
                                    width: 30,
                                    height: 30,
                                    
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(labelText: "City"),
                                  onChanged: (val) {
                                    val = val.trim();

                                    if (flatNo != null && val != "" && flatNo != "") {
                                      newAddressBloc.flatAndName(true);
                                    }
                                    if (val == "") {
                                      newAddressBloc.flatAndName(false);
                                    }
                                    name = val;
                                  },
                                )
                                    ),
                                  ],),

                              
                              
                        
                              ],
                          ),
                          )
                        
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                )
                ,
                Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Container(
                    width: double.infinity,
                    child: StreamBuilder(
                        initialData: false,
                        stream: newAddressBloc.hasFlatAndName,
                        builder: (context, snapshot) {
                          return FlatButton(
                            color: Colors.blue,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Text(
                                "Continue  ➜",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                            disabledTextColor: Colors.white,
                            disabledColor: Colors.grey,
                            textColor: Colors.white,
                            onPressed: snapshot.data
                                ? () async {

                                  //  await addNewAddressDb(name, address, flatNo,
                                  //          lastcameraPosition)
                                  //      .then((val) {
                                  //    removeDialogBox(context);
                                  //    newAddressBloc.flatAndName(false);
                                  //    Navigator.of(context).pop();
                                  //  }).catchError((err) {
                                  //    showSnackBar(
                                  //        context, "Some Error Occured");
                                  //  });
                                  }
                                : null,
                          );
                        }),
                  ),
                ),



              ],
            );
          }
          return Column(
            children: <Widget>[
              SizedBox(
                  height: 3,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.black,
                  )),
            ],
          );
        }
        );
  }

  getCurrentLocation() {
    return Geolocator().getCurrentPosition();
  }
}
