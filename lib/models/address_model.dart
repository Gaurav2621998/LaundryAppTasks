class AddressModel {
  int id;
  String addresstype;
  String fulladdress;
  String area;
  String contactno;
  String lat;
  String long;

  AddressModel({this.id,this.addresstype, this.fulladdress, this.area,this.contactno,this.lat,this.long});

  Map<String, dynamic> toJson() => {
        'id' : id,
        'addresstype': addresstype,
        'fulladdress': fulladdress,
        'area': area,
        'contactno':contactno,
        'lat': lat,
        'long': long,
      };
  AddressModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        addresstype = json['addresstype'],
        fulladdress = json['fulladdress'],
        area = json['area'],
        contactno = json['contactno'],
        lat = json['lat'],
        long = json['long'];
}
