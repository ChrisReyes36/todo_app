import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:material_ui/material_ui.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class AppTheme {
  const AppTheme._();

  static final light = FlexThemeData.light(
    scheme: FlexScheme.indigo,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurfacesVariantDialog,
    blendLevel: 40,
    appBarStyle: FlexAppBarStyle.primary,
    appBarOpacity: 0.95,
    appBarElevation: 0,
    transparentStatusBar: true,
    tabBarStyle: FlexTabBarStyle.forBackground,
    tooltipsMatchBackground: true,
    swapColors: true,
    lightIsWhite: true,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    textTheme: GoogleFonts.dekkoTextTheme(),
    primaryTextTheme: GoogleFonts.dekkoTextTheme(),
    subThemesData: const FlexSubThemesData(
      fabUseShape: true,
      elevatedButtonSchemeColor: SchemeColor.onPrimary,
      elevatedButtonSecondarySchemeColor: SchemeColor.primary,
      interactionEffects: true,
      bottomNavigationBarElevation: 0,
      bottomNavigationBarOpacity: 1,
      navigationBarOpacity: 1,
      navigationBarMutedUnselectedIcon: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorUnfocusedHasBorder: true,
      blendOnColors: true,
      popupMenuOpacity: 0.95,
    ),
  );
}
