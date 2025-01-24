import 'package:flutter/material.dart';

class EyeContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.shade700, Colors.red.shade900],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),

        borderRadius: BorderRadius.circular(100),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.remove_red_eye,
            color: Colors.white,
            size: 25,
          ),
          SizedBox(width: 10),
          Text(
            'Keep An Eye',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
