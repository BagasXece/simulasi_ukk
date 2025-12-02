import 'package:flutter/material.dart';
import 'package:simulasi_ukk/customers/view_customer/widgets/widgets.dart';

class CustomerView extends StatelessWidget {
  const CustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBars(),
        const SizedBox(height: 16),
        Expanded(child: CustomersList()),
      ],
    );
  }
}
