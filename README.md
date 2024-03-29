# mraa
[![Build Status](https://github.com/shamblett/mraa/actions/workflows/ci.yml/badge.svg)](https://github.com/shamblett/mraa/actions/workflows/ci.yml)
An implementation of the [Intel MRAA linux library](https://iotdk.intel.com/docs/master/mraa/index.html) for Dart.

This is a full implementation of MRAA allowing low level access to sensor devices 
on a range of supported linux based boards and development environments. This
permits low level IOT device control and management directly from the Dart VM.

The implementation is an FFI wrapper around the target boards libmraa library, which can be set
to the distro standard libmraa or any libmraa you wish to use yourself.
Currently Version 2.0.0 of MRAA is supported.

The API itself is a complete implementation(see UNIMPLEMENTED.md for the few
functions not implemented) and is structured as per the MRAA C API, e.g 
to access an analogue IO pin a call like this would be used :-

```
mraa.aio.read(0);
```
Other API functions for GPIO, I2C etc are accessed in a similar manner.

The examples directory contains some general usage examples. Examples of using mrra with
real sensors can be found in the [grove](https://pub.dev/packages/grove) package. 

Note that to access some devices, GPIO is an example here, you may need
elevated permissions, this can be achieved by running Dart under sudo, running
as root or adding your user to the appropriate device group. 

