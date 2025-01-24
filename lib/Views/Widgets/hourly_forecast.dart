import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HourlyForecast extends StatelessWidget {
  final String time;
  final String temp;
  final IconData icon;

  const HourlyForecast({required this.time, required this.temp, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.blue.shade700,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 8),
          Text(
            temp,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
