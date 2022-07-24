import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';

class ThemeConfig with ChangeNotifier {
  static ThemeData createTheme({
    required Brightness brightness,
    required Color background,
    required Color secondary,
    required Color chipSelectedColor,
    Color? appBarColor,
  }) {
    return ThemeData(
      brightness: brightness,
      appBarTheme: AppBarTheme(centerTitle: true, color: appBarColor),

      // sliderTheme: SliderThemeData(
      //     thumbColor: ColorConstants.gitlab,
      //     activeTrackColor: ColorConstants.gitlab),

      // switchTheme: SwitchThemeData(
      //   thumbColor: MaterialStateProperty.all(secondary),
      // ),

      //  drawerTheme: const DrawerThemeData(),

      // elevatedButtonTheme: ElevatedButtonThemeData(
      //   style: ElevatedButton.styleFrom(
      //     primary: Colors.purple,
      //   ),
      // ),

      bottomNavigationBarTheme:
          BottomNavigationBarThemeData(backgroundColor: background),

      accentColor: secondary,

      colorScheme: ColorScheme.fromSwatch(
        // primarySwatch:
        //     brightness == Brightness.light ? Colors.purple : Colors.blue,
        brightness: brightness,
      ).copyWith(secondary: secondary, primary: secondary),

      dividerTheme: const DividerThemeData(
        space: 0,
      ),

      // listTileTheme: const ListTileThemeData(
      //   tileColor: null,
      // ),

      indicatorColor: Colors.white, // tabbar
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(foregroundColor: Colors.white),
      // chipTheme: ChipThemeData(selectedColor: chipSelectedColor),
      // brightness: brightness,
      // canvasColor: background,
      // cardColor: background,
      // dividerColor: Colors.red,
      // dividerTheme: DividerThemeData(
      //   color: Colors.red,
      //   space: 1,
      //   thickness: 1,
      // ),
      // cardTheme: CardTheme(
      //   color: cardBackground,
      //   margin: EdgeInsets.zero,
      //   clipBehavior: Clip.antiAliasWithSaveLayer,
      // ),
      // backgroundColor: background,
      // primaryColor: accentColor,
      // accentColor: accentColor,
      // textSelectionColor: accentColor,
      // textSelectionHandleColor: accentColor,
      // cursorColor: accentColor,
      // textSelectionTheme: TextSelectionThemeData(
      //   selectionColor: accentColor,
      //   selectionHandleColor: accentColor,
      //   cursorColor: accentColor,
      // ),
      // toggleableActiveColor: accentColor,
      // appBarTheme: AppBarTheme(
      //   centerTitle: true,
      //   // brightness: brightness,
      //   // color: cardBackground,
      //   // titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
      //   // iconTheme: IconThemeData(
      //   //   color: secondaryText,
      //   // ),
      // ),
      // iconTheme: IconThemeData(
      //   color: secondaryText,
      // ),
      // errorColor: error,
      // buttonTheme: ButtonThemeData(
      //   textTheme: ButtonTextTheme.primary,
      //   colorScheme: ColorScheme(
      //     brightness: brightness,
      //     primary: accentColor,
      //     primaryVariant: accentColor,
      //     secondary: accentColor,
      //     secondaryVariant: accentColor,
      //     surface: background,
      //     background: background,
      //     error: error,
      //     onPrimary: buttonText,
      //     onSecondary: buttonText,
      //     onSurface: buttonText,
      //     onBackground: buttonText,
      //     onError: buttonText,
      //   ),
      //   padding: const EdgeInsets.all(16.0),
      // ),
      // cupertinoOverrideTheme: CupertinoThemeData(
      //   brightness: brightness,
      //   primaryColor: accentColor,
      // ),
      // inputDecorationTheme: InputDecorationTheme(
      //   errorStyle: TextStyle(color: error),
      //   labelStyle: TextStyle(),
      //   hintStyle: TextStyle(
      //     color: secondaryText,
      //   ),
      // ),
      // unselectedWidgetColor: Colors.black,
      // textTheme: TextTheme(
      //   headline1: baseTextTheme.headline1!.copyWith(
      //     color: primaryText,
      //   ),
      //   headline2: baseTextTheme.headline2!.copyWith(
      //     color: primaryText,
      //   ),
      //   headline3: baseTextTheme.headline3!.copyWith(
      //     color: secondaryText,
      //   ),
      //   headline4: baseTextTheme.headline4!.copyWith(
      //     color: primaryText,
      //   ),
      //   headline5: baseTextTheme.headline5!.copyWith(
      //     color: primaryText,
      //   ),
      //   headline6: baseTextTheme.headline6!.copyWith(
      //     color: primaryText,
      //   ),
      //   bodyText1: baseTextTheme.bodyText1!.copyWith(
      //     color: secondaryText,
      //   ),
      //   bodyText2: baseTextTheme.bodyText2!.copyWith(
      //     color: primaryText,
      //   ),
      //   button: baseTextTheme.button!.copyWith(
      //     color: primaryText,
      //   ),
      //   caption: baseTextTheme.caption!.copyWith(
      //     color: primaryText,
      //   ),
      //   overline: baseTextTheme.overline!.copyWith(
      //     color: secondaryText,
      //   ),
      //   subtitle1: baseTextTheme.subtitle1!.copyWith(
      //     color: primaryText,
      //   ),
      //   subtitle2: baseTextTheme.subtitle2!.copyWith(
      //     color: secondaryText,
      //   ),
      // ),
    );
  }

  static ThemeData get lightTheme => createTheme(
        brightness: Brightness.light,
        background: ColorConstants.lightScaffoldBackgroundColor,
        // bottombar item
        // tree item (folder)
        secondary: Colors.blue,
        chipSelectedColor: Colors.lightGreen,
        appBarColor: Colors.blue,
      );

  static ThemeData get darkTheme => createTheme(
        brightness: Brightness.dark,
        background: ColorConstants.darkScaffoldBackgroundColor,
        secondary: Colors.blue,
        chipSelectedColor: Colors.green,
      );

  static switchTheme() {}
}
