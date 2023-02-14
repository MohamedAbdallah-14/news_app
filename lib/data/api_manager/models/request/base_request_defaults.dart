class BaseRequestDefaults {
  BaseRequestDefaults._();
  static final _instance = BaseRequestDefaults._();
  static BaseRequestDefaults get instance => _instance;

  final header = <String, String>{};
  Map<String, String> token = <String, String>{};
  String baseUrl = '';

  void addHeader(String key, String value) => header.addAll({key: value});
  void addHeaders(Map<String, String> headers) => header.addAll(headers);
  void updateHeader(String key, String value) =>
      header.update(key, (v) => value);
  void removeHeader(String key) => header.remove(key);
  void setLanguage(String language) =>
      header.addAll({'Accept-Language': language});
  void setToken(String token) =>
      this.token = {'Authorization': 'Bearer $token'};
}
