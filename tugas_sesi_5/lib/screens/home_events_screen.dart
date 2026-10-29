import 'package:flutter/material.dart';

import '../data/sample_events.dart';
import '../models/event_item.dart';
import '../models/registration_ticket.dart';
import '../theme/app_colors.dart';
import '../widgets/event_card.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../widgets/venue_map_viewer.dart';
import 'event_registration_screen.dart';
import 'registered_tickets_screen.dart';

class HomeEventsScreen extends StatefulWidget {
  const HomeEventsScreen({super.key});

  @override
  State<HomeEventsScreen> createState() => _HomeEventsScreenState();
}

class _HomeEventsScreenState extends State<HomeEventsScreen> {
  int _selectedTab = 0;
  String _selectedCategory = 'Semua';
  final List<RegistrationTicket> _tickets = [];

  String get _title => switch (_selectedTab) {
        0 => 'Seminar & Workshop',
        1 => 'Galeri & Denah Venue',
        _ => 'Tiket Terdaftar',
      };

  List<EventItem> get _visibleEvents {
    if (_selectedCategory == 'Semua') return sampleEvents;
    return sampleEvents
        .where((event) => event.category == _selectedCategory)
        .toList();
  }

  Future<void> _openFilter() async {
    final category = await FilterBottomSheet.show(
      context,
      selectedCategory: _selectedCategory,
    );
    if (category != null && mounted) {
      setState(() => _selectedCategory = category);
    }
  }

  Future<void> _openRegistration(EventItem event) async {
    final ticket = await Navigator.of(context).push<RegistrationTicket>(
      MaterialPageRoute(
        builder: (_) => EventRegistrationScreen(event: event),
      ),
    );
    if (ticket == null || !mounted) return;

    setState(() => _tickets.insert(0, ticket));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Pendaftaran ${event.title} berhasil!'),
          action: SnackBarAction(
            label: 'Lihat tiket',
            onPressed: () => setState(() => _selectedTab = 2),
          ),
        ),
      );
  }

  void _cancelTicket(RegistrationTicket ticket) {
    setState(() => _tickets.removeWhere((item) => item.id == ticket.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'NusaEvent Hub',
              style: TextStyle(fontSize: 12, color: brandTeal, height: 1.2),
            ),
            Text(
              _title,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 19),
            ),
          ],
        ),
        actions: [
          if (_selectedTab == 0)
            IconButton(
              tooltip: 'Filter kategori',
              onPressed: _openFilter,
              icon: const Icon(Icons.tune_rounded),
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          _buildSeminarTab(),
          _buildGalleryTab(),
          RegisteredTicketsScreen(
            tickets: _tickets,
            onCancel: _cancelTicket,
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedTab,
        onDestinationSelected: (index) => setState(() => _selectedTab = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.event_note_outlined),
            selectedIcon: Icon(Icons.event_note),
            label: 'Seminar',
          ),
          NavigationDestination(
            icon: Icon(Icons.photo_library_outlined),
            selectedIcon: Icon(Icons.photo_library),
            label: 'Galeri & Denah',
          ),
          NavigationDestination(
            icon: Icon(Icons.confirmation_number_outlined),
            selectedIcon: Icon(Icons.confirmation_number),
            label: 'Tiket',
          ),
        ],
      ),
    );
  }

  Widget _buildSeminarTab() {
    return SafeArea(
      top: false,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 14),
                child: _WelcomeBanner(
                  onExplore: () => setState(() => _selectedTab = 1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Temukan acara pilihanmu',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: brandNavy,
                        ),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: _openFilter,
                      icon: const Icon(Icons.filter_list, size: 18),
                      label: Text(_selectedCategory),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _visibleEvents.isEmpty
                    ? const Center(child: Text('Belum ada seminar di kategori ini.'))
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        itemCount: _visibleEvents.length,
                        itemBuilder: (context, index) {
                          final event = _visibleEvents[index];
                          return EventCard(
                            event: event,
                            onTap: () => _openRegistration(event),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGalleryTab() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth >= 850
            ? 4
            : constraints.maxWidth >= 560
                ? 3
                : 2;

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _GalleryIntro(),
                  const SizedBox(height: 22),
                  const Text(
                    'Poster seminar',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: brandNavy,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: sampleEvents.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.68,
                    ),
                    itemBuilder: (context, index) {
                      final event = sampleEvents[index];
                      return _PosterCard(
                        event: event,
                        onTap: () => _openRegistration(event),
                      );
                    },
                  ),
                  const SizedBox(height: 26),
                  const VenueMapViewer(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _WelcomeBanner extends StatelessWidget {
  const _WelcomeBanner({required this.onExplore});

  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF152B4A), Color(0xFF216D73)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        runSpacing: 16,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    '12—25 NOVEMBER 2026',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Ide besar bertemu\nmasa depan.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    height: 1.12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Belajar, terhubung, dan tumbuh bersama komunitas teknologi.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.82),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          FilledButton.tonalIcon(
            onPressed: onExplore,
            icon: const Icon(Icons.arrow_forward, size: 17),
            label: const Text('Jelajahi acara'),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: brandNavy,
            ),
          ),
        ],
      ),
    );
  }
}

class _GalleryIntro extends StatelessWidget {
  const _GalleryIntro();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F3F0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_city, color: brandTeal, size: 32),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Satu tempat, banyak inspirasi',
                  style: TextStyle(
                    color: brandNavy,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Jelajahi rangkaian acara dan kenali lokasi NusaEvent.',
                  style: TextStyle(
                    color: Colors.blueGrey.shade700,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PosterCard extends StatelessWidget {
  const _PosterCard({required this.event, required this.onTap});

  final EventItem event;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      event.color,
                      Color.lerp(event.color, const Color(0xFF152B4A), 0.42)!,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -10,
                      bottom: -12,
                      child: Icon(
                        event.icon,
                        size: 78,
                        color: Colors.white.withValues(alpha: 0.18),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'NUSAEVENT',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 9,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const Spacer(),
                        Icon(event.icon, color: Colors.white, size: 28),
                        const SizedBox(height: 8),
                        Text(
                          event.category.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            letterSpacing: 1.3,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          event.title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            height: 1.15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  const Icon(Icons.calendar_month, size: 15, color: brandTeal),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      '${event.date.day} ${_monthLabel(event.date.month)}',
                      style: const TextStyle(
                        color: brandNavy,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward, size: 16, color: brandTeal),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _monthLabel(int month) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Okt',
    'Nov',
    'Des',
  ];
  return months[month - 1];
}
