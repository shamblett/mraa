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
  MraaEnumHelper(this._values);

  /// Values function
  dynamic _values;

  /// From int
  T fromInt(int index) {
    for (T code in _values()) {
      if (index == code.index) {
        return code;
      }
    }
    return null;
  }

  /// As int
  int asInt(T code) => code.index;

  /// As string
  String asString(T name) => name.toString().split('.')[1];
}
