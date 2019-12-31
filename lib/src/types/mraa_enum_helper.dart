/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

// ignore_for_file: omit_local_variable_types
// ignore_for_file: unnecessary_final
// ignore_for_file: cascade_invocations

/// Generic enumeration helper class
class MraaEnumHelper<T extends dynamic> {
  /// Construction
  MraaEnumHelper(this._valuesMap);

  /// Values map
  final Map<int, T> _valuesMap;

  /// From int
  T fromInt(int index) {
    if (_valuesMap.containsKey(index)) {
      return _valuesMap[index];
    }
    return null;
  }

  /// As int
  int asInt(T code) {
    if (_valuesMap.containsValue(code)) {
      // ignore: avoid_types_on_closure_parameters
      return _valuesMap.keys.firstWhere((int e) => _valuesMap[e] == code);
    }
    return Mraa.generalError;
  }

  /// As string
  String asString(T name) => name.toString().split('.')[1];
}
