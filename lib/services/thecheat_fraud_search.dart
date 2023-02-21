part of thecheat_flutter;

enum FraudSearchType {
  phone,
  account,
  none
}

extension FraudSearchTypeExtension on FraudSearchType {
  String get convertStr {
    switch (this) {
      case FraudSearchType.account: return "account";
      case FraudSearchType.phone: return "phone";
      default: return "";
    }
  }
}

extension ThecheatPluginTypeExtension on String {
  FraudSearchType get convertFraudSearchType {
    switch (this) {
      case "account":
        return FraudSearchType.account;
      case "phone":
        return FraudSearchType.phone;
      default:
        return FraudSearchType.none;
    }
  }
}


class ThecheatFraudSearch {

  Future<FraudSearchResponse> search(String keyword, FraudSearchType keywordType, {String? bankCode, String? addInfo}) async {
    try {
      Map requestData = {
        "keyword": keyword,
        "keyword_type": keywordType.convertStr
      };

      if (bankCode != null) { requestData.addAll({"bank_code": bankCode}); }
      if (addInfo != null) { requestData.addAll({"add_info": addInfo}); }

      Response response = await _dio.post(
        '/fraud/search',
        options: Options(contentType: "application/json"),
        data: requestData
      );

      Map responseData = response.data;
      responseData.addAll(_decryptData(responseData['content']));
      responseData.remove("content");

      FraudSearchResponse searchResponse = FraudSearchResponse.fromJson(responseData);


      return searchResponse;
    } catch (e) {
      return FraudSearchResponse.fromJson((e as DioError).response?.data);
    }
  }

  _decryptData(String encryptedData) {
    List<int> byteData = base64Decode(encryptedData);

    String ivLowData = base64Encode(byteData.sublist(0, 16));
    String encrypedLowData = base64Encode(byteData.sublist(16));

    final key = Key.fromUtf8(_encryptKey!);
    final iv = IV.fromBase64(ivLowData);

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    Encrypted enBase64 = Encrypted.fromBase64(encrypedLowData);
    final decryptedData = encrypter.decrypt(enBase64, iv: iv);

    return jsonDecode(decryptedData);
  }
}