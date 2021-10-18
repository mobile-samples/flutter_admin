class GlobalData {
  static String token = '';

  static Map<String, String> buildHeader() {
    if (token.isNotEmpty) {
      return {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token,
      };
    }
    return {
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }
}
