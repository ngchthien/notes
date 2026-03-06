import 'package:flutter/cupertino.dart';
import 'package:notes_app/core/themes/app_colors.dart';

class ListNote extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onTap;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;

  const ListNote({
    super.key,
    required this.content,
    required this.title,
    required this.onTap,
    required this.isFavorite,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    // Chỉ lấy từ Context, không còn define màu riêng lẻ ở mọi nơi!
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: context.cardColor, // Gọi cực gọn nhờ Extension
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: context.mainText),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15, color: context.hintText, height: 1.3),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: onFavoriteTap,
              child: Icon(
                isFavorite ? CupertinoIcons.star_fill : CupertinoIcons.star,
                color: context.primaryColor,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoteDateHeader extends StatelessWidget {
  final String label;
  const NoteDateHeader({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: context.mainText,
        ),
      ),
    );
  }
}
