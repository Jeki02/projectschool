// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "Name": "Student Name",
  "Register": "Registration",
  "Mail": "Student Mail",
  "Password": "Student Password",
  "Regis": "Sign Up",
  "Profile": "Profile",
  "Class": "Class",
  "Age": "Age",
  "Address": "Address",
  "login": "Login",
  "log": "Sign In",
  "stories": "Stories",
  "Animation": "Animation",
  "News": "News"
};
static const Map<String,dynamic> kk = {
  "Name": "Мектеп оқушысының аты",
  "Register": "Тіркеу",
  "Mail": "Оқушысының поштасы",
  "Password": "Мектеп оқушысының құпия сөзі",
  "Regis": "Тіркелу",
  "Profile": "Профиль",
  "Class": "Сынып",
  "Age": "Жасы",
  "Address": "Мекенжай",
  "login": "Кіру",
  "log": "Кіру",
  "stories": "Сторис",
  "Animation": "Анимация",
  "News": "Жаңалықтар"
};
static const Map<String,dynamic> ru = {
  "Name": "Имя Школьника",
  "Register": "Регистрация",
  "Mail": "Почта Школьника",
  "Password": "Пароль Школьника",
  "Regis": "Зарегистрироваться",
  "Profile": "Профиль",
  "Class": "Класс",
  "Age": "Возраст",
  "Address": "Адрес",
  "login": "Вход",
  "log": "Войти",
  "stories": "Сторис",
  "Animation": "Анимация",
  "News": "Новости"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "kk": kk, "ru": ru};
}
