import 'package:flutter/material.dart';

// ملاحظة: هذا الكود يفترض وجود ملف صورة الخلفية باسم 'assets/images/background.png'
// وتكون مضافة في pubspec.yaml

class PasswordRecoveryCodeScreen extends StatefulWidget {
  const PasswordRecoveryCodeScreen({super.key});

  @override
  State<PasswordRecoveryCodeScreen> createState() => _PasswordRecoveryCodeScreenState();
}

class _PasswordRecoveryCodeScreenState extends State<PasswordRecoveryCodeScreen> {
  // للتحكم في حقول الإدخال الأربعة (النقاط الزرقاء)
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(4, (index) => TextEditingController());

  @override
  void dispose() {
    // تنظيف الموارد
    for (var node in _focusNodes) { node.dispose(); }
    for (var controller in _controllers) { controller.dispose(); }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. الطبقة الأولى: صورة الخلفية (نفسها من الشاشة الأولى)
          Positioned.fill(
            child: Image.asset(
              'assets/images/new_pass_bg.png', // <-- مسار صورتك
              fit: BoxFit.cover,
            ),
          ),

          // 2. الطبقة الثانية: كل العناصر الأساسية
          Column(
            children: [
              const SizedBox(height: 50), // مسافة للـ StatusBar
              const SizedBox(height: 80), // مسافة لتنزل الـ Profile Icon

              // أيقونة الملف الشخصي
              const Center(
                child: ProfileAvatar(),
              ),

              const SizedBox(height: 30),

              // العنوان الرئيسي
              const Text(
                'Password Recovery',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 10),

              // النص التوضيحي
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Enter 4-digits code we sent you on your phone number',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // رقم الهاتف (مموه)
              const Text(
                '+98*******00',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 30),

              // حقول إدخال الرمز (الأربع نقاط)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) => _buildCodeField(index)),
                ),
              ),

              const Spacer(), // يزق اللي تحت لآخر الصفحة

              // زر "Send Again" (لون وردي)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.pink[400], // اللون الوردي
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Send Again',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // زر "Cancel"
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // للرجوع للخلف
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(height: 10), // مسافة من الـ Home Bar
            ],
          ),
        ],
      ),
    );
  }

  // ويدجت لحقل إدخال واحد من الرمز
  Widget _buildCodeField(int index) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.blue[50], // لون فاتح للنقطة
        shape: BoxShape.circle, // شكل دائري
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1, // رقم واحد فقط
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
        decoration: const InputDecoration(
          counterText: "", // إخفاء عداد الحروف
          border: InputBorder.none, // إخفاء الإطار
        ),
        onChanged: (value) {
          // للانتقال تلقائياً للحقل التالي عند الإدخال
          if (value.isNotEmpty && index < 3) {
            _focusNodes[index + 1].requestFocus();
          }
          // للانتقال للحقل السابق عند الحذف
          if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }
}

// ويدجت أيقونة الملف الشخصي (نفسها من الكود الأول)
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[100],
      ),
      child: Container(
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: const Icon(
          Icons.person,
          size: 70,
          color: Colors.grey,
        ),
      ),
    );
  }
}