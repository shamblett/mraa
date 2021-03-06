/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// Generic enumeration helper class
class MraaEnumHelper<T extends dynamic> {
  /// Construction
  MraaEnumHelper(this._valuesMap);

  /// Values map
  final Map<int, T> _valuesMap;

  /// From int
  T fromInt(int index) {
    return _valuesMap[index]!;
  }

  /// As int
  int asInt(T code) {
    if (_valuesMap.containsValue(code)) {
      return _valuesMap.keys.firstWhere((int e) => _valuesMap[e] == code);
    }
    return Mraa.generalError;
  }

  /// As string
  String asString(T name) => name.toString().split('.')[1];
}
