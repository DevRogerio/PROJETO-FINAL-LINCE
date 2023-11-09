// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class Inter {
  Inter();

  static Inter? _current;

  static Inter get current {
    assert(_current != null,
        'No instance of Inter was loaded. Try to initialize the Inter delegate before accessing Inter.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Inter> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Inter();
      Inter._current = instance;

      return instance;
    });
  }

  static Inter of(BuildContext context) {
    final instance = Inter.maybeOf(context);
    assert(instance != null,
        'No instance of Inter present in the widget tree. Did you add Inter.delegate in localizationsDelegates?');
    return instance!;
  }

  static Inter? maybeOf(BuildContext context) {
    return Localizations.of<Inter>(context, Inter);
  }

  /// `Document (CNPJ with 14 digits)`
  String get documentCNPJ {
    return Intl.message(
      'Document (CNPJ with 14 digits)',
      name: 'documentCNPJ',
      desc: '',
      args: [],
    );
  }

  /// `Store Name`
  String get StoreName {
    return Intl.message(
      'Store Name',
      name: 'StoreName',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get passwordStore {
    return Intl.message(
      'password',
      name: 'passwordStore',
      desc: '',
      args: [],
    );
  }

  /// `generate passoword`
  String get generatepassword {
    return Intl.message(
      'generate passoword',
      name: 'generatepassword',
      desc: '',
      args: [],
    );
  }

  /// `register`
  String get register {
    return Intl.message(
      'register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get Password {
    return Intl.message(
      'Password',
      name: 'Password',
      desc: '',
      args: [],
    );
  }

  /// `plate`
  String get plate {
    return Intl.message(
      'plate',
      name: 'plate',
      desc: '',
      args: [],
    );
  }

  /// `builtYear`
  String get builtYear {
    return Intl.message(
      'builtYear',
      name: 'builtYear',
      desc: '',
      args: [],
    );
  }

  /// `vehicleYear`
  String get vehicleYear {
    return Intl.message(
      'vehicleYear',
      name: 'vehicleYear',
      desc: '',
      args: [],
    );
  }

  /// `pricePaid`
  String get pricePaid {
    return Intl.message(
      'pricePaid',
      name: 'pricePaid',
      desc: '',
      args: [],
    );
  }

  /// `purchasedWhen`
  String get purchasedWhen {
    return Intl.message(
      'purchasedWhen',
      name: 'purchasedWhen',
      desc: '',
      args: [],
    );
  }

  /// `gallery`
  String get gallery {
    return Intl.message(
      'gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `brand`
  String get brand {
    return Intl.message(
      'brand',
      name: 'brand',
      desc: '',
      args: [],
    );
  }

  /// `Model`
  String get Model {
    return Intl.message(
      'Model',
      name: 'Model',
      desc: '',
      args: [],
    );
  }

  /// `update`
  String get update {
    return Intl.message(
      'update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `name`
  String get name {
    return Intl.message(
      'name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `soldWhen`
  String get soldWhen {
    return Intl.message(
      'soldWhen',
      name: 'soldWhen',
      desc: '',
      args: [],
    );
  }

  /// `priceSold`
  String get priceSold {
    return Intl.message(
      'priceSold',
      name: 'priceSold',
      desc: '',
      args: [],
    );
  }

  /// `dealershipCut`
  String get dealershipCut {
    return Intl.message(
      'dealershipCut',
      name: 'dealershipCut',
      desc: '',
      args: [],
    );
  }

  /// `businessCut`
  String get businessCut {
    return Intl.message(
      'businessCut',
      name: 'businessCut',
      desc: '',
      args: [],
    );
  }

  /// `Hi Anderson, what are we going to do?`
  String get HiAnderson {
    return Intl.message(
      'Hi Anderson, what are we going to do?',
      name: 'HiAnderson',
      desc: '',
      args: [],
    );
  }

  /// `Search for Stores`
  String get SearchforStores {
    return Intl.message(
      'Search for Stores',
      name: 'SearchforStores',
      desc: '',
      args: [],
    );
  }

  /// `Search for Cars`
  String get SearchforCars {
    return Intl.message(
      'Search for Cars',
      name: 'SearchforCars',
      desc: '',
      args: [],
    );
  }

  /// `Sales Made`
  String get SalesMade {
    return Intl.message(
      'Sales Made',
      name: 'SalesMade',
      desc: '',
      args: [],
    );
  }

  /// `HomePage`
  String get HomePage {
    return Intl.message(
      'HomePage',
      name: 'HomePage',
      desc: '',
      args: [],
    );
  }

  /// `Stores`
  String get Stores {
    return Intl.message(
      'Stores',
      name: 'Stores',
      desc: '',
      args: [],
    );
  }

  /// `Register Partner Stores`
  String get RegisterPartnerStores {
    return Intl.message(
      'Register Partner Stores',
      name: 'RegisterPartnerStores',
      desc: '',
      args: [],
    );
  }

  /// `Cars`
  String get Cars {
    return Intl.message(
      'Cars',
      name: 'Cars',
      desc: '',
      args: [],
    );
  }

  /// `Register Cars`
  String get RegisterCars {
    return Intl.message(
      'Register Cars',
      name: 'RegisterCars',
      desc: '',
      args: [],
    );
  }

  /// `AndersonCars`
  String get AndersonCars {
    return Intl.message(
      'AndersonCars',
      name: 'AndersonCars',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Inter> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Inter> load(Locale locale) => Inter.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
