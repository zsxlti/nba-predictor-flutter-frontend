import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/comparison.dart';

class ComparisonScreen extends StatefulWidget {
  @override
  _ComparisonScreenState createState() => _ComparisonScreenState();
}

class _ComparisonScreenState extends State<ComparisonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
      ),
    );
  }
}
