import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:journey/core/time/day.dart';
import 'package:journey/providers.dart';
import 'package:journey/ui/search/search_page.dart';
import 'package:journey/ui/view_entry/entry_detail_page.dart';
import 'package:journey/ui/widgets/pastel_backdrop.dart';

final _daysWithEntriesInMonthProvider =
    StreamProvider.family<Set<DateTime>, DateTime>((ref, month) {
  return ref.watch(entryRepositoryProvider).watchDaysWithEntriesInMonth(month);
});

final _monthThumbsProvider = StreamProvider.family<Map<DateTime, String>, DateTime>((ref, month) {
  return ref.watch(entryRepositoryProvider).watchMonthThumbnailPaths(month);
});

class CalendarTab extends ConsumerStatefulWidget {
  const CalendarTab({super.key});

  @override
  ConsumerState<CalendarTab> createState() => _CalendarTabState();
}

class _CalendarTabState extends ConsumerState<CalendarTab> {
  DateTime _month = DateTime(DateTime.now().year, DateTime.now().month, 1);

  @override
  Widget build(BuildContext context) {
    final daysAsync = ref.watch(_daysWithEntriesInMonthProvider(_month));
    final thumbsAsync = ref.watch(_monthThumbsProvider(_month));
    final today = startOfDay(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat('MMMM yyyy').format(_month)),
        actions: [
          IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder<void>(
                  pageBuilder: (_, __, ___) => const SearchPage(),
                  transitionsBuilder: (_, anim, __, child) {
                    return FadeTransition(opacity: anim, child: child);
                  },
                ),
              );
            },
          ),
          IconButton(
            tooltip: 'Previous month',
            onPressed: () => setState(() {
              _month = DateTime(_month.year, _month.month - 1, 1);
            }),
            icon: const Icon(Icons.chevron_left),
          ),
          IconButton(
            tooltip: 'Next month',
            onPressed: () => setState(() {
              _month = DateTime(_month.year, _month.month + 1, 1);
            }),
            icon: const Icon(Icons.chevron_right),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: PastelBackdrop(
        child: daysAsync.when(
          data: (daysWithEntries) {
            return RefreshIndicator(
              onRefresh: () async => Future<void>.delayed(const Duration(milliseconds: 250)),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                children: [
                  _WeekdayHeader(),
                  const SizedBox(height: 10),
                  thumbsAsync.when(
                    data: (thumbs) {
                      return _MonthGrid(
                        month: _month,
                        today: today,
                        daysWithEntries: daysWithEntries,
                        thumbnailPaths: thumbs,
                        onDayTap: (day) {
                          Navigator.of(context).push(_fadeRoute(EntryDetailPage(day: day)));
                        },
                      );
                    },
                    error: (_, __) {
                      return _MonthGrid(
                        month: _month,
                        today: today,
                        daysWithEntries: daysWithEntries,
                        thumbnailPaths: const {},
                        onDayTap: (day) {
                          Navigator.of(context).push(_fadeRoute(EntryDetailPage(day: day)));
                        },
                      );
                    },
                    loading: () => const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: LinearProgressIndicator(),
                    ),
                  ),
                ],
              ),
            );
          },
          error: (e, _) => Center(child: Text('Failed to load calendar: $e')),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

class _WeekdayHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return Row(
      children: [
        for (final l in labels)
          Expanded(
            child: Center(
              child: Text(
                l,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
      ],
    );
  }
}

class _MonthGrid extends StatelessWidget {
  const _MonthGrid({
    required this.month,
    required this.today,
    required this.daysWithEntries,
    required this.thumbnailPaths,
    required this.onDayTap,
  });

  final DateTime month;
  final DateTime today;
  final Set<DateTime> daysWithEntries;
  final Map<DateTime, String> thumbnailPaths;
  final void Function(DateTime day) onDayTap;

  @override
  Widget build(BuildContext context) {
    final first = DateTime(month.year, month.month, 1);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final firstWeekdayMondayBased = (first.weekday + 6) % 7; // Monday=0..Sunday=6

    final totalCells = ((firstWeekdayMondayBased + daysInMonth) / 7).ceil() * 7;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: totalCells,
          itemBuilder: (context, index) {
            final dayNum = index - firstWeekdayMondayBased + 1;
            if (dayNum < 1 || dayNum > daysInMonth) {
              return const SizedBox.shrink();
            }

            final day = startOfDay(DateTime(month.year, month.month, dayNum));
            final isToday = day == today;
            final hasEntry = daysWithEntries.contains(day);
            final thumb = thumbnailPaths[day];

            return _DayCell(
              dayNum: dayNum,
              isToday: isToday,
              hasEntry: hasEntry,
              thumbnailPath: thumb,
              onTap: () => onDayTap(day),
            );
          },
        ),
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.dayNum,
    required this.isToday,
    required this.hasEntry,
    required this.thumbnailPath,
    required this.onTap,
  });

  final int dayNum;
  final bool isToday;
  final bool hasEntry;
  final String? thumbnailPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final hasThumb = thumbnailPath != null;
    final bg = isToday
        ? cs.primaryContainer
        : (hasEntry ? cs.surfaceContainerHighest : cs.surface);
    final fg = isToday ? cs.onPrimaryContainer : cs.onSurface;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isToday ? cs.primary : Colors.transparent,
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            if (hasThumb)
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.file(
                    File(thumbnailPath!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            if (hasThumb)
              Positioned(
                top: 6,
                left: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '$dayNum',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ),
              )
            else
              Center(
                child: Text(
                  '$dayNum',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: fg,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
            if (hasEntry)
              Positioned(
                bottom: 4,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 18,
                    height: 4,
                    decoration: BoxDecoration(
                      color: isToday ? cs.primary : cs.primary.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

Route<void> _fadeRoute(Widget page) {
  return PageRouteBuilder<void>(
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, anim, __, child) {
      return FadeTransition(opacity: anim, child: child);
    },
  );
}

