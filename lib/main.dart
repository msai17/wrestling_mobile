import 'package:flutter/material.dart';
import 'core/wrestling_hub_app.dart';
import 'core/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const WrestlingSakhaApp());
}
