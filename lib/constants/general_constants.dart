import 'dart:ui';

const String baseUrl = 'https://api.meteomatics.com/';
// **** MediaQuery ****
double pixelRatio = window.devicePixelRatio;

// ----------------------------------------

/// Size in physical pixels
Size physicalScreenSize = window.physicalSize;
double physicalWidth = physicalScreenSize.width;
double physicalHeight = physicalScreenSize.height;

/// Size in logical pixels
Size logicalScreenSize = window.physicalSize / pixelRatio;

///  ignore: duplicate_ignore, non_constant_identifier_names
double DEVICE_WIDTH = logicalScreenSize.width;
// ignore: non_constant_identifier_names
double DEVICE_HEIGHT = logicalScreenSize.height;
