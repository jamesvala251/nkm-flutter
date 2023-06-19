class ApiUrls {
  //TODO Development - Server
  static const String baseUrl = 'http://3.6.39.35/api/';
  //TODO Live - Server
  // static const String baseUrl = 'https://nkmnosepinsllp.com/api/';

  static const Map<String, String> xWwwFromUrlEncodedHeader = {
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  static const Map<String, String> applicationJsonHeader = {
    'Content-Type': 'application/json'
  };

  static const Map<String, String> multipartFormDataHeader = {
    'Content-Type': 'multipart/form-data'
  };
}
