import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

Widget buildPhoneField({
  required TextEditingController phoneController,
  required BuildContext context,
  required Function(Country) onCountrySelected,
  Country? selectedCountry,
}) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFF7F8F9),
      borderRadius: BorderRadius.circular(28),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Row(
      children: [
        GestureDetector(
          onTap: () {
            showCountryPicker(
              context: context,
              showPhoneCode: true,
              onSelect: (Country country) {
                onCountrySelected(country);
              },
            );
          },
          child: Row(
            children: [
              Text(
                selectedCountry?.flagEmoji ?? '🇬🇧',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.keyboard_arrow_down_outlined,
                color: Colors.black54,
                size: 22,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Container(height: 24, width: 1.2, color: Colors.grey.shade300),
        const SizedBox(width: 16),
        Expanded(
          child: TextField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              hintText: 'Your number',
              hintStyle: TextStyle(
                color: Color(0xFFBDBDBD),
                fontSize: 16,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 20),
            ),
          ),
        ),
      ],
    ),
  );
}