extension ToArabicNumberExtension on int {
  String toArabicNumber() {
    if (this == 0) {
      return '٠';
    }

    int number = this;

    // Arabic numerals Unicode characters start from 0x0660 to 0x0669
    final List<String> arabicNumerals = [
      '٠',
      '١',
      '٢',
      '٣',
      '٤',
      '٥',
      '٦',
      '٧',
      '٨',
      '٩'
    ];

    final StringBuffer buffer = StringBuffer();
    // Convert each digit of the number to Arabic numeral Unicode character
    while (number > 0) {
      final int digit = number % 10;
      buffer.write(arabicNumerals[digit]);
      number ~/= 10;
    }
    // Reverse the buffer since we are constructing the number from least significant digit
    return buffer.toString().split('').reversed.join('');
  }
}
