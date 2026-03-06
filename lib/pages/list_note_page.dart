import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/core/themes/app_colors.dart';
import 'package:notes_app/providers/note_provider.dart';
import 'package:notes_app/widgets/list_note.dart';
import 'package:notes_app/widgets/text_field_search.dart';

class ListNotePage extends ConsumerWidget {
  const ListNotePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupedNotes = ref.watch(groupedNotesProvider);

    return CupertinoPageScaffold(
      backgroundColor:
          context.scaffoldBackgroundColor, // Cực gọn nhờ System Theme
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              CupertinoSliverNavigationBar(
                largeTitle:
                    Text('Ghi chú', style: TextStyle(color: context.mainText)),
                backgroundColor:
                    context.scaffoldBackgroundColor.withOpacity(0.8),
                border: null,
              ),
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const TextFieldSearch(),
                    const SizedBox(height: 16),
                    ...groupedNotes.entries.expand((entry) {
                      return [
                        NoteDateHeader(label: entry.key),
                        ...entry.value.map((note) {
                          final displayTitle =
                              (note.title?.trim().isEmpty ?? true)
                                  ? "Ghi chú mới"
                                  : note.title!;
                          final displayContent =
                              (note.content?.trim().isEmpty ?? true)
                                  ? "Không có nội dung"
                                  : note.content!;
                          return ListNote(
                            key: ValueKey(note.id),
                            title: displayTitle,
                            content: displayContent,
                            onTap: () => context.push('/note', extra: note),
                            isFavorite: note.isFavorite,
                            onFavoriteTap: () => ref
                                .read(noteProvider.notifier)
                                .toggleFavorite(note),
                          );
                        }),
                        const SizedBox(height: 12),
                      ];
                    }),
                  ]),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 30,
            right: 20,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => context.push('/note'),
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: context.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: CupertinoColors.systemGrey.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4)),
                  ],
                ),
                child: Icon(CupertinoIcons.pencil_outline,
                    color: context.primaryColor, size: 26),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
