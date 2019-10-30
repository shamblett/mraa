/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

// ignore_for_file: avoid_positional_boolean_parameters

part of mraa;

/// C Function type typedefs
typedef returnMraaSpiContextIntParameterFunc = Pointer<MraaSpiContext> Function(
    Int32);
typedef returnMraaSpiContextIntIntParameterFunc = Pointer<MraaSpiContext>
    Function(Int32, Int32);
typedef returnIntMraaSpiContextIntParameterFunc = Int32 Function(
    Pointer<MraaSpiContext>, Int32);
typedef returnIntMraaSpiContextUint8ParameterFunc = Int32 Function(
    Pointer<MraaSpiContext>, Uint8);
typedef returnIntMraaSpiContextUint16ParameterFunc = Int32 Function(
    Pointer<MraaSpiContext>, Uint16);
typedef returnPtrUint8MraaSpiContextPtrUint8IntParameterFunc = Pointer<Uint8>
    Function(Pointer<MraaSpiContext>, Pointer<Uint8>, Int32);
typedef returnPtrUint16MraaSpiContextPtrUint16IntParameterFunc = Pointer<Uint16>
    Function(Pointer<MraaSpiContext>, Pointer<Uint16>, Int32);
typedef returnIntMraaSpiContextPtrUint8PtrUint8PtrIntParameterFunc = Int32
    Function(Pointer<MraaSpiContext>, Pointer<Uint8>, Pointer<Uint8>, Int32);
typedef returnIntMraaSpiContextPtrUint16PtrUint16PtrIntParameterFunc = Int32
    Function(Pointer<MraaSpiContext>, Pointer<Uint16>, Pointer<Uint16>, Uint32);
typedef returnIntMraaSpiContextParameterFunc = Int32 Function(
    Pointer<MraaSpiContext>);

/// Dart Function typedefs
typedef MraaSpiInitialiseType = Pointer<MraaSpiContext> Function(int);
typedef MraaSpiInitialiseRawType = Pointer<MraaSpiContext> Function(int, int);
typedef MraaSpiModeType = int Function(Pointer<MraaSpiContext>, int);
typedef MraaSpiFrequencyType = int Function(Pointer<MraaSpiContext>, int);
typedef MraaSpiWriteType = int Function(Pointer<MraaSpiContext>, int);
typedef MraaSpiWriteWordType = int Function(Pointer<MraaSpiContext>, int);
typedef MraaSpiWriteBufferType = Pointer<Uint8> Function(
    Pointer<MraaSpiContext>, Pointer<Uint8>, int);
typedef MraaSpiWriteBufferWordType = Pointer<Uint16> Function(
    Pointer<MraaSpiContext>, Pointer<Uint16>, int);
typedef MraaSpiTransferBufferType = int Function(
    Pointer<MraaSpiContext>, Pointer<Uint8>, Pointer<Uint8>, int);
typedef MraaSpiTransferBufferWordType = int Function(
    Pointer<MraaSpiContext>, Pointer<Uint16>, Pointer<Uint16>, int);
typedef MraaSpiLsbModeType = int Function(Pointer<MraaSpiContext>, int);
typedef MraaSpiBitsPerWordType = int Function(Pointer<MraaSpiContext>, int);
typedef MraaSpiStopType = int Function(Pointer<MraaSpiContext>);

/// The SPI MRAA API
/// An SPI object in libmraa represents a spidev device. Linux spidev devices
/// are created per spi bus and every chip select available on that bus has another
/// spidev 'file'.
class _MraaSpi {
  _MraaSpi(this._lib, this._noJsonLoading) {
    _setUpPointers();
    _setUpFunctions();
  }

  /// The MRAA library
  DynamicLibrary _lib;

  bool _noJsonLoading = false;

  /// C Pointers
  Pointer<NativeFunction<returnMraaSpiContextIntParameterFunc>> _initPointer;
  Pointer<NativeFunction<returnMraaSpiContextIntIntParameterFunc>>
      _initRawPointer;
  Pointer<NativeFunction<returnIntMraaSpiContextIntParameterFunc>> _modePointer;
  Pointer<NativeFunction<returnIntMraaSpiContextIntParameterFunc>>
      _frequencyPointer;
  Pointer<NativeFunction<returnIntMraaSpiContextUint8ParameterFunc>>
      _writePointer;
  Pointer<NativeFunction<returnIntMraaSpiContextUint16ParameterFunc>>
      _writeWordPointer;
  Pointer<NativeFunction<returnPtrUint8MraaSpiContextPtrUint8IntParameterFunc>>
      _writeBufferPointer;
  Pointer<
          NativeFunction<
              returnPtrUint16MraaSpiContextPtrUint16IntParameterFunc>>
      _writeBufferWordPointer;
  Pointer<
          NativeFunction<
              returnIntMraaSpiContextPtrUint8PtrUint8PtrIntParameterFunc>>
      _transferBufferPointer;
  Pointer<
          NativeFunction<
              returnIntMraaSpiContextPtrUint16PtrUint16PtrIntParameterFunc>>
      _transferBufferWordPointer;
  Pointer<NativeFunction<returnIntMraaSpiContextIntParameterFunc>>
      _lsbModePointer;
  Pointer<NativeFunction<returnIntMraaSpiContextIntParameterFunc>>
      _bitsPerWordPointer;
  Pointer<NativeFunction<returnIntMraaSpiContextParameterFunc>> _stopPointer;

  /// Dart Functions
  MraaSpiInitialiseType  _initFunc;
  MraaSpiInitialiseRawType _initRawFunc;
  MraaSpiModeType _modeFunc;
  MraaSpiFrequencyType _frequencyFunc;
  MraaSpiWriteType _writeFunc;
  MraaSpiWriteWordType _writeWordFunc;
  MraaSpiWriteBufferType _writeBufferFunc;
  MraaSpiWriteBufferWordType _writeBufferWordFunc;
  MraaSpiTransferBufferType _transferBufferFunc;
  MraaSpiTransferBufferWordType _transferBufferWordFunc;
  MraaSpiLsbModeType _lsbModeFunc;
  MraaSpiBitsPerWordType _bitsPerWordFunc;
  MraaSpiStopType _stopFunc;

  /// Initialise - mraa_spi_init
  /// Initialise SPI_context, uses board mapping. Sets the muxes
  Pointer<MraaSpiContext> initialise(int busId) => _initFunc(busId);

  /// Initialise raw- mraa_spi_init_raw
  /// Initialise SPI_context without any board configuration, selects a bus and a mux.
  Pointer<MraaSpiContext> initialiseRaw(int busId, int cs) =>
      _initRawFunc(busId, cs);

  /// Mode - mraa_spi_mode
  /// Set the SPI device mode. see spidev 0-3.
  MraaReturnCode mode(Pointer<MraaSpiContext> dev, MraaSpiMode mode) =>
      returnCode.fromInt(_modeFunc(dev, spiMode.asInt(mode)));

  /// Frequency - mraa_spi_frequency
  /// Set the SPI device operating clock frequency in Hz
  MraaReturnCode frequency(Pointer<MraaSpiContext> dev, int hz) =>
      returnCode.fromInt(_frequencyFunc(dev, hz));

  /// Write - mraa_spi_write
  /// Write Single Byte to the SPI device.
  /// Returns data received on the miso line or -1 in case of error
  int write(Pointer<MraaSpiContext> dev, int data) => _writeFunc(dev, data);

  /// Write word - mraa_spi_write_word
  /// Write Two Bytes to the SPI device.
  /// Returns data received on the miso line or -1 in case of error
  int writeWord(Pointer<MraaSpiContext> dev, int data) =>
      _writeWordFunc(dev, data);

  /// Write buffer - mraa_spi-write_buf
  /// Write Buffer of bytes to the SPI device. The pointer return has to be
  /// free'd by the caller. It will return a NULL pointer in cases of error.
  /// Maximum length is 4096
  Uint8List writeBuffer(
      Pointer<MraaSpiContext> dev, Uint8List data, int length) {
    final Pointer<Uint8> ptr = ffi.allocate<Uint8>(count: length);
    final Uint8List ptrData = ptr.asTypedList(length);
    ptrData.setAll(0, data);
    final Pointer<Uint8> retData = _writeBufferFunc(dev, ptr, length);
    final Uint8List retDataList = retData.asTypedList(length);
    final Uint8List ret = Uint8List(length);
    ret.setAll(0, retDataList);
    ffi.free(retData);
    return ret;
  }

  /// Write buffer word - mraa_spi-write_buf_word
  /// Write Buffer of words to the SPI device. The pointer return has to be
  /// free'd by the caller. It will return a NULL pointer in cases of error.
  /// Maximum length is 4096
  Uint16List writeBufferWord(
      Pointer<MraaSpiContext> dev, Uint16List data, int length) {
    final Pointer<Uint16> ptr = ffi.allocate<Uint16>(count: length);
    final Uint16List ptrData = ptr.asTypedList(length);
    ptrData.setAll(0, data);
    final Pointer<Uint16> retData = _writeBufferWordFunc(dev, ptr, length);
    final Uint16List retDataList = retData.asTypedList(length);
    final Uint16List ret = Uint16List(length);
    ret.setAll(0, retDataList);
    ffi.free(retData);
    return ret;
  }

  /// Transfer buffer - mraa_spi_transfer_buf
  /// Transfer Buffer of bytes to the SPI device. Both send and recv buffers are passed in
  /// Maximum length 4096 both ways
  MraaReturnCode transferBuffer(Pointer<MraaSpiContext> dev,
      MraaSpiTransferBuffer<Uint8List> buffer, int length) {
    final Pointer<Uint8> ptr = ffi.allocate<Uint8>(count: length);
    final Uint8List ptrData = ptr.asTypedList(length);
    ptrData.setAll(0, buffer.dataSent);
    final Pointer<Uint8> retData = ffi.allocate<Uint8>(count: length);
    final MraaReturnCode status =
        returnCode.fromInt(_transferBufferFunc(dev, ptr, retData, length));
    final Uint8List retDataList = retData.asTypedList(length);
    buffer.dataReceived = Uint8List(length);
    buffer.dataReceived.setAll(0, retDataList);
    ffi.free(retData);
    return status;
  }

  /// Transfer buffer word - mraa_spi_transfer_buf_word
  /// Transfer Buffer of words to the SPI device. Both send and recv buffers are passed in
  /// Maximum length 4096 both ways
  MraaReturnCode transferBufferWord(Pointer<MraaSpiContext> dev,
      MraaSpiTransferBuffer<Uint16List> buffer, int length) {
    final Pointer<Uint16> ptr = ffi.allocate<Uint16>(count: length);
    final Uint16List ptrData = ptr.asTypedList(length);
    ptrData.setAll(0, buffer.dataSent);
    final Pointer<Uint16> retData = ffi.allocate<Uint16>(count: length);
    final MraaReturnCode status =
        returnCode.fromInt(_transferBufferWordFunc(dev, ptr, retData, length));
    final Uint16List retDataList = retData.asTypedList(length);
    buffer.dataReceived = Uint16List(length);
    buffer.dataReceived.setAll(0, retDataList);
    ffi.free(retData);
    return status;
  }

  /// Lsb mode - mraa_spi_lsbmode
  /// Change the SPI lsb mode
  /// True indicates use the least significant bit transmission
  MraaReturnCode lsbMode(Pointer<MraaSpiContext> dev, bool lsb) {
    final int mode = lsb ? 1 : 0;
    return returnCode.fromInt(_lsbModeFunc(dev, mode));
  }

  /// Bits per word - mraa_spi_bit_per-word
  /// Set bits per word for transactions, defaults at 8
  MraaReturnCode bitsPerWord(Pointer<MraaSpiContext> dev, int bits) =>
      returnCode.fromInt(_bitsPerWordFunc(dev, bits));

  /// Stop - mraa_spi_stop
  /// De-inits an mraa_spi_context device
  MraaReturnCode stop(Pointer<MraaSpiContext> dev) =>
      returnCode.fromInt(_stopFunc(dev));

  void _setUpPointers() {
    _initPointer =
        _lib.lookup<NativeFunction<returnMraaSpiContextIntParameterFunc>>(
            'mraa_spi_init');
    _initRawPointer =
        _lib.lookup<NativeFunction<returnMraaSpiContextIntIntParameterFunc>>(
            'mraa_spi_init_raw');
    _modePointer =
        _lib.lookup<NativeFunction<returnIntMraaSpiContextIntParameterFunc>>(
            'mraa_spi_mode');
    _frequencyPointer =
        _lib.lookup<NativeFunction<returnIntMraaSpiContextIntParameterFunc>>(
            'mraa_spi_frequency');
    _writePointer =
        _lib.lookup<NativeFunction<returnIntMraaSpiContextUint8ParameterFunc>>(
            'mraa_spi_write');
    _writeWordPointer =
        _lib.lookup<NativeFunction<returnIntMraaSpiContextUint16ParameterFunc>>(
            'mraa_spi_write_word');
    _writeBufferPointer = _lib.lookup<
            NativeFunction<
                returnPtrUint8MraaSpiContextPtrUint8IntParameterFunc>>(
        'mraa_spi_write_buf');
    _writeBufferWordPointer = _lib.lookup<
            NativeFunction<
                returnPtrUint16MraaSpiContextPtrUint16IntParameterFunc>>(
        'mraa_spi_write_buf_word');
    _transferBufferPointer = _lib.lookup<
            NativeFunction<
                returnIntMraaSpiContextPtrUint8PtrUint8PtrIntParameterFunc>>(
        'mraa_spi_transfer_buf');
    _transferBufferWordPointer = _lib.lookup<
            NativeFunction<
                returnIntMraaSpiContextPtrUint16PtrUint16PtrIntParameterFunc>>(
        'mraa_spi_transfer_buf_word');
    _lsbModePointer =
        _lib.lookup<NativeFunction<returnIntMraaSpiContextIntParameterFunc>>(
            'mraa_spi_lsbmode');
    _bitsPerWordPointer =
        _lib.lookup<NativeFunction<returnIntMraaSpiContextIntParameterFunc>>(
            'mraa_spi_bit_per_word');
    _stopPointer =
        _lib.lookup<NativeFunction<returnIntMraaSpiContextParameterFunc>>(
            'mraa_spi_stop');
  }

  void _setUpFunctions() {
    _initFunc = _initPointer.asFunction<MraaSpiInitialiseType>();
    _initRawFunc = _initRawPointer.asFunction<MraaSpiInitialiseRawType>();
    _modeFunc = _modePointer.asFunction<MraaSpiModeType>();
    _frequencyFunc = _frequencyPointer.asFunction<MraaSpiFrequencyType>();
    _writeFunc = _writePointer.asFunction<MraaSpiWriteType>();
    _writeWordFunc = _writeWordPointer.asFunction<MraaSpiWriteWordType>();
    _writeBufferFunc = _writeBufferPointer.asFunction<MraaSpiWriteBufferType>();
    _writeBufferWordFunc =
        _writeBufferWordPointer.asFunction<MraaSpiWriteBufferWordType>();
    _transferBufferFunc =
        _transferBufferPointer.asFunction<MraaSpiTransferBufferType>();
    _transferBufferWordFunc =
        _transferBufferWordPointer.asFunction<MraaSpiTransferBufferWordType>();
    _lsbModeFunc = _lsbModePointer.asFunction<MraaSpiLsbModeType>();
    _bitsPerWordFunc = _bitsPerWordPointer.asFunction<MraaSpiBitsPerWordType>();
    _stopFunc = _stopPointer.asFunction<MraaSpiStopType>();
  }
}
