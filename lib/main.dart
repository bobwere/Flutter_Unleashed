import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unleashed/app.dart';
import 'package:flutter_unleashed/common/bloc_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //set blocobserver to log monitor state changes
  Bloc.observer = MyBlocObserver();

  //run application
  runApp(App());
}
