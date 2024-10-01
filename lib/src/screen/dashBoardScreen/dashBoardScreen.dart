import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Image.asset(
                'assets/logo_bot.png',
                height: 100,
                width: 100,
              ),
              Column(
                children: [
                  Text(
                    'Xin chào Lâm Code!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Chúc bạn một ngày tuyệt vời nhá!',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              )
            ]),
          ],
        ),
      ),
    );
  }
}
