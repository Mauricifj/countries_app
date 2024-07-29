import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/dependency_injection.dart' as di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.setup();
  runApp(const MainApp());
}
