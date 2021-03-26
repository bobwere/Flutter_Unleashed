import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unleashed/cubit/pokemon_cubit.dart';
import 'package:flutter_unleashed/cubit/registration_cubit.dart';
import 'package:flutter_unleashed/presentation/pages/design_page.dart';
import 'package:flutter_unleashed/presentation/pages/dictionary_page.dart';
import 'package:flutter_unleashed/presentation/pages/info_page.dart';
import 'package:flutter_unleashed/presentation/pages/response_page.dart';
import 'package:flutter_unleashed/presentation/widgets/home_page_widgets.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _currentPage;
  List<Widget> _pages;
  var _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    //initialize all 4 bottomnaigationbar pages
    _pages = [
      InfoPage(),
      DesignPage(
        onEditPressed: navigateToInfoPage,
        onFavouritePressed: navigateToFavouritePage,
      ),
      ResponsePage(),
      DictionaryPage()
    ];

    //initialize current bottom navigation bar
    _currentPage = _pages[0];
  }

  void navigateToDesignPage() {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      _currentIndex = 1;
      _currentPage = _pages[1];
    });
  }

  void navigateToInfoPage() {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      _currentIndex = 0;
      _currentPage = _pages[0];
    });
  }

  void navigateToFavouritePage() {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      _currentIndex = 3;
      _currentPage = _pages[3];
    });
  }

  Widget determineLeadingWidget(Widget currentPage) {
    if (currentPage.runtimeType == InfoPage) {
      return Container();
    } else {
      return IconButton(
        icon: Icon(LineAwesomeIcons.arrow_left),
        onPressed: () {
          navigateToInfoPage();
        },
        color: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PokemonCubit, PokemonState>(
      listenWhen: (p, c) {
        return !p.actionSuccess && c.actionSuccess ||
            p.errorMessage.isEmpty && c.errorMessage.isNotEmpty;
      },
      listener: (context, state) {
        if (state.errorMessage.isNotEmpty) {
          Flushbar(
            title: 'An Error Occurred',
            message: state.errorMessage,
            margin: EdgeInsets.all(10),
            flushbarPosition: FlushbarPosition.TOP,
            duration: Duration(seconds: 3),
            isDismissible: true,
            titleColor: Colors.black87,
            messageColor: Colors.black87,
            backgroundColor: Color(0xFFFD9726),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ).show(context);
        }
        if (state.actionSuccess) {
          Flushbar(
            title: 'Success',
            message: state.successMessage,
            margin: EdgeInsets.all(10),
            flushbarPosition: FlushbarPosition.TOP,
            duration: Duration(seconds: 3),
            isDismissible: true,
            backgroundColor: Colors.green[800],
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ).show(context);
        }
      },
      child: BlocListener<RegistrationCubit, RegistrationState>(
        listenWhen: (p, c) {
          return !p.hasSucceeded && c.hasSucceeded ||
              p.errorMessage.isEmpty && c.errorMessage.isNotEmpty;
        },
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            Flushbar(
              title: 'An Error Occurred',
              message: state.errorMessage,
              margin: EdgeInsets.all(10),
              flushbarPosition: FlushbarPosition.TOP,
              duration: Duration(seconds: 3),
              isDismissible: true,
              titleColor: Colors.black87,
              messageColor: Colors.black87,
              backgroundColor: Color(0xFFFD9726),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ).show(context);
          }
          if (state.hasSucceeded) {
            if (state.user != null) {
              navigateToDesignPage();
            }
            Flushbar(
              title: 'Success',
              message: state.successMessage,
              margin: EdgeInsets.all(10),
              flushbarPosition: FlushbarPosition.TOP,
              duration: Duration(seconds: 3),
              isDismissible: true,
              backgroundColor: Colors.green[800],
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ).show(context);
          }
        },
        child: Scaffold(
          //  ======   Appbar of homepage title changes in response to selected tab =======

          appBar: AppBar(
            title: getCurrentAppBarTitle(_currentPage),
            leading: determineLeadingWidget(_currentPage),
            elevation: 2.0,
            centerTitle: true,
          ),

          //  ======   Body of homepage =======

          body: FadeIndexedStack(
            index: _currentIndex,
            children: _pages,
          ),

          //  ======   BottomNavigationBar =======

          bottomNavigationBar: SalomonBottomBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() {
              _currentIndex = index;
              _currentPage = _pages[index];
            }),
            items: [
              /// Info Tab
              SalomonBottomBarItem(
                icon: Icon(LineAwesomeIcons.edit),
                title: Text("Info"),
                selectedColor: Colors.purple,
              ),

              /// Design tab
              SalomonBottomBarItem(
                icon: Icon(LineAwesomeIcons.user),
                title: Text("Design"),
                selectedColor: Colors.pink,
              ),

              /// Response Tab
              SalomonBottomBarItem(
                icon: Icon(LineAwesomeIcons.search),
                title: Text("Response"),
                selectedColor: Colors.orange,
              ),

              ///Dictionary Tab
              SalomonBottomBarItem(
                icon: Icon(LineAwesomeIcons.paw),
                title: Text("Dictionary"),
                selectedColor: Colors.teal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
