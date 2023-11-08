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
