import 'package:flutter_paystack/src/common/exceptions.dart';
import 'package:flutter_paystack/src/common/my_strings.dart';
import 'package:flutter_paystack/src/models/card.dart';
import 'package:flutter_paystack/src/widgets/checkout/bank_checkout.dart';

class Charge {
  PaymentCard card;

  /// The email of the customer
  String email;
  String _accessCode;
  BankAccount _account;

  /// Amount to pay in base currency. Must be a valid positive number
  int amount = 0;
  Map<String, dynamic> _metadata;
  List<Map<String, dynamic>> _customFields;
  bool _hasMeta = false;
  Map<String, String> _additionalParameters;
  int _transactionCharge = 0;
  String _subAccount;
  String _reference;
  Bearer _bearer;
  String _currency;
  String _plan;
  bool _localStarted = false;
  bool _remoteStarted = false;

  /// The locale used for formatting amount in the UI prompt. Defaults to [Strings.nigerianLocale]
  String locale;

  Charge() {
    this._metadata = {};
    this.amount = -1;
    this._additionalParameters = {};
    this._customFields = [];
    this._metadata['custom_fields'] = this._customFields;
    this.locale = Strings.nigerianLocale;
    this._currency = Strings.ngn;
  }

  addParameter(String key, String value) {
    this._additionalParameters[key] = value;
  }

  Map<String, String> get additionalParameters => _additionalParameters;

  String get accessCode => _accessCode;

  set accessCode(String value) {
    _accessCode = value;
  }

  String get plan => _plan;

  set plan(String value) {
    _plan = value;
  }

  String get currency => _currency;

  /// ISO 4217 payment currency code (e.g USD). Defaults to [Strings.ngn].
  ///
  /// If you're setting this value, also set [locale] for better formatting.
  set currency(String value) {
    _currency = value;
  }

  String get reference => _reference;

  set reference(String value) {
    _reference = value;
  }

  int get transactionCharge => _transactionCharge;

  set transactionCharge(int value) {
    _transactionCharge = value;
  }

  Bearer get bearer => _bearer;

  /// Who bears Paystack charges? [Bearer.Account] or [Bearer.SubAccount]
  set bearer(Bearer value) {
    _bearer = value;
  }

  String get subAccount => _subAccount;

  set subAccount(String value) {
    _subAccount = value;
  }

  BankAccount get account => _account;

  set account(BankAccount value) {
    if (value == null) {
      // Precaution to avoid setting of this field outside the library
      throw new PaystackException('account cannot be null');
    }
    _account = value;
  }

  putMetaData(String name, dynamic value) {
    this._metadata[name] = value;
    this._hasMeta = true;
  }

  putCustomField(String displayName, String value) {
    var customMap = {
      'value': value,
      'display_name': displayName,
      'variable_name':
          displayName.toLowerCase().replaceAll(new RegExp(r'[^a-z0-9 ]'), "_")
    };
    this._customFields.add(customMap);
    this._hasMeta = true;
  }

  String get metadata {
    if (!_hasMeta) {
      return null;
    }

    return _metadata.toString();
  }
}

enum Bearer {
  Account,
  SubAccount,
}
