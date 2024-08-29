import 'package:flutter/material.dart';

import 'cut_corner.dart';

class CenterCutItem extends StatelessWidget {
  const CenterCutItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(title: const Text("Center Cut Widget")),
      body: ListView.separated(
        padding: const EdgeInsets.all(24.0),
        itemCount: 10,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 20);
        },
        itemBuilder: (context, index) {
          return ClipPath(
            clipper: TicketShapeClipper(),
            child: Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12)),
            ),
          );
        },
      ),
    );
  }
}
