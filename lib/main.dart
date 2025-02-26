import 'package:flutter/material.dart';
import 'package:PocketFlow/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'repositories/category_repository.dart';
import 'screens/add_expense/blocs/category/category_bloc.dart';
import 'screens/add_expense/blocs/category/category_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase

  final CategoryRepository categoryRepository = CategoryRepository(); 

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CategoryBloc(CategoryRepository())..add(LoadCategories())),
      ],
      child: MyApp(),
    ),
  );
}
