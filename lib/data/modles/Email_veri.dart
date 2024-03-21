import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailVerificationResponse {
  final bool success;
  final String? errorMessage;

  EmailVerificationResponse({required this.success, this.errorMessage});

  factory EmailVerificationResponse.fromJson(Map<String, dynamic> json) {
    return EmailVerificationResponse(
      success: json['success'],
      errorMessage: json['error'],
    );
  }
}

class EmailVerificationAPI {
  static const String _baseUrl = 'your_api_base_url';

  static Future<EmailVerificationResponse> verifyEmail(String email, String verificationCode) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/RecoverVerifyEmail'),
        body: json.encode({'email': email, 'verification_code': verificationCode}),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return EmailVerificationResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to verify email: ${response.reasonPhrase}');
      }
    } catch (e) {
      return EmailVerificationResponse(success: false, errorMessage: e.toString());
    }
  }
}
