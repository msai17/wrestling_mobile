import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PrivacyPolicyScreen();

}

class _PrivacyPolicyScreen extends State<PrivacyPolicyScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Политика конфиденциальности',style: Theme.of(context).textTheme.bodyMedium),
      ),
      body: SafeArea(
        child: SizedBox(),
      ),
    );
  }



}