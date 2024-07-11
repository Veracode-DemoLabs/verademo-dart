import 'package:flutter/material.dart';
import 'package:verademo_dart/theme/text_theme.dart';
import 'package:verademo_dart/utils/constants.dart';

class VListTileTheme {
  VListTileTheme._();


  static final loginElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      textStyle: VTextTheme.defaultTextTheme.bodyMedium,
      padding: const EdgeInsets.symmetric(vertical: 10.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      foregroundColor: VConstants.codeWhite,
      backgroundColor: VConstants.veracodeBlue,
      minimumSize: const Size.fromHeight(40),
    )
  );
}