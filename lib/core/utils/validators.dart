class AppValidators {
  // Phone number validation
  static bool isValidPhoneNumber(String value) {
    final cleanValue = value.replaceAll(RegExp(r'[()\s-]'), '');
    
    if (cleanValue.isEmpty) {
      return false;
    }
    
    if (cleanValue.length < 10) {
      return false;
    }
    
    // Turkish phone number pattern
    final phoneRegex = RegExp(r'^0?5[0-9]{9}$');
    return phoneRegex.hasMatch(cleanValue);
  }

  // Email validation
  static bool isValidEmail(String email) {
    if (email.isEmpty) {
      return false;
    }
    
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  // Password validation
  static bool isValidPassword(String password) {
    if (password.isEmpty) {
      return false;
    }
    
    if (password.length < 6) {
      return false;
    }
    
    return true;
  }

  // Name validation
  static bool isValidName(String name) {
    if (name.isEmpty) {
      return false;
    }
    
    if (name.length < 2) {
      return false;
    }
    
    final nameRegex = RegExp(r'^[a-zA-ZğüşıöçĞÜŞİÖÇ\s]+$');
    return nameRegex.hasMatch(name);
  }

  // Field name validation
  static bool isValidFieldName(String fieldName) {
    if (fieldName.isEmpty) {
      return false;
    }
    
    if (fieldName.length < 2) {
      return false;
    }
    
    if (fieldName.length > 50) {
      return false;
    }
    
    return true;
  }

  // Area validation (for field size)
  static bool isValidArea(String area) {
    if (area.isEmpty) {
      return false;
    }
    
    final areaValue = double.tryParse(area);
    if (areaValue == null) {
      return false;
    }
    
    if (areaValue <= 0 || areaValue > 10000) {
      return false;
    }
    
    return true;
  }

  // Required field validation
  static bool isRequired(String value) {
    return value.trim().isNotEmpty;
  }

  // Verification code validation
  static bool isValidVerificationCode(String code) {
    if (code.isEmpty) {
      return false;
    }
    
    if (code.length != 4) {
      return false;
    }
    
    final codeRegex = RegExp(r'^[0-9]{4}$');
    return codeRegex.hasMatch(code);
  }

  // Format phone number for API
  static String formatPhoneNumber(String value) {
    return value.replaceAll(RegExp(r'[()\s-]'), '');
  }

  // Clean string input
  static String cleanString(String value) {
    return value.trim();
  }

  // Get validation error message
  static String getPhoneNumberError() {
    return "Lütfen geçerli bir cep telefonu numarası giriniz.";
  }

  static String getEmailError() {
    return "Lütfen geçerli bir e-posta adresi giriniz.";
  }

  static String getPasswordError() {
    return "Şifre en az 6 karakter olmalıdır.";
  }

  static String getNameError() {
    return "Lütfen geçerli bir isim giriniz.";
  }

  static String getFieldNameError() {
    return "Tarla adı 2-50 karakter arasında olmalıdır.";
  }

  static String getAreaError() {
    return "Lütfen geçerli bir alan değeri giriniz (0-10000).";
  }

  static String getRequiredError() {
    return "Bu alan zorunludur.";
  }

  static String getVerificationCodeError() {
    return "Lütfen 4 haneli doğrulama kodunu giriniz.";
  }
}
