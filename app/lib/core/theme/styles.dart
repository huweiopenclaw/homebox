import 'package:flutter/material.dart';

class AppStyles {
  // Padding
  static const EdgeInsets paddingSmall = EdgeInsets.all(8);
  static const EdgeInsets paddingMedium = EdgeInsets.all(16);
  static const EdgeInsets paddingLarge = EdgeInsets.all(24);
  
  static const EdgeInsets horizontalPaddingSmall = EdgeInsets.symmetric(horizontal: 8);
  static const EdgeInsets horizontalPaddingMedium = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets horizontalPaddingLarge = EdgeInsets.symmetric(horizontal: 24);
  
  static const EdgeInsets verticalPaddingSmall = EdgeInsets.symmetric(vertical: 8);
  static const EdgeInsets verticalPaddingMedium = EdgeInsets.symmetric(vertical: 16);
  static const EdgeInsets verticalPaddingLarge = EdgeInsets.symmetric(vertical: 24);
  
  // Border Radius
  static BorderRadius borderRadiusSmall = BorderRadius.circular(8);
  static BorderRadius borderRadiusMedium = BorderRadius.circular(12);
  static BorderRadius borderRadiusLarge = BorderRadius.circular(16);
  static BorderRadius borderRadiusXL = BorderRadius.circular(24);
  
  static BorderRadius get borderRadiusCircle => BorderRadius.circular(1000);
  
  // Card decorations
  static BoxDecoration cardDecoration(BoxShadow shadow) => BoxDecoration(
    color: Colors.white,
    borderRadius: borderRadiusLarge,
    boxShadow: [shadow],
  );
  
  // Shadows
  static BoxShadow get shadowSmall => BoxShadow(
    color: Colors.black.withOpacity(0.05),
    blurRadius: 8,
    offset: const Offset(0, 2),
  );
  
  static BoxShadow get shadowMedium => BoxShadow(
    color: Colors.black.withOpacity(0.08),
    blurRadius: 16,
    offset: const Offset(0, 4),
  );
  
  static BoxShadow get shadowLarge => BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: 24,
    offset: const Offset(0, 8),
  );
  
  // Text Styles
  static const TextStyle heading1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle heading3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );
  
  static const TextStyle caption = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.normal,
    color: Colors.grey,
  );
  
  // Spacing
  static const double spacingXS = 4;
  static const double spacingS = 8;
  static const double spacingM = 16;
  static const double spacingL = 24;
  static const double spacingXL = 32;
  static const double spacingXXL = 48;
}
