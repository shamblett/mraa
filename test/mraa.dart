/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

import 'package:mraa/mraa.dart';

int main() {
  final Mraa mraa = Mraa();
  final String mraaVersion = mraa.version();
  print(mraaVersion);

  return 0;
}
