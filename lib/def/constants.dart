export 'constants.dart';

import 'package:codelabs_task/data/model/data_model.dart';

Map<String, dynamic> romanNumeralMap = {"number": 1, "roman": "I"};
RomanNumeral romanNumeralSample = RomanNumeral.fromJson(romanNumeralMap);
List<RomanNumeral> romanNumeralsList = [];
String sInvalidInput = 'Invalid input';
List<int> values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
List<String> romanLiterals = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"];
List<int> previousInputs = [];
