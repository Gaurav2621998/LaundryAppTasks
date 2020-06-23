

import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

final newAddressBloc = NewAddress();

class NewAddress extends BaseBloc {
  var _newAddress = BehaviorSubject<String>();
  var _flatAndName = BehaviorSubject<bool>();

  get newAddressFromCoordinate => _newAddress.sink.add;

  Stream<String> get getAddressFromCoordinate => _newAddress.stream;

  get flatAndName => _flatAndName.sink.add;

  Stream<bool> get hasFlatAndName => _flatAndName.stream;

  @override
  dispose() {
    _newAddress?.close();
    _flatAndName?.close();
  }
}
