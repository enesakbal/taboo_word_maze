import 'package:flutter/material.dart';

class ColorsTones {
  //* light mode
  static Color get softBlue => const Color(0XFF48b5f1);
  static Color get lightSkyBlue => const Color(0XFF87CEFA);
  static Color get lightGreen => const Color(0XFF90EE90);
  static Color get lightBlue => const Color(0XFFADD8E6);
  static Color get azure => const Color(0XFFF0FFFF);
  static Color get darkSkyBlue => const Color(0XFF708090);
  static Color get darkGreen => const Color(0XFF006400);
  static Color get darkBlue => const Color(0XFF00008B);
  static Color get slateGrey => const Color(0XFF708090);
  static Color get flaxYellow => const Color(0XFFEEDC82);
  static Color get goldenYellow => const Color(0XFFFFD700);
  static Color get buttonBackgroundColorLight => azure.withOpacity(0.8);

//* dark mode

  static Color get darkPrimary => const Color(0XFF303030);
  static Color get darkSecondary => const Color(0XFF414141);
  static Color get dark => const Color(0XFF313131);
  static Color get darkRed => const Color(0XFFCA3E47).withOpacity(0.6);
  static Color get buttonBackgroundColorDark =>
      ColorsTones.azure.withOpacity(0.6);

  /**
   * #87CEFA (Light Sky Blue)
#90EE90 (Light Green)
#ADD8E6 (Light Blue)
#F0FFFF (Azure) 
   */
}

class ColorsTones2 {
  ///*light mode
  static Color get primaryColor => const Color(0XFF4E9EFA);
  static Color get secondaryColor => const Color(0XFFb36457);
  static Color get azure => const Color(0XFFF0FFFF);
  static Color get azure2 => const Color.fromARGB(255, 214, 233, 233);
  static Color get azure3 => const Color.fromARGB(255, 213, 227, 227);
  static Color get success => const Color(0XFF3CB371);
  static Color get pass => const Color(0XFFF4BB44);
  static Color get fail => const Color(0XFFFF613F);
  static Color get black => const Color.fromARGB(255, 0, 0, 0);
  static Color get softBlue => const Color.fromARGB(255, 70, 86, 186);
  static Color get black26 => Colors.black26;
  // static Color get orange => Color.fromARGB(255, 159, 107, 255);
}
