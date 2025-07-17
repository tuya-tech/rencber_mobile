enum ExceptionCode {
  kvkkNotAccepted("KVKK-0001"),
  idNotFound("ID-1001"),
  idIsNull("ID-1002"),
  userNotFound("USER-1001"),
  phoneAlreadyExist("PHONE-1001"),
  phoneAlreadyApproved("PHONE-1002"),
  invalidPhoneNumber("PHONE-1003"),
  phoneNotApproved("PHONE-1004"),
  invalidCode("CODE-1001"),
  expiredCode("CODE-1002"),
  validCode("CODE-1003"),
  districtNotInCity("DISTRICT-1001"),
  fieldNotFound("FIELD-1001"),
  fieldHasNoActiveEkim("FIELD-1002"),
  fieldAlreadyHasOutline("FIELD-1003"),
  fieldIslemNotCorrect("FIELD-1004"),
  bitkiNotFound("BITKI-1001"),
  bitkiBuyumeEvreNotFound("BITKI-BUYUME-EVRE-1001"),
  bitkiBuyumeEvreInvalidDefinition("BITKI-BUYUME-EVRE-1002"),
  weatherNotFound("WEATHER-1001"),
  notificationAlreadyExist("NOTIFICATION-SETTINGS-1001"),
  invalidCredentials("USER-8001"),
  unauthorized("USER-9001"),
  fileUploadFailed("SERVER-1001"),
  invalidData("DATA-0001");

  const ExceptionCode(this.code);

  final String code;

  static ExceptionCode? fromCode(String code) {
    for (ExceptionCode exception in ExceptionCode.values) {
      if (exception.code == code) {
        return exception;
      }
    }
    return null;
  }
}

class ApiException implements Exception {
  final ExceptionCode exceptionCode;
  final String message;

  const ApiException({
    required this.exceptionCode,
    required this.message,
  });

  factory ApiException.fromCode(String code, String message) {
    final exceptionCode = ExceptionCode.fromCode(code);
    return ApiException(
      exceptionCode: exceptionCode ?? ExceptionCode.invalidData,
      message: message,
    );
  }

  String getLocalizedMessage() {
    switch (exceptionCode) {
      case ExceptionCode.kvkkNotAccepted:
        return "KVKK sözleşmesi kabul edilmelidir";
      case ExceptionCode.idNotFound:
        return "ID bulunamadı";
      case ExceptionCode.idIsNull:
        return "ID boş olamaz";
      case ExceptionCode.userNotFound:
        return "Kullanıcı bulunamadı";
      case ExceptionCode.phoneAlreadyExist:
        return "Bu telefon numarası zaten kayıtlı";
      case ExceptionCode.phoneAlreadyApproved:
        return "Telefon numarası zaten onaylanmış";
      case ExceptionCode.invalidPhoneNumber:
        return "Geçersiz telefon numarası";
      case ExceptionCode.phoneNotApproved:
        return "Telefon numarası onaylanmamış";
      case ExceptionCode.invalidCode:
        return "Geçersiz kod";
      case ExceptionCode.expiredCode:
        return "Kodun süresi dolmuş";
      case ExceptionCode.validCode:
        return "Kod geçerli, lütfen tekrar deneyiniz";
      case ExceptionCode.districtNotInCity:
        return "İlçe bu şehre ait değil";
      case ExceptionCode.fieldNotFound:
        return "Tarla bulunamadı";
      case ExceptionCode.fieldHasNoActiveEkim:
        return "Tarlada aktif ekim bulunmuyor";
      case ExceptionCode.fieldAlreadyHasOutline:
        return "Tarla zaten çizilmiş";
      case ExceptionCode.fieldIslemNotCorrect:
        return "Tarla işlemi doğru değil";
      case ExceptionCode.bitkiNotFound:
        return "Bitki bulunamadı";
      case ExceptionCode.bitkiBuyumeEvreNotFound:
        return "Bitki büyüme evresi bulunamadı";
      case ExceptionCode.bitkiBuyumeEvreInvalidDefinition:
        return "Bitki büyüme evresi tanımı geçersiz";
      case ExceptionCode.weatherNotFound:
        return "Hava durumu bilgisi bulunamadı";
      case ExceptionCode.notificationAlreadyExist:
        return "Bildirim ayarı zaten mevcut";
      case ExceptionCode.invalidCredentials:
        return "Geçersiz kullanıcı bilgileri";
      case ExceptionCode.unauthorized:
        return "Yetkisiz erişim";
      case ExceptionCode.fileUploadFailed:
        return "Dosya yükleme başarısız";
      case ExceptionCode.invalidData:
        return "Geçersiz veri";
    }
  }

  @override
  String toString() {
    return 'ApiException(code: ${exceptionCode.code}, message: $message)';
  }
}

class ExceptionHandler {
  static String handleException(String errorCode, [String? customMessage]) {
    final exceptionCode = ExceptionCode.fromCode(errorCode);
    
    if (exceptionCode != null) {
      final apiException = ApiException(
        exceptionCode: exceptionCode,
        message: customMessage ?? exceptionCode.name,
      );
      return apiException.getLocalizedMessage();
    }
    
    return customMessage ?? "Bilinmeyen bir hata oluştu";
  }
}
