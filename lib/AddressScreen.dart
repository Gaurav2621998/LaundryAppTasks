
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/add_new_address_page.dart';
import 'models/address_model.dart';

class Addressscreen extends StatefulWidget {
  @override
  _AddressscreenState createState() => _AddressscreenState();
}

class _AddressscreenState extends State<Addressscreen> {


  String addressRadiogroup="addressradiogroup";
  String addressRadiogroupvalue="";
  int _radioValue = 0;
  void _addressRadiogroupvaluechanges(String value){
    setState(() {
      addressRadiogroupvalue=value;
    });
  }


  List<AddressModel> addressList = List<AddressModel>();
  
  @override
  Widget build(BuildContext context) {

var r=new Random();
      addressList.add(AddressModel(
        id: r.nextInt(1000),
        addresstype: "Home",
        fulladdress: "11 Neminath Jain Colony ",
        area: "Hiran Magri",
        contactno: "9625252525",
        lat: 53.0.toString(),
        long: 75.3.toString()
      ));
    return Scaffold(
      appBar: AppBar(
        title: Text("Address Screen"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed:(){
            Navigator.pop(context);
          }
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Where shoud we deliver?",style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10),
              child: FutureBuilder<List<AddressModel>>(
                  future: getaddresslist(),
                  builder: (context, snap) {
                    if (snap.hasData) {
                      if (snap.data.length > 0) {
                        return getListAddress(context, snap);
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Currently no address is stored.\n Add a new Address",
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    return CircularProgressIndicator();
                  }),
            ),
//            Divider(
//              height: 1,
//              color: Colors.grey,
//            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: Card(
                elevation: 5,
                margin: EdgeInsets.all(6.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),

                ),
                child: ListTile(
                  leading: Icon(
                    Icons.add,
                    color: Colors.blue,
                  ),
                  title: Text(
                    "Add a new address",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Add_address(context);
                  },
                ),
              ),
            ),

//            new Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                new Radio(
//                  value: 0,
//                  groupValue: _radioValue,
//                  onChanged: _handleRadioValueChange,
//                ),
//                new Text('Euro'),
//                new Radio(
//                  value: 1,
//                  groupValue: _radioValue,
//                 onChanged: _handleRadioValueChange,
//                ),
//                new Text('Pound'),
//                new Radio(
//                  value: 2,
//                  groupValue: _radioValue,
//                  onChanged: _handleRadioValueChange,
//                ),
//                new Text('Yen'),
//              ],
//            ),






          ],
        ),
      ),
    );

  }
  
  Future<List<AddressModel>> getaddresslist(){
    
    return Future.value(addressList);

  } 

  var addresslistgroupvalue=0;

  void selectAddress(value){
      setState(() {
        addresslistgroupvalue=value;
      });
  }

  getListAddress(
      BuildContext context, AsyncSnapshot<List<AddressModel>> snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
//        separatorBuilder: (context, index) {
//          return Divider();
//        },
        shrinkWrap: true,
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.all(6.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),

            ),
            child: RadioListTile(
              value: index, 
              groupValue: addresslistgroupvalue, 
              title: Text("${snapshot.data[index].addresstype}"),
              subtitle: Text(
                 "${snapshot.data[index].fulladdress}\n${snapshot.data[index].area}\n${snapshot.data[index].contactno}",
               ),
              isThreeLine: true,
              secondary: GestureDetector(
                child: Icon(Icons.more_vert),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text("Sure want to delete this address"),
                          actions: <Widget>[
                            FlatButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.pop(context);
                                 
                                }),
                            FlatButton(
                              child: Text("Delete"),
                              onPressed: () {
                                 Navigator.pop(context);
                          
                              },
                            )
                          ],
                        );
                      });
                },

              ),
              onChanged: (val){
                  selectAddress(val);
              }
              ),

//             child: ListTile(
//               title: Text(
//                 "${snapshot.data[index].name}",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               isThreeLine: true,
//               subtitle: Text(
//                 "${snapshot.data[index].flatNo}\n${snapshot.data[index].address}",
//               ),
//               trailing: GestureDetector(
//                 child: Icon(Icons.more_vert),
//                 onTap: () {
//                   showDialog(
//                       context: context,
//                       builder: (context) {
//                         return AlertDialog(
//                           content: Text("Sure want to delete this address"),
//                           actions: <Widget>[
//                             FlatButton(
//                                 child: Text('Cancel'),
//                                 onPressed: () {
//                                   Navigator.pop(context);
                                 
//                                 }),
//                             FlatButton(
//                               child: Text("Delete"),
//                               onPressed: () {
//                                  Navigator.pop(context);
//                              //   removeDialogBox(context);
// //                              showDialogBox("Deleting Your Address", context,
// //                                  isCancelable: false);
// //                              await deleteAddress(snapshot.data[index]);
// //                              removeDialogBox(context);
//                                // setState(() {});
//                               },
//                             )
//                           ],
//                         );
//                       });
//                 },
//               ),
              
//             ),
          );
        },
      );
    }
    return Container(
        height: 200, child: Center(child: CircularProgressIndicator()));
  }


  var dropdownvalue="Hiran Magri";
  void Add_address(context){
    
    showModalBottomSheet(context: context, builder:(BuildContext bc)
    {
      
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: true
                    ? BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                )
                    : null,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10.0,
                    spreadRadius: 10,
                    color: Colors.blueGrey[900].withOpacity(0.2),
                  )
                ],
              ),
              child:Column(

                  children:[
                    Container(
                            decoration: BoxDecoration(
                              color:Color.fromRGBO(242, 242, 242,1),
                              borderRadius: true
                    ? BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ): null,
                              
                            ),
                            child: Padding(
                              padding:const EdgeInsets.only(top:18,left:18,bottom: 18),                            
                              child: Align(
                              alignment: Alignment.centerLeft, 
                                                   
                              child: Text("Add Address",
                              textAlign: TextAlign.left,
                              style:TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                              )),
                          ),
                            ),
                    ),
                  Container(
                    decoration: BoxDecoration(
              
                      borderRadius: true
                    
                    ? BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ): null,
                    ),
                                      child: Padding(
                    padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                      
                      child: Column(
        
                        children: <Widget>[
                          SizedBox(height: 10),
                        
                          Align(
                            alignment: Alignment.centerLeft,                      
                            child: Text("Select Area",
                            textAlign: TextAlign.left,
                            style:TextStyle(
                              color:Color.fromRGBO(166,166, 166,1),
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            )),
                          ),

                          new DropdownButton<String>(
                            isExpanded: true,
                            dropdownColor: Colors.white,
                            value:dropdownvalue ,
                            items: <String>['Hiran Magri', 'SurajPole', 'Savena', 'UdiyaPole'].map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (String newvalue) {
                              setState((){
                                dropdownvalue=newvalue;
                              });
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                            alignment: Alignment.centerLeft,                      
                            child: Text("Complete Address",
                            textAlign: TextAlign.left,
                            style:TextStyle(
                              color:Color.fromRGBO(166,166, 166,1),
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            )),
                          ),

                                                
                            GestureDetector(
                              onTap: (){
                                      Navigator.push(context,MaterialPageRoute(builder: (context)=>AddNewAddress()) );

                              },                            
                              child: Text("Pin your location",
                              textAlign: TextAlign.left,
                              
                              style:TextStyle(
                                color:Colors.blue,
                                fontSize: 16
                              )),
                            ),
                          


                          ],),

                            TextField(
                            
                              onChanged: (val) {
                                val = val.trim();
//                    if (name != null && val != "" && name != "") {
//                      newAddressBloc.flatAndName(true);
//                    }
//                    if (val == "") {
//                      newAddressBloc.flatAndName(false);
//                    }
//                    flatNo = val;
                              },
                            ),
                          
                          SizedBox(
                            height: 10,
                         ),
                          Align(
                            alignment: Alignment.centerLeft,                      
                            child: Text("Contact No.",
                            textAlign: TextAlign.left,
                            style:TextStyle(
                              color:Color.fromRGBO(166,166, 166,1),
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            )),
                          ),
                          TextField(
                    
                            onChanged: (val) {
                              val = val.trim();
//
//                    if (flatNo != null && val != "" && flatNo != "") {
//                      newAddressBloc.flatAndName(true);
//                    }
//                    if (val == "") {
//                      newAddressBloc.flatAndName(false);
//                    }
//                    name = val;
                            },
                          ),
                         SizedBox(
                            height: 4,
                         ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Radio(
                                value: 0,
                                groupValue: _radioValue,
                                onChanged: _handleRadioValueChange,
                              ),
                              new Text(
                                'Home',
                                style: new TextStyle(fontSize: 16.0),
                              ),
                              new Radio(
                                value: 1,
                                groupValue: _radioValue,
                                onChanged: (value){
                                  _radioValue=value;
                                },
                              ),
                              new Text(
                                'Work',
                                style: new TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              new Radio(
                                value: 2,
                                groupValue: _radioValue,
                                onChanged: _handleRadioValueChange,
                              ),
                              new Text(
                                'Other',
                                style: new TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),

                         SizedBox(
                            height: 10,
                         ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                            child: Container(
                              width: double.infinity,
                              child: StreamBuilder(
                                  initialData: false,
                                  //stream: newAddressBloc.hasFlatAndName,
                                  builder: (context, snapshot) {
                                    return FlatButton(
                                      color: Colors.blue,
                                      child: Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Text(
                                          "Save & Continue  ➜",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                      disabledTextColor: Colors.white,
                                      disabledColor: Colors.grey,
                                      textColor: Colors.white,
                                      onPressed: () async {
                                          Navigator.pop(context);
                                      //  Navigator.push(context,MaterialPageRoute(builder: (context)=>AddNewAddress()) );

                                      }
                                    );
                                  }),
                            ),
                          ),


                        ],
                      ),
                    ),
                ),
                  )
                              ]
              ),
            );
          }
      );
    }
    );

  }



  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue=value;
    });
  }
}





