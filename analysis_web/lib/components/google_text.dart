import 'package:flutter/material.dart';

class GoogleText extends StatelessWidget {
  final String textBefore;
  final String textAfter;
  final bool chrome;
  final bool bold;
  final bool boldGoogle;
  final bool period;
  final bool periodGoogle;

  const GoogleText({
    super.key,
    this.textBefore = '',
    this.textAfter = '',
    this.chrome = false,
    this.bold = false,
    this.boldGoogle = false,
    this.period = false,
    this.periodGoogle = false,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$textBefore ',
            style: TextStyle(
              color: Colors.grey.shade800,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          TextSpan(
            text: 'G',
            style: TextStyle(
              color: Color(0xFF4285F4),
              fontWeight: boldGoogle ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          TextSpan(
            text: 'o',
            style: TextStyle(
              color: Color(0xFFDB4437),
              fontWeight: boldGoogle ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          TextSpan(
            text: 'o',
            style: TextStyle(
              color: Color(0xFFF4B400),
              fontWeight: boldGoogle ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          TextSpan(
            text: 'g',
            style: TextStyle(
              color: Color(0xFF4285F4),
              fontWeight: boldGoogle ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          TextSpan(
            text: 'l',
            style: TextStyle(
              color: Color(0xFF0F9D58),
              fontWeight: boldGoogle ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          TextSpan(
            text: 'e ',
            style: TextStyle(
              color: Color(0xFFDB4437),
              fontWeight: boldGoogle ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (chrome)
            TextSpan(
              text: 'Chrome',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: boldGoogle ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          if (periodGoogle)
            TextSpan(
              text: '. ',
              style: TextStyle(
                color: Colors.grey.shade800,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          TextSpan(
            text: ' $textAfter',
            style: TextStyle(
              color: Colors.grey.shade800,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (period)
            TextSpan(
              text: '.',
              style: TextStyle(
                color: Colors.grey.shade800,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
        ],
      ),
    );
  }
}
