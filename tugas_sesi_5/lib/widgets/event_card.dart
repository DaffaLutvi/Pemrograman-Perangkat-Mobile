import 'package:flutter/material.dart';

import '../models/event_item.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    required this.event,
    required this.onTap,
    super.key,
  });

  final EventItem event;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dateText =
        '${_monthName(event.date.month)} ${event.date.day}, ${event.date.year}';
    final available = event.capacity - event.attendees;

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: event.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(event.icon, color: event.color, size: 28),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.category.toUpperCase(),
                          style: TextStyle(
                            color: event.color,
                            fontWeight: FontWeight.w800,
                            fontSize: 11,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          event.title,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                color: const Color(0xFF182A42),
                                fontWeight: FontWeight.w700,
                                height: 1.25,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_outward, size: 19, color: Colors.grey),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                event.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.blueGrey.shade600,
                  height: 1.4,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 15),
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  _EventDetail(
                    icon: Icons.calendar_today_outlined,
                    text: dateText,
                  ),
                  _EventDetail(
                    icon: Icons.location_on_outlined,
                    text: event.location,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 12,
                runSpacing: 6,
                children: [
                  Text(
                    'Rp ${_priceText(event.price)}',
                    style: const TextStyle(
                      color: Color(0xFF152B4A),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    '$available kursi tersisa',
                    style: TextStyle(
                      color: available < 20 ? Colors.deepOrange : Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EventDetail extends StatelessWidget {
  const _EventDetail({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: Colors.blueGrey),
        const SizedBox(width: 5),
        Text(text, style: const TextStyle(fontSize: 12, color: Colors.blueGrey)),
      ],
    );
  }
}

String _monthName(int month) {
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

String _priceText(int price) =>
    price.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) {
      return '${m[1]}.';
    });
