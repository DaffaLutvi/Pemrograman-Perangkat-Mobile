import 'package:flutter/material.dart';

import '../models/event_item.dart';

final List<EventItem> sampleEvents = [
  EventItem(
    id: 'ai-summit',
    title: 'AI for Everyone: Dari Ide ke Inovasi',
    category: 'AI',
    description:
        'Kenali peluang kecerdasan buatan dan praktikkan cara membangun solusi AI yang bertanggung jawab.',
    date: DateTime(2026, 11, 12, 9),
    location: 'Auditorium Nusantara',
    price: 75000,
    attendees: 184,
    capacity: 250,
    icon: Icons.auto_awesome,
    color: const Color(0xFF7658C8),
  ),
  EventItem(
    id: 'flutter-lab',
    title: 'Flutter UI Lab: Build for Everyone',
    category: 'Mobile',
    description:
        'Workshop praktik membuat antarmuka aplikasi mobile yang rapi, adaptif, dan mudah digunakan.',
    date: DateTime(2026, 11, 14, 10),
    location: 'Ruang Kreatif 2',
    price: 50000,
    attendees: 96,
    capacity: 120,
    icon: Icons.phone_iphone,
    color: const Color(0xFF2587C5),
  ),
  EventItem(
    id: 'iot-city',
    title: 'Smart City dengan Internet of Things',
    category: 'IoT',
    description:
        'Diskusi dan demo sensor terhubung untuk membangun lingkungan perkotaan yang lebih cerdas.',
    date: DateTime(2026, 11, 18, 13),
    location: 'Innovation Hall',
    price: 60000,
    attendees: 72,
    capacity: 150,
    icon: Icons.sensors,
    color: const Color(0xFF169B91),
  ),
  EventItem(
    id: 'cyber-safety',
    title: 'Cybersecurity Essentials for Students',
    category: 'Cybersecurity',
    description:
        'Pelajari kebiasaan keamanan digital, privasi, dan langkah awal melindungi aplikasi.',
    date: DateTime(2026, 11, 21, 9),
    location: 'Auditorium Nusantara',
    price: 45000,
    attendees: 213,
    capacity: 280,
    icon: Icons.shield_outlined,
    color: const Color(0xFFE77955),
  ),
  EventItem(
    id: 'ai-ethics',
    title: 'Responsible AI & Generative Creativity',
    category: 'AI',
    description:
        'Sesi inspiratif tentang etika, kreativitas, dan dampak AI generatif di dunia nyata.',
    date: DateTime(2026, 11, 25, 14),
    location: 'Ruang Kreatif 1',
    price: 55000,
    attendees: 108,
    capacity: 180,
    icon: Icons.psychology_alt_outlined,
    color: const Color(0xFFB45191),
  ),
];

const List<String> eventCategories = [
  'AI',
  'Mobile',
  'IoT',
  'Cybersecurity',
];
