/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// C Function type typedefs
typedef _returnMraaSpiContextIntParameterFunc = Pointer<MraaSpiContext>
    Function(Int32);
typedef _returnMraaSpiContextIntIntParameterFunc = Pointer<MraaSpiContext>
    Function(Int32, Int32);
typedef _returnIntMraaSpiContextIntParameterFunc = Int32 Function(
    Pointer<MraaSpiContext>, Int32);
typedef _returnIntMraaSpiContextUint8ParameterFunc = Int32 Function(
    Pointer<MraaSpiContext>, Uint8);
typedef _returnIntMraaSpiContextUint16ParameterFunc = Int32 Function(
    Pointer<MraaSpiContext>, Uint16);
typedef _returnPtrUint8MraaSpiContextPtrUint8IntParameterFunc = Pointer<Uint8>
    Function(Pointer<MraaSpiContext>, Pointer<Uint8>, Int32);
typedef _returnPtrUint16MraaSpiContextPtrUint16IntParameterFunc
    = Pointer<Uint16> Function(Pointer<MraaSpiContext>, Pointer<Uint16>, Int32);
typedef _returnIntMraaSpiContextPtrUint8PtrUint8PtrIntParameterFunc = Int32
    Function(Pointer<MraaSpiContext>, Pointer<Uint8>, Pointer<Uint8>, Int32);
typedef _returnIntMraaSpiContextPtrUint16PtrUint16PtrIntParameterFunc = Int32
    Function(Pointer<MraaSpiContext>, Pointer<Uint16>, Pointer<Uint16>, Uint32);
typedef _returnIntMraaSpiContextParameterFunc = Int32 Function(
    Pointer<MraaSpiContext>);

/// Dart Function typedefs
typedef _MraaSpiInitialiseType = Pointer<MraaSpiContext> Function(int);
typedef _MraaSpiInitialiseRawType = Pointer<MraaSpiContext> Function(int, int);
typedef _MraaSpiModeType = int Function(Pointer<MraaSpiContext>, int);
typedef _MraaSpiFrequencyType = int Function(Pointer<MraaSpiContext>, int);
typedef _MraaSpiWriteType = int Function(Pointer<MraaSpiContext>, int);
typedef _MraaSpiWriteWordType = int Function(Pointer<MraaSpiContext>, int);
typedef _MraaSpiWriteBufferType = Pointer<Uint8> Function(
    Pointer<MraaSpiContext>, Pointer<Uint8>, int);
typedef _MraaSpiWriteBufferWordType = Pointer<Uint16> Function(
    Pointer<MraaSpiContext>, Pointer<Uint16>, int);
typedef _MraaSpiTransferBufferType = int Function(
    Pointer<MraaSpiContext>, Pointer<Uint8>, Pointer<Uint8>, int);
typedef _MraaSpiTransferBufferWordType = int Function(
    Pointer<MraaSpiContext>, Pointer<Uint16>, Pointer<Uint16>, int);
typedef _MraaSpiLsbModeType = int Function(Pointer<MraaSpiContext>, int);
typedef _MraaSpiBitsPerWordType = int Function(Pointer<MraaSpiContext>, int);
typedef _MraaSpiStopType = int Function(Pointer<MraaSpiContext>);

/// The SPI MRAA API
///
/// An SPI object in MRAA represents a spidev device. Linux spidev devices
/// are created per SPI bus and every chip select available on that
/// bus has another spidev 'file'.
class MraaSpi {
  /// Construction
  MraaSpi(this._lib, this._noJsonLoading) {
    _setUpPointers();
    _setUpFunctions();
  }

  /// The MRAA library
  final DynamicLibrary _lib;

  // ignore: unused_field
  final bool _noJsonLoading;

  /// C Pointers
  Pointer<NativeFunction<_returnMraaSpiContextIntParameterFunc>> _initPointer;
  Pointer<NativeFunction<_returnMraaSpiContextIntIntParameterFunc>>
      _initRawPointer;
  Pointer<NativeFunction<_returnIntMraaSpiContextIntParameterFunc>>
      _modePointer;
  Pointer<NativeFunction<_returnIntMraaSpiContextIntParameterFunc>>
      _frequencyPointer;
  Pointer<NativeFunction<_returnIntMraaSpiContextUint8ParameterFunc>>
      _writePointer;
  Pointer<NativeFunction<_returnIntMraaSpiContextUint16ParameterFunc>>
      _writeWordPointer;
  Pointer<NativeFunction<_returnPtrUint8MraaSpiContextPtrUint8IntParameterFunc>>
      _writeBufferPointer;
  Pointer<
          NativeFunction<
              _returnPtrUint16MraaSpiContextPtrUint16IntParameterFunc>>
      _writeBufferWordPointer;
  Pointer<
          NativeFunction<
              _returnIntMraaSpiContextPtrUint8PtrUint8PtrIntParameterFunc>>
      _transferBufferPointer;
  Pointer<
          NativeFunction<
              _returnIntMraaSpiContextPtrUint16PtrUint16PtrIntParameterFunc>>
      _transferBufferWordPointer;
  Pointer<NativeFunction<_returnIntMraaSpiContextIntParameterFunc>>
      _lsbModePointer;
  Pointer<NativeFunction<_returnIntMraaSpiContextIntParameterFunc>>
      _bitsPerWordPointer;
  Pointer<NativeFunction<_returnIntMraaSpiContextParameterFunc>> _stopPointer;

  /// Dart Functions
  _MraaSpiInitialiseType _initFunc;
  _MraaSpiInitialiseRawType _initRawFunc;
  _MraaSpiModeType _modeFunc;
  _MraaSpiFrequencyType _frequencyFunc;
  _MraaSpiWriteType _writeFunc;
  _MraaSpiWriteWordType _writeWordFunc;
  _MraaSpiWriteBufferType _writeBufferFunc;
  _MraaSpiWriteBufferWordType _writeBufferWordFunc;
  _MraaSpiTransferBufferType _transferBufferFunc;
  _MraaSpiTransferBufferWordType _transferBufferWordFunc;
  _MraaSpiLsbModeType _lsbModeFunc;
  _MraaSpiBitsPerWordType _bitsPerWordFunc;
  _MraaSpiStopType _stopFunc;

  /// Initialise - mraa_spi_init
  ///
  /// Initialise an [MraaSpiContext], uses board mapping. Sets the muxes
  Pointer<MraaSpiContext> initialise(int busId) => _initFunc(busId);

  /// Initialise raw- mraa_spi_init_raw
  ///
  /// Initialise an [MraaSpiContext] without any board configuration,
  /// selects a bus and a mux.
  Pointer<MraaSpiContext> initialiseRaw(int busId, int cs) =>
      _initRawFunc(busId, cs);

  /// Mode - mraa_spi_mode
  ///
  /// Set the SPI device mode. see spidev 0-3.
  MraaReturnCode mode(Pointer<MraaSpiContext> dev, MraaSpiMode mode) =>
      returnCode.fromInt(_modeFunc(dev, spiMode.asInt(mode)));

  /// Frequency - mraa_spi_frequency
  ///
  /// Set the SPI device operating clock frequency in Hz
  MraaReturnCode frequency(Pointer<MraaSpiContext> dev, int hz) =>
      returnCode.fromInt(_frequencyFunc(dev, hz));

  /// Write - mraa_spi_write
  ///
  /// Write Single Byte to the SPI device.
  /// Returns data received on the miso line or [Mraa.generalError]
  /// in case of error.
  int write(Pointer<MraaSpiContext> dev, int data) => _writeFunc(dev, data);

  /// Write word - mraa_spi_write_word
  ///
  /// Write Two Bytes to the SPI device.
  /// Returns data received on the miso line or [Mraa.generalError]
  /// in case of error.
  int writeWord(Pointer<MraaSpiContext> dev, int data) =>
      _writeWordFunc(dev, data);

  /// Write buffer - mraa_spi-write_buf
  ///
  /// Write Buffer of bytes to the SPI device.
  /// Returns NULL if an error occurs.
  /// Maximum length is 4096
  Uint8List writeBuffer(
      Pointer<MraaSpiContext> dev, Uint8List data, int length) {
    final ptr = ffi.allocate<Uint8>(count: length);
    final ptrData = ptr.asTypedList(length);
    ptrData.setAll(0, data);
    final retData = _writeBufferFunc(dev, ptr, length);
    if (retData == nullptr) {
      return null;
    }
    final retDataList = retData.asTypedList(length);
    final ret = Uint8List(length);
    ret.setAll(0, retDataList);
    ffi.free(retData);
    return ret;
  }

  /// Write buffer word - mraa_spi-write_buf_word
  ///
  /// Write a buffer of words to the SPI device.
  /// Returns NULL if an error occurs.
  /// Maximum length is 4096
  Uint16List writeBufferWord(
      Pointer<MraaSpiContext> dev, Uint16List data, int length) {
    final ptr = ffi.allocate<Uint16>(count: length);
    final ptrData = ptr.asTypedList(length);
    ptrData.setAll(0, data);
    final retData = _writeBufferWordFunc(dev, ptr, length);
    if (retData == nullptr) {
      return null;
    }
    final retDataList = retData.asTypedList(length);
    final ret = Uint16List(length);
    ret.setAll(0, retDataList);
    ffi.free(retData);
    return ret;
  }

  /// Transfer buffer - mraa_spi_transfer_buf
  ///
  /// Transfer a buffer of bytes to the SPI device. Both send and receive
  /// buffers are passed in using the [buffer] parameter.
  /// Maximum length 4096 both ways
  MraaReturnCode transferBuffer(Pointer<MraaSpiContext> dev,
      MraaSpiTransferBuffer<Uint8List> buffer, int length) {
    final ptr = ffi.allocate<Uint8>(count: length);
    final ptrData = ptr.asTypedList(length);
    ptrData.setAll(0, buffer.dataSent);
    final retData = ffi.allocate<Uint8>(count: length);
    final status =
        returnCode.fromInt(_transferBufferFunc(dev, ptr, retData, length));
    if (status != MraaReturnCode.success) {
      return status;
    }
    if (retData == nullptr) {
      buffer.dataReceived = null;
      return status;
    }
    final retDataList = retData.asTypedList(length);
    buffer.dataReceived = Uint8List(length);
    buffer.dataReceived.setAll(0, retDataList);
    ffi.free(retData);
    return status;
  }

  /// Transfer buffer word - mraa_spi_transfer_buf_word
  ///
  /// Transfer a buffer of words to the SPI device. Both send and receive
  /// buffers are passed in using the [buffer] parameter.
  /// Maximum length 4096 both ways
  MraaReturnCode transferBufferWord(Pointer<MraaSpiContext> dev,
      MraaSpiTransferBuffer<Uint16List> buffer, int length) {
    final ptr = ffi.allocate<Uint16>(count: length);
    final ptrData = ptr.asTypedList(length);
    ptrData.setAll(0, buffer.dataSent);
    final retData = ffi.allocate<Uint16>(count: length);
    final status =
        returnCode.fromInt(_transferBufferWordFunc(dev, ptr, retData, length));
    final retDataList = retData.asTypedList(length);
    if (status != MraaReturnCode.success) {
      return status;
    }
    if (retData == nullptr) {
      buffer.dataReceived = null;
      return status;
    }
    buffer.dataReceived = Uint16List(length);
    buffer.dataReceived.setAll(0, retDataList);
    ffi.free(retData);
    return status;
  }

  /// Lsb mode - mraa_spi_lsbmode
  ///
  /// Change the SPI LSB mode
  /// [lsb] set to true indicates use the least significant bit transmission
  MraaReturnCode lsbMode(Pointer<MraaSpiContext> dev, bool lsb) {
    final mode = lsb ? 1 : 0;
    return returnCode.fromInt(_lsbModeFunc(dev, mode));
  }

  /// Bits per word - mraa_spi_bit_per-word
  ///
  /// Set bits per word for transactions, defaults at 8
  MraaReturnCode bitsPerWord(Pointer<MraaSpiContext> dev, int bits) =>
      returnCode.fromInt(_bitsPerWordFunc(dev, bits));

  /// Stop - mraa_spi_stop
  ///
  /// De-inits an [MraaSpiContext] device
  MraaReturnCode stop(Pointer<MraaSpiContext> dev) =>
      returnCode.fromInt(_stopFunc(dev));

  void _setUpPointers() {
    _initPointer =
        _lib.lookup<NativeFunction<_returnMraaSpiContextIntParameterFunc>>(
            'mraa_spi_init');
    _initRawPointer =
        _lib.lookup<NativeFunction<_returnMraaSpiContextIntIntParameterFunc>>(
            'mraa_spi_init_raw');
    _modePointer =
        _lib.lookup<NativeFunction<_returnIntMraaSpiContextIntParameterFunc>>(
            'mraa_spi_mode');
    _frequencyPointer =
        _lib.lookup<NativeFunction<_returnIntMraaSpiContextIntParameterFunc>>(
            'mraa_spi_frequency');
    _writePointer =
        _lib.lookup<NativeFunction<_returnIntMraaSpiContextUint8ParameterFunc>>(
            'mraa_spi_write');
    _writeWordPointer = _lib
        .lookup<NativeFunction<_returnIntMraaSpiContextUint16ParameterFunc>>(
            'mraa_spi_write_word');
    _writeBufferPointer = _lib.lookup<
            NativeFunction<
                _returnPtrUint8MraaSpiContextPtrUint8IntParameterFunc>>(
        'mraa_spi_write_buf');
    _writeBufferWordPointer = _lib.lookup<
            NativeFunction<
                _returnPtrUint16MraaSpiContextPtrUint16IntParameterFunc>>(
        'mraa_spi_write_buf_word');
    _transferBufferPointer = _lib.lookup<
            NativeFunction<
                _returnIntMraaSpiContextPtrUint8PtrUint8PtrIntParameterFunc>>(
        'mraa_spi_transfer_buf');
    _transferBufferWordPointer = _lib.lookup<
            NativeFunction<
                _returnIntMraaSpiContextPtrUint16PtrUint16PtrIntParameterFunc>>(
        'mraa_spi_transfer_buf_word');
    _lsbModePointer =
        _lib.lookup<NativeFunction<_returnIntMraaSpiContextIntParameterFunc>>(
            'mraa_spi_lsbmode');
    _bitsPerWordPointer =
        _lib.lookup<NativeFunction<_returnIntMraaSpiContextIntParameterFunc>>(
            'mraa_spi_bit_per_word');
    _stopPointer =
        _lib.lookup<NativeFunction<_returnIntMraaSpiContextParameterFunc>>(
            'mraa_spi_stop');
  }

  void _setUpFunctions() {
    _initFunc = _initPointer.asFunction<_MraaSpiInitialiseType>();
    _initRawFunc = _initRawPointer.asFunction<_MraaSpiInitialiseRawType>();
    _modeFunc = _modePointer.asFunction<_MraaSpiModeType>();
    _frequencyFunc = _frequencyPointer.asFunction<_MraaSpiFrequencyType>();
    _writeFunc = _writePointer.asFunction<_MraaSpiWriteType>();
    _writeWordFunc = _writeWordPointer.asFunction<_MraaSpiWriteWordType>();
    _writeBufferFunc =
        _writeBufferPointer.asFunction<_MraaSpiWriteBufferType>();
    _writeBufferWordFunc =
        _writeBufferWordPointer.asFunction<_MraaSpiWriteBufferWordType>();
    _transferBufferFunc =
        _transferBufferPointer.asFunction<_MraaSpiTransferBufferType>();
    _transferBufferWordFunc =
        _transferBufferWordPointer.asFunction<_MraaSpiTransferBufferWordType>();
    _lsbModeFunc = _lsbModePointer.asFunction<_MraaSpiLsbModeType>();
    _bitsPerWordFunc =
        _bitsPerWordPointer.asFunction<_MraaSpiBitsPerWordType>();
    _stopFunc = _stopPointer.asFunction<_MraaSpiStopType>();
  }
}
