import 'package:flutter/material.dart';
import '../constant/constant.dart';
import 'app_colors.dart';

// bool get isDark => Theme.of(this).brightness == Brightness.dark;

const TextStyle headlineMediumStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: 30,
  fontWeight: FontWeight.w700,
  // color: kBlack,
);

const TextStyle splashText = TextStyle(
  color: kWhite,
  fontSize: 34,
  fontWeight: FontWeight.bold,
  shadows: [BoxShadow(color: kBlack, blurRadius: 6)],
);

const TextStyle headlineSmallStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: 24,
  fontWeight: FontWeight.w500,
  // color: kBlack,
);

const TextStyle titleLargeStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: 22,
  fontWeight: FontWeight.w500,
  // color: kBlack,
);

const TextStyle titleMediumStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: 20,
  fontWeight: FontWeight.w500,
  // color: kBlack,
);

const TextStyle titleSmallStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: 16,
  fontWeight: FontWeight.w500,
  // color: kBlack,
);

const TextStyle bodyLargeStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: 16,
  fontWeight: FontWeight.w400,
);

const TextStyle bodyMediumStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: 14,
  fontWeight: FontWeight.w400,
  // color: kBlack,
);

const TextStyle bodySmallStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: 12,
  fontWeight: FontWeight.w400,
);

const TextStyle buttonTextStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: 16,
  fontWeight: FontWeight.w500,
);

const TextStyle labelMediumStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: 14,
  fontWeight: FontWeight.w500,
  // color: kBlack,
);
const TextStyle labelSmallStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: 12,
  fontWeight: FontWeight.w500,
  // color: kBlack,
);
//decoration

//for premium screen
final BoxDecoration containerDecoration = BoxDecoration(
  color: Colors.grey.shade100,
  borderRadius: BorderRadius.circular(12),
  border: Border.all(color: Colors.grey.shade300),
);

final BoxDecoration roundedDecoration = BoxDecoration(
  color: Colors.grey.shade100,
  borderRadius: BorderRadius.circular(35),
  border: Border.all(color: Colors.grey.shade300),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withValues(alpha: 0.2),
      blurRadius: 6,
      offset: Offset(0, 2),
    ),
  ],
);

final BoxDecoration importButtonDecoration = BoxDecoration(
  color: Colors.orangeAccent.withOpacity(0.2),
  borderRadius: BorderRadius.circular(8),
  border: Border.all(color: Colors.orangeAccent, width: 1),
);

final BoxDecoration dictionaryContainerDecoration = BoxDecoration(
  color:kWhite,
  borderRadius: BorderRadius.circular(16),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withAlpha(20),
      blurRadius: 12,
      offset: const Offset(0,2),
    ),
    BoxShadow(
      color: Colors.white.withAlpha(20),
      blurRadius: 4,
      offset: const Offset(-2, -2),
    ),
  ],
);


