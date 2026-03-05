import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notes_app/widgets/list_note.dart';
import 'package:notes_app/widgets/text_field_search.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ghi chú',
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 28),
        ),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_horiz,
                color: Colors.grey[700],
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextFieldSearch(),
            const SizedBox(height: 16),
            ListNote(
              title: 'Title',
              content: 'Content',
            ),
            ListNote(
              title: 'Title',
              content: 'Content',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {},
        child: Icon(
          Icons.edit_calendar_outlined,
          color:  Colors.grey[700],
        ),
      ),
    );
  }
}
