import 'package:flutter/material.dart';

import 'bloc/bloc_page.dart';
import 'provider/provider_page.dart';
import 'riverpod/riverpod_page.dart';
import 'set_state/set_state_page.dart';

/// Menu: the same counter feature, built 4 different ways.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _count = 0;

  void _increment() {
    setState(() => _count++);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('State Management Demo'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Preview counter'),
                Text(
                  '$_count',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              children: const [
                _MenuTile(
                  number: 0,
                  title: 'setState',
                  subtitle: 'Built-in. State lives inside one widget.',
                  page: SetStatePage(),
                ),
                _MenuTile(
                  number: 1,
                  title: 'Provider',
                  subtitle: 'ChangeNotifier + notifyListeners()',
                  page: ProviderPage(),
                ),
                _MenuTile(
                  number: 2,
                  title: 'Riverpod',
                  subtitle: 'Global provider + Notifier, no BuildContext',
                  page: RiverpodPage(),
                ),
                _MenuTile(
                  number: 3,
                  title: 'BLoC',
                  subtitle: 'Events in -> States out',
                  page: BlocPage(),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'home-increment',
        onPressed: _increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.page,
  });

  final int number;
  final String title;
  final String subtitle;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Text(String.fromCharCode(65 + number))),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => page),
      ),
    );
  }
}
