import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:journey/core/time/day.dart';
import 'package:journey/data/db/app_db.dart';
import 'package:journey/providers.dart';
import 'package:journey/ui/view_entry/entry_detail_page.dart';
import 'package:drift/drift.dart' hide Column;

final _searchResultsProvider =
    FutureProvider.family<List<Entry>, String>((ref, query) async {
  final db = ref.read(dbProvider);
  final q = db.select(db.entries)
    ..where((t) => t.textContent.contains(query))
    ..orderBy([(t) => OrderingTerm(expression: t.day, mode: OrderingMode.desc)]);
  return q.get();
});

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final asyncResults =
        _query.trim().isEmpty ? null : ref.watch(_searchResultsProvider(_query.trim()));

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search your entries…',
          ),
          textInputAction: TextInputAction.search,
          onChanged: (value) => setState(() => _query = value),
        ),
      ),
      body: _buildBody(context, asyncResults),
    );
  }

  Widget _buildBody(
    BuildContext context,
    AsyncValue<List<Entry>>? asyncResults,
  ) {
    if (asyncResults == null) {
      return const Center(
        child: Text('Type a keyword to search your journal.'),
      );
    }

    return asyncResults.when(
      data: (results) {
        if (results.isEmpty) {
          return const Center(child: Text('No matching entries found.'));
        }
        return ListView.separated(
          itemCount: results.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final e = results[index];
            final day = startOfDay(e.day);
            final dateLabel = DateFormat('EEE, MMM d').format(day);

            // Simple snippet: first 80 chars.
            final snippet = (e.textContent.length <= 80)
                ? e.textContent
                : '${e.textContent.substring(0, 80)}…';

            return ListTile(
              title: Text(dateLabel),
              subtitle: Text(
                snippet,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder<void>(
                    pageBuilder: (_, __, ___) => EntryDetailPage(day: day),
                    transitionsBuilder: (_, anim, __, child) {
                      return FadeTransition(opacity: anim, child: child);
                    },
                  ),
                );
              },
            );
          },
        );
      },
      error: (e, _) => Center(child: Text('Search failed: $e')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

