import 'package:intl/intl.dart';

enum CurrencyType {ko_KR, USD}
extension numberFormatInt on int {
  String comma() {
    final formatter = NumberFormat("###,###,###,###,###");
    return formatter.format(this);
  }

  String currencyMoney({CurrencyType locale = CurrencyType.ko_KR}) {
    var formatter = NumberFormat.currency();
    switch(locale) {
      case CurrencyType.USD :
        formatter = NumberFormat.currency(symbol: "\$");
        break;
      default:
        formatter = NumberFormat.currency(locale: "ko_KR", symbol: "￦");
    }
    return formatter.format(this);
  }

  String digits() {
    var calculatedNumber = this.toDouble();
    if (calculatedNumber >= 0) {
      return _upperDigits(calculatedNumber);
    } else {
      return _lowerDigits(calculatedNumber);
    }
  }

  String _upperDigits(double number) {
    var calculatedNumber = number;
    if (calculatedNumber / 1000 < 1) {
      return calculatedNumber.toInt().toString();
    }
    calculatedNumber /= 1000;
    if (calculatedNumber / 1000 < 1) {
      return calculatedNumber.toStringAsFixed(1) + "k";
    }
    calculatedNumber /= 1000;
    if (calculatedNumber / 1000 < 1) {
      return calculatedNumber.toStringAsFixed(1) + "m";
    }
    calculatedNumber /= 1000;
    return calculatedNumber.toStringAsFixed(1) + "t";
  }

  String _lowerDigits(double number) {
    var calculatedNumber = number;
    if (calculatedNumber / 1000 > -1) {
      return calculatedNumber.toInt().toString();
    }
    calculatedNumber /= 1000;
    if (calculatedNumber / 1000 > -1) {
      return calculatedNumber.toStringAsFixed(1) + "k";
    }
    calculatedNumber /= 1000;
    if (calculatedNumber / 1000 > -1) {
      return calculatedNumber.toStringAsFixed(1) + "m";
    }
    calculatedNumber /= 1000;
    return calculatedNumber.toStringAsFixed(1) + "t";
  }
}

extension numberFormatDouble on double {
  String comma() {
    final formatter = NumberFormat("###,###,###,###,###");
    return formatter.format(this);
  }

  String currencyMoney({CurrencyType locale = CurrencyType.ko_KR}) {
    var formatter = NumberFormat.currency();
    switch(locale) {
      case CurrencyType.USD :
        formatter = NumberFormat.currency(locale: "en_US", symbol: "\$", decimalDigits: 0);
        break;
      default:
        formatter = NumberFormat.currency(locale: "ko_KR", symbol: "￦", decimalDigits: 0);
    }
    return formatter.format(this);
  }

  String digits() {
    var calculatedNumber = this;
    if (calculatedNumber >= 0) {
      return _upperDigits(calculatedNumber);
    } else {
      return _lowerDigits(calculatedNumber);
    }
  }

  String _upperDigits(double number) {
    var calculatedNumber = number;
    if (calculatedNumber / 1000 < 1) {
      return calculatedNumber.toInt().toString();
    }
    calculatedNumber /= 1000;
    if (calculatedNumber / 1000 < 1) {
      return calculatedNumber.toStringAsFixed(1) + "k";
    }
    calculatedNumber /= 1000;
    if (calculatedNumber / 1000 < 1) {
      return calculatedNumber.toStringAsFixed(1) + "m";
    }
    calculatedNumber /= 1000;
    return calculatedNumber.toStringAsFixed(1) + "t";
  }

  String _lowerDigits(double number) {
    var calculatedNumber = number;
    if (calculatedNumber / 1000 > -1) {
      return calculatedNumber.toInt().toString();
    }
    calculatedNumber /= 1000;
    if (calculatedNumber / 1000 > -1) {
      return calculatedNumber.toStringAsFixed(1) + "k";
    }
    calculatedNumber /= 1000;
    if (calculatedNumber / 1000 > -1) {
      return calculatedNumber.toStringAsFixed(1) + "m";
    }
    calculatedNumber /= 1000;
    return calculatedNumber.toStringAsFixed(1) + "t";
  }
}
