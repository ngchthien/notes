import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/core/themes/app_colors.dart';

class TextFieldSearch extends StatelessWidget {
  const TextFieldSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/search'),
      child: AbsorbPointer(
        child: CupertinoSearchTextField(
          placeholder: 'Tìm kiếm',
          style: TextStyle(
            fontSize: 17,
            color: context.mainText,
            letterSpacing: -0.4,
          ),
          placeholderStyle: TextStyle(
            color: context.hintText,
            fontSize: 17,
            letterSpacing: -0.4,
          ),
          backgroundColor:
              CupertinoColors.tertiarySystemFill.resolveFrom(context),
          borderRadius: BorderRadius.circular(10),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        ),
      ),
    );
  }
}
