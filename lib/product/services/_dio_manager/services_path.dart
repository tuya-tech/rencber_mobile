class ServicesPath {
  ServicesPath._();
  static final instance = ServicesPath._();
  // final String baseUrl = "http://localhost:8080/";
  final String baseUrl = "http://51.20.156.95:8080/";

  final String login = 'auth/login';
  final String loginRequest = 'auth/login-request';
  final String register = 'auth/register';
  final String valideCode = 'auth/validate-code';
  final String refreshToken = 'auth/refresh-token';

  final String field = 'api/field';
  final String fieldIslem = 'api/field-islem/field/';
  final String fieldIslemManuel = 'api/field-islem/manuel';
  final String fieldIslemOtlanma = 'api/field-islem/otlanma/field/';
  final String fieldIslemBuyume = 'api/field-islem/evre/field/';
  final String fieldIslemHastalik = 'api/field-islem/hastalik/field/';

  final String notificationSettings = 'api/notification-settings';
  final String notificationBildirim = 'api/notification';

  final String products = 'api/bitki';

  final String news = 'api/news';
  final String advice = 'api/product';

  final String weather = 'api/weather';

  final String user = 'api/user';

  final String city = 'api/city';
  final String district = 'api/district/city/';
}
