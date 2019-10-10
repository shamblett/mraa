/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

import 'package:mraa/mraa.dart';

int main() {
  final Mraa mraa = Mraa();

  // Set any options such as no JSON loading here
  mraa.noJsonLoading = true;

  // Initialise the package
  mraa.initialise();

  // Call the MRAA API functions
  final String mraaVersion = mraa.common.version();
  print('Version is : $mraaVersion');

  return 0;
}
