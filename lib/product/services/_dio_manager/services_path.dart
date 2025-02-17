class ServicesPath {
  ServicesPath._();
  static final instance = ServicesPath._();
  final String baseUrl = "http://51.20.142.167:8080/";

  final String login = 'auth/login';
  final String loginRequest = 'auth/login-request';
  final String register = 'auth/register';
  final String valideCode = 'auth/validate-code';
  final String refreshToken = 'auth/refresh-token';

  final String field = 'api/field';
  final String fieldIslem = 'api/field-islem/field/';
  final String fieldIslemManuel = 'api/field-islem/manuel';
  
  final String notification = 'api/notification-settings';
  final String notificationBildirim = 'api/notification';

  final String products = 'api/bitki';



  final String news = 'api/news';
  final String advice = 'api/product';

  final String weather = 'api/weather';

  final String user = 'api/user';

  final String city = 'api/city';
  final String district = 'api/district/city/';
}
