import 'package:flutter/material.dart';

class VenueMapViewer extends StatelessWidget {
  const VenueMapViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 4),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Denah venue',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: Color(0xFF152B4A),
                    ),
                  ),
                ),
                Icon(Icons.pinch, color: Colors.blueGrey.shade400, size: 19),
                const SizedBox(width: 5),
                Text(
                  'Cubit untuk zoom',
                  style: TextStyle(color: Colors.blueGrey.shade500, fontSize: 11),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 300,
            child: InteractiveViewer(
              minScale: 0.7,
              maxScale: 3,
              boundaryMargin: const EdgeInsets.all(40),
              child: Container(
                width: 760,
                height: 420,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F6F3),
                  border: Border.all(color: const Color(0xFFDCE5E1)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 18,
                      top: 18,
                      right: 18,
                      child: _MapRoom(
                        label: 'AUDITORIUM NUSANTARA',
                        icon: Icons.groups_2_outlined,
                        color: const Color(0xFFDFEAF5),
                        width: 420,
                        height: 150,
                      ),
                    ),
                    const Positioned(
                      left: 470,
                      top: 18,
                      child: _MapRoom(
                        label: 'INNOVATION HALL',
                        icon: Icons.lightbulb_outline,
                        color: Color(0xFFE5F1E9),
                        width: 250,
                        height: 150,
                      ),
                    ),
                    const Positioned(
                      left: 18,
                      top: 190,
                      child: _MapRoom(
                        label: 'RUANG KREATIF 1',
                        icon: Icons.brush_outlined,
                        color: Color(0xFFF7E9E0),
                        width: 210,
                        height: 115,
                      ),
                    ),
                    const Positioned(
                      left: 246,
                      top: 190,
                      child: _MapRoom(
                        label: 'RUANG KREATIF 2',
                        icon: Icons.devices_outlined,
                        color: Color(0xFFEAE4F6),
                        width: 210,
                        height: 115,
                      ),
                    ),
                    const Positioned(
                      left: 470,
                      top: 190,
                      child: _MapRoom(
                        label: 'REGISTRASI',
                        icon: Icons.confirmation_number_outlined,
                        color: Color(0xFFFFF1CC),
                        width: 130,
                        height: 115,
                      ),
                    ),
                    const Positioned(
                      left: 614,
                      top: 190,
                      child: _MapRoom(
                        label: 'KAFE',
                        icon: Icons.local_cafe_outlined,
                        color: Color(0xFFF6E3E8),
                        width: 106,
                        height: 115,
                      ),
                    ),
                    Positioned(
                      left: 18,
                      bottom: 16,
                      child: Row(
                        children: [
                          Icon(
                            Icons.directions_walk,
                            color: Colors.blueGrey.shade600,
                            size: 20,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'PINTU MASUK',
                            style: TextStyle(
                              color: Colors.blueGrey.shade700,
                              fontWeight: FontWeight.w800,
                              fontSize: 11,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(
                            Icons.arrow_forward,
                            color: Color(0xFF147D78),
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapRoom extends StatelessWidget {
  const _MapRoom({
    required this.label,
    required this.icon,
    required this.color,
    required this.width,
    required this.height,
  });

  final String label;
  final IconData icon;
  final Color color;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white, width: 3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: const Color(0xFF38546F)),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF29425B),
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
