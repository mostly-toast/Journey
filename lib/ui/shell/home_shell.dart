import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:journey/ui/tabs/calendar/calendar_tab.dart';
import 'package:journey/ui/tabs/insights/insights_tab.dart';
import 'package:journey/ui/tabs/today/today_tab.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  var _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = const [TodayTab(), CalendarTab(), InsightsTab()];

    return Scaffold(
      body: SafeArea(child: pages[_index]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1)),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest,
              hoverColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              gap: 8,
              activeColor: Theme.of(context).colorScheme.onSecondaryContainer,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Theme.of(
                context,
              ).colorScheme.secondaryContainer,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              tabs: const [
                GButton(icon: Icons.today, text: 'Today'),
                GButton(icon: Icons.calendar_month, text: 'Calendar'),
                GButton(icon: Icons.insights, text: 'Insights'),
              ],
              selectedIndex: _index,
              onTabChange: (index) {
                setState(() {
                  _index = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
