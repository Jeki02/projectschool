import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_school/Data/DataSource/DataSource_Authentication.dart';
import 'package:flutter_school/Data/Repository/Repository_User.dart';
import 'package:flutter_school/Domain/UseCase/UseCase_User.dart';
import 'package:flutter_school/Presentation/Bloc/Authentication/Authentication_bloc.dart';
import 'package:flutter_school/Presentation/Screen/Splash_Screen.dart';
import 'package:flutter_school/firebase_options.dart';
import 'package:flutter_school/Data/Repository/Repository_News.dart';
import 'package:flutter_school/Domain/UseCase/UseCase_News.dart';
import 'package:flutter_school/Presentation/Bloc/News/News_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_school/Generate/generated/codegen_loader.g.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  AuthenticationDataSource authDataSource = AuthenticationDataSource();
  AuthenticationRepository authRepository = AuthenticationRepository(dataSource: authDataSource, firestore: FirebaseFirestore.instance);
  SignInUseCase signInUseCase = SignInUseCase(authRepository);
  SignUpUseCase signUpUseCase = SignUpUseCase(authRepository);

  Dio dio = Dio();
  NewsApi newsApi = NewsApi(dio);
  GetNewsUseCase getNewsUseCase = GetNewsUseCase(newsApi);

   runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('kk'), Locale('ru')],
      path: 'assets/translations',  
      fallbackLocale: Locale('en'),
      assetLoader: CodegenLoader(),
      child:
    MyApp(
      signInUseCase: signInUseCase,
      signUpUseCase: signUpUseCase,
      getNewsUseCase: getNewsUseCase
    )
    ),
  );
}

class MyApp extends StatelessWidget {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final GetNewsUseCase getNewsUseCase;

  MyApp({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.getNewsUseCase
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(
            signInUseCase: signInUseCase,
            signUpUseCase: signUpUseCase,
          ),
        ),
        BlocProvider<NewsBloc>(
          create: (context) => NewsBloc(getNewsUseCase),
        ),
      ],
      child: MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: SplashScreen(),
      ),
    );
  }
}