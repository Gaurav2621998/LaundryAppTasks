import 'package:flutter/material.dart';

import 'oderdetailsexpandablecard/expandable.dart';

class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int selectedpaymentmode;

  @override
  void initState() {
    super.initState();
    selectedpaymentmode = 3;
  }

  void setselectpaymentmode(val) {
    setState(() {
      selectedpaymentmode = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 249, 255, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "OrderDetails",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Card(
                        elevation: 3,
                        margin: EdgeInsets.all(6.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Align(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Order No. - 110010717",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        "Wed, 15 June 2019, 11:21 AM",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black45),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                Card1(),
                                Divider(
                                  thickness: 1,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Subtotal",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "₹ 240",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Tax",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black45),
                                          ),
                                          Text(
                                            "₹ 24",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black45),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Total",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "₹ 264",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                    Card(
                      elevation: 3,
                      margin: EdgeInsets.all(6.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          children: <Widget>[
                            RadioListTile(
                              value: 1,
                              groupValue: selectedpaymentmode,
                              title: Text("Pay via PAYPAL"),
                              subtitle: Text("jaingaurav******"),
                              activeColor: Colors.blue,
                              secondary: Image.asset(
                                'assets/images/paypalicon.png',
                              ),
                              onChanged: (val) {
                                setselectpaymentmode(val);
                              },
                            ),
                            RadioListTile(
                              value: 2,
                              groupValue: selectedpaymentmode,
                              title: Text("Visa Debit Card"),
                              onChanged: (val) {
                                setselectpaymentmode(val);
                              },
                              subtitle: Text("jaingaurav******"),
                              activeColor: Colors.blue,
                              secondary: Image.asset(
                                'assets/images/visa_cardicon.png',
                              ),
                            ),
                            RadioListTile(
                              value: 3,
                              groupValue: selectedpaymentmode,
                              title: Text("Cash on Delivery"),
                              activeColor: Colors.blue,
                              secondary: Image.asset(
                                'assets/images/cod_icon.png',
                              ),
                              onChanged: (val) {
                                setselectpaymentmode(val);
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4.0),
              child: Container(
                width: double.infinity,
                child: StreamBuilder(
                    initialData: false,
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
                        disabledColor: Colors.blue,
                        textColor: Colors.white,
                        onPressed: snapshot.data
                            ? () async {
//                                    await addNewAddressDb(name, address, flatNo,
//                                            lastcameraPosition)
//                                        .then((val) {
//                                      removeDialogBox(context);
//                                      newAddressBloc.flatAndName(false);
//                                      Navigator.of(context).pop();
//                                    }).catchError((err) {
//                                      showSnackBar(
//                                          context, "Some Error Occured");
//                                    });
                        }
                            : null,
                      );
                    }),
              ),
            ),

        ]),

    );
  }
}

const loremIpsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

class Card1 extends StatelessWidget {
  Widget _buildItemList() {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(0),
          child: Column(
            children: <Widget>[
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Washup & Fold ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "2 X T-shirt ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                            Text(
                              "₹ 24",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                itemCount: 3, // this is a hardcoded value
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        );
      },
      itemCount: 3, // this is a hardcoded value
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.only(left: 14, right: 14),
      child: Column(
        children: <Widget>[
          ScrollOnExpand(
            scrollOnExpand: true,
            scrollOnCollapse: false,
            child: ExpandablePanel(
              theme: const ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                tapBodyToCollapse: true,
              ),
              header: Padding(
                  padding: EdgeInsets.all(0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Items",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "15",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
              expanded: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(bottom: 0),
                      child: _buildItemList()),
                ],
              ),
              builder: (_, collapsed, expanded) {
                return Padding(
                  padding: EdgeInsets.all(4),
                  child: Expandable(
                    collapsed: collapsed,
                    expanded: expanded,
                    theme: const ExpandableThemeData(crossFadePoint: 0),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
