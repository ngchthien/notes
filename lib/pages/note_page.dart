import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notes_app/core/themes/app_colors.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/providers/note_provider.dart';

class NotePage extends HookConsumerWidget {
  final Note? note;
  const NotePage({super.key, this.note});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController(text: note?.title);
    final contentController = useTextEditingController(text: note?.content);

    void saveNote() {
      if (note == null) {
        ref.read(noteProvider.notifier).addNote(
              titleController.text.trim(),
              contentController.text.trim(),
            );
      } else {
        ref.read(noteProvider.notifier).updateNote(
              note!,
              titleController.text.trim(),
              contentController.text.trim(),
            );
      }
      Navigator.pop(context);
    }

    return CupertinoPageScaffold(
      backgroundColor: context.cardColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: context.cardColor.withOpacity(0.8),
        border: null,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(CupertinoIcons.left_chevron,
                  color: context.primaryColor, size: 22),
              Text('Ghi chú',
                  style: TextStyle(color: context.primaryColor, fontSize: 17)),
            ],
          ),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => saveNote(),
          child: Text('Xong',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: context.primaryColor,
                  fontSize: 17)),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CupertinoTextField(
              controller: titleController,
              cursorColor: context.primaryColor,
              style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: context.mainText,
                  letterSpacing: -0.5),
              placeholder: "Tiêu đề",
              placeholderStyle: TextStyle(color: context.hintText),
              decoration: null,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              maxLines: null,
            ),
            Expanded(
              child: CupertinoTextField(
                controller: contentController,
                cursorColor: context.primaryColor,
                style: TextStyle(
                    fontSize: 17, height: 1.4, color: context.mainText),
                placeholder: "Ghi chú",
                placeholderStyle: TextStyle(color: context.hintText),
                decoration: null,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
