import 'package:flutter/material.dart';

extension SizedboxExt on int {
  Widget get heightSb => SizedBox(height: toDouble());
  Widget get widthSb => SizedBox(width: toDouble());
}