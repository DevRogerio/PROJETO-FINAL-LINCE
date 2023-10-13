import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

/// Brand from Fipe Api
/// with [code] and [name] parameters.
class BrandEndpoint {
  /// indentification of a Brand from Fipe Api.
  final String? code;

  /// Name of a brand from Fipe Api.
  final String? name;

  /// Constructs an instance of an [BrandEndpoint]
  ///
  /// with given [code] and [name] parameters.
  BrandEndpoint({
    this.code,
    this.name,
  });

  /// Translates a JSON response to an instance of [BrandEndpoint].
  factory BrandEndpoint.fromJson(Map<String, dynamic> json) => BrandEndpoint(
        code: json['codigo'],
        name: json['nome'],
      );

  @override
  String toString() {
    return name!;
  }
}

/// Model of Vehicle from Fipe Api
/// with [code] and [name] parameters.
class ModelEndpoint {
  /// indentification of a Model from Fipe Api.
  final int? code;

  /// Name of a vehicle model from Fipe Api.
  final String? name;

  /// Constructs an instance of an [ModelEndpoint]
  ///
  /// with given [code] and [name] parameters.
  ModelEndpoint({
    this.code,
    this.name,
  });

  /// Translates a JSON response to an instance of [ModelEndpoint].
  factory ModelEndpoint.fromJson(Map<String, dynamic> json) => ModelEndpoint(
        code: json['codigo'],
        name: json['nome'],
      );

  @override
  String toString() {
    return name!;
  }
}

/// a list of [BrandEndpoint] instances.

Future<List<BrandEndpoint>?> getCarBrands() async {
  const url = 'https://parallelum.com.br/fipe/api/v1/carros/marcas/';
  final uri = Uri.parse(url);

  try {
    final response = await http.get(uri);

    final decodeResult = jsonDecode(response.body);

    final result = <BrandEndpoint>[];

    for (final item in decodeResult) {
      result.add(
        BrandEndpoint.fromJson(item),
      );
    }
    return result;
  } on Exception catch (e) {
    log('$e');
    return null;
  }
}

/// a list of [ModelEndpoint] instances.

Future<List<ModelEndpoint>?> getCarModel(String brandName) async {
  final listOfBrands = await getCarBrands();

  var brand = listOfBrands!.firstWhere(
    (element) => element.name == brandName,
    orElse: () => BrandEndpoint(code: null),
  );

  if (brand.code != null) {
    final url =
        'https://parallelum.com.br/fipe/api/v1/carros/marcas/${brand.code}/modelos/';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);

      final decodeResult = jsonDecode(response.body);
      log(decodeResult['modelos'].toString());

      final result = <ModelEndpoint>[];

      for (final item in decodeResult['modelos']) {
        result.add(
          ModelEndpoint.fromJson(item),
        );
      }
      return result;
    } on Exception catch (e) {
      log('$e');
      return null;
    }
  } else {
    return null;
  }
}
