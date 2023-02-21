part of thecheat_flutter;


class FraudSearchResponse {
  int? _resultCode;
  String? _message;
  String? _searchKeyword;
  FraudSearchType? _keywordType;
  String? _bankCode;
  bool? _caution;
  String? _addInfo;
  DateTime? _searchStartTime;
  DateTime? _searchEndTime;
  String? _keywordURL;

  int? get resultCode => _resultCode;
  String? get message => _message;
  String? get searchKeyword => _searchKeyword;
  FraudSearchType? get keywordType => _keywordType;
  String? get bankCode => _bankCode;
  bool? get caution => _caution;
  String? get addInfo => _addInfo;
  DateTime? get searchStartTime => _searchStartTime;
  DateTime? get searchEndTime => _searchEndTime;
  String? get keywordURL => _keywordURL;



  FraudSearchResponse({
    int? resultCode,
    String? message,
    String? searchKeyword,
    FraudSearchType? keywordType,
    String? bankCode,
    bool? caution,
    String? addInfo,
    DateTime? searchStartTime,
    DateTime? searchEndTime,
    String? keywordURL,
  }){
    _resultCode = resultCode;
    _message = message;
    _searchKeyword = searchKeyword;
    _keywordType = keywordType;
    _bankCode = bankCode;
    _caution = caution;
    _addInfo = addInfo;
    _searchStartTime = searchStartTime;
    _searchEndTime = searchEndTime;
    _keywordURL = keywordURL;
  }

  FraudSearchResponse.fromJson(dynamic json) {
    _resultCode = json['result_code'];
    _message = json['result_msg'];
    _searchKeyword = json['keyword'];
    _keywordType = (json['keyword_type']).toString().convertFraudSearchType;
    _bankCode = json['bank_code'];
    _caution = (json['caution'] == "Y" ? true : false);
    _addInfo = json['add_info'];
    _searchStartTime = _convertDateTimeFromString(json['date_start']);
    _searchEndTime = _convertDateTimeFromString(json['date_end']);
    _keywordURL = json['keyword_url'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['result_code'] = _resultCode;
    map['result_msg'] = _message;
    map['keyword'] = _searchKeyword;
    map['keyword_type'] = _keywordType!.convertStr;
    map['bank_code'] = _bankCode;
    map['caution'] = (_caution == true ? "Y" : "N");
    map['add_info'] = _addInfo;
    map['date_start'] = _searchStartTime;
    map['date_end'] = _searchEndTime;
    map['keyword_url'] = _keywordURL;

    return map;
  }

  _convertDateTimeFromString(String date) => DateTime.parse('${date.substring(0, 8)}T${date.substring(8)}');

}