import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/core/themes/app_colors.dart';
import 'package:notes_app/providers/note_provider.dart';
import 'package:notes_app/widgets/list_note.dart';

class FavoritePage extends ConsumerWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupedNotes = ref.watch(groupedFavoriteNotesProvider);

    return CupertinoPageScaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle:
                Text('Quan Trọng', style: TextStyle(color: context.mainText)),
            backgroundColor: context.scaffoldBackgroundColor.withOpacity(0.8),
            border: null,
          ),
          groupedNotes.isEmpty
              ? SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'Chưa có ghi chú yêu thích',
                      style: TextStyle(color: context.hintText, fontSize: 17),
                    ),
                  ),
                )
              : SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
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
    );
  }
}
