import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

// Hàm gửi mã xác nhận về email
Future<void> sendVerificationCode(String emailAddress, String verificationCode) async {
  // Thay các thông tin của bạn vào đây
  final username = 'lekhoi0702@gmail.com';
  final password = 'chzxynglbhzhtzel';

  // Thiết lập SMTP server của Gmail
  final smtpServer = gmail(username, password);

  // Tạo mail
  final message = Message()
    ..from = Address(username,'Online Medical')
    ..recipients.add(emailAddress) // Địa chỉ email nhận mã xác nhận
    ..subject = 'Xác nhận mã đổi mật khẩu'
    ..text = 'Mã xác nhận của bạn là: $verificationCode'; // Nội dung email

  try {
    final sendReport = await send(message, smtpServer);
    if (sendReport != null ) {
      print('Mail sent to $emailAddress');
    } else {
      throw Exception('Failed to send verification code to email.');
    }
  } catch (e) {
    print('Error sending mail: $e');
    throw Exception('Failed to send verification code to email.');
  }
}
