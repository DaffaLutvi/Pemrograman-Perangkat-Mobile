import 'event_item.dart';

class RegistrationTicket {
  const RegistrationTicket({
    required this.id,
    required this.event,
    required this.name,
    required this.nim,
    required this.email,
    required this.whatsApp,
    required this.participantType,
    required this.attendanceDate,
    required this.seminarKit,
    required this.donation,
    required this.registeredAt,
  });

  final String id;
  final EventItem event;
  final String name;
  final String nim;
  final String email;
  final String whatsApp;
  final String participantType;
  final DateTime attendanceDate;
  final bool seminarKit;
  final int donation;
  final DateTime registeredAt;
}
