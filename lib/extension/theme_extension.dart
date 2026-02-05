import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';


extension ContextExtension on BuildContext {

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  bool get isDarkTheme => theme.brightness == Brightness.dark;

  Color get bgColor => isDarkTheme ? const Color(0xff292524) : kWhiteF7;

  Color get cardBgColor => isDarkTheme ? const Color(0xff1E1E1E) : Colors.white;

  Color get shimmerColor => isDarkTheme ? Colors.grey.shade800 : Colors.grey.shade300;


  Color get textPrimary => isDarkTheme ? Colors.white : kBlack;
  Color get textSecondary => isDarkTheme ? Colors.white70 : Colors.grey;
  Color get dividerColor => isDarkTheme ? Colors.white24 : greyBorderColor;
  Color get iconColor => isDarkTheme ? Colors.white : Colors.black;
  Color get reportScreenContainerBorderColor =>  isDarkTheme ? Colors.grey : Colors.white;

  ({Color base, Color highlight}) shimmer() {
    return (
    base: isDarkTheme ? kGrey : kGrey.withValues(alpha: 0.3),
    highlight: isDarkTheme ? kWhite : kWhite.withValues(alpha: 0.6),
    );
  }
}


