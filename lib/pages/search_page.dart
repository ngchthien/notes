import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notes_app/core/themes/app_colors.dart';
import 'package:notes_app/providers/note_provider.dart';
import 'package:notes_app/widgets/list_note.dart';

class SearchPage extends HookConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResults = ref.watch(searchResultsProvider);
    final controller = useTextEditingController();
    final focusNode = useFocusNode();

    useEffect(() {
      focusNode.requestFocus();
      return null;
    }, []);

    return CupertinoPageScaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        backgroundColor: context.scaffoldBackgroundColor.withOpacity(0.8),
        border: null,
        middle: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: CupertinoSearchTextField(
            controller: controller,
            focusNode: focusNode,
            placeholder: 'Tìm kiếm',
            onChanged: (text) =>
                ref.read(searchQueryProvider.notifier).setQuery(text),
            onSuffixTap: () {
              controller.clear();
              ref.read(searchQueryProvider.notifier).setQuery("");
            },
            style: TextStyle(fontSize: 17, color: context.mainText),
            placeholderStyle: TextStyle(color: context.hintText),
            backgroundColor:
                CupertinoColors.tertiarySystemFill.resolveFrom(context),
          ),
        ),
        trailing: CupertinoButton(
          padding: const EdgeInsets.only(left: 8),
          onPressed: () {
            ref.read(searchQueryProvider.notifier).setQuery("");
            context.pop();
          },
          child: Text('Hủy',
              style: TextStyle(color: context.primaryColor, fontSize: 17)),
        ),
      ),
      child: SafeArea(
        child: searchResults.isEmpty && controller.text.isNotEmpty
            ? Center(
                child: Text(
                  'Không tìm thấy kết quả',
                  style: TextStyle(color: context.hintText, fontSize: 17),
                ),
              )
            : controller.text.isEmpty
                ? const SizedBox.shrink()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final note = searchResults[index];
                      return ListNote(
                        content: note.content ?? "",
                        title: note.title ?? "Ghi chú mới",
                        onTap: () => context.push('/note', extra: note),
                        isFavorite: note.isFavorite,
                        onFavoriteTap: () => ref
                            .read(noteProvider.notifier)
                            .toggleFavorite(note),
                      );
                    },
                  ),
      ),
    );
  }
}
