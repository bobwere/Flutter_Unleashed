import 'package:circular_splash_transition/circular_splash_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unleashed/common/flutter_unleashed_theme.dart';
import 'package:flutter_unleashed/cubit/pokemon_cubit.dart';
import 'package:flutter_unleashed/cubit/registration_cubit.dart';
import 'package:flutter_unleashed/presentation/pages/home_page.dart';
import 'package:flutter_unleashed/presentation/pages/splash_page.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  SharedPreferences _pref;

  @override
  void initState() {
    super.initState();
    initializeSharedPrefernces();
  }

  void initializeSharedPrefernces() async {
    _pref = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //set a global handler to manage situation where
        //when user taps outside an already clicked textfield area
        // the keyborad should hide immediately
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider<RegistrationCubit>(
              create: (context) => RegistrationCubit(_pref)..getUserProfile()),
          BlocProvider<PokemonCubit>(
              create: (context) => PokemonCubit(_pref)
                ..getFavourites()
                ..unsortedDictionary())
        ],
        child: MaterialApp(
          title: 'Flutter Unleashed',
          debugShowCheckedModeBanner: false,

          //enable responsiveness of the app to different screen resolutions
          builder: (context, widget) => ResponsiveWrapper.builder(
              BouncingScrollWrapper.builder(context, widget),
              maxWidth: 1200,
              minWidth: 320,
              defaultScale: true,
              breakpoints: [
                ResponsiveBreakpoint.resize(320, name: MOBILE),
                ResponsiveBreakpoint.autoScale(800, name: TABLET),
                ResponsiveBreakpoint.resize(1000, name: DESKTOP),
                ResponsiveBreakpoint.autoScale(2460, name: '4K'),
              ],
              background: Container(color: Color(0xFFF5F5F5))),
          theme: flutterUnleashedTheme,
          home: SplashPage(),
          onGenerateRoute: (RouteSettings route) {
            CircularSplashRoute currentRoute;
            switch (route.name) {
              case "/homepage":
                currentRoute = CircularSplashRoute(
                    builder: const HomePage(),
                    color: flutterUnleashedTheme.primaryColor,
                    duration: Duration(milliseconds: 450));
            }
            return currentRoute;
          },
        ),
      ),
    );
  }
}
