import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextFieldSearch extends ConsumerWidget {
  const TextFieldSearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Tìm kiếm",
        hintStyle: const TextStyle(
          color: Color(0xff8E9AA9),
          fontSize: 16,
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: Color(0xff8E9AA9),
        ),
        filled: true,
        fillColor: const Color(0xffEEF1F5),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),

        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
        ),
      ),
    );
  }
}