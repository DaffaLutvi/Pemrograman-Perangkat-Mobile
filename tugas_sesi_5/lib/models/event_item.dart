import 'package:flutter/material.dart';

class EventItem {
  const EventItem({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.date,
    required this.location,
    required this.price,
    required this.attendees,
    required this.capacity,
    required this.icon,
    required this.color,
  });

  final String id;
  final String title;
  final String category;
  final String description;
  final DateTime date;
  final String location;
  final int price;
  final int attendees;
  final int capacity;
  final IconData icon;
  final Color color;
}
