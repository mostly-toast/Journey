import 'package:flutter/material.dart';
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
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.today_outlined),
            selectedIcon: Icon(Icons.today),
            label: 'Today',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          NavigationDestination(
            icon: Icon(Icons.insights_outlined),
            selectedIcon: Icon(Icons.insights),
            label: 'Insights',
          ),
        ],
      ),
    );
  }
}
