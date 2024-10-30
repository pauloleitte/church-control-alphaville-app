import '../widgets/body_ebd.dart';
import 'package:flutter/material.dart';

class EbdPage extends StatefulWidget {
  const EbdPage({super.key});

  @override
  State<EbdPage> createState() => _EbdPageState();
}

class _EbdPageState extends State<EbdPage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
        appBar: AppBar(title: const Text("EBD")), body: const BodyEbd());
  }
}