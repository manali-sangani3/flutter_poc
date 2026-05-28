class SecurityUtils {
  static String maskCard(String cardNumber) {
    return "**** **** **** ${cardNumber.substring(cardNumber.length - 4)}";
  }

  static String maskEmail(String email) {
    final parts = email.split('@');

    return "${parts[0][0]}****@${parts[1]}";
  }
}
