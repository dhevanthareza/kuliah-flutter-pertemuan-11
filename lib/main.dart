import 'package:flutter/material.dart';
import 'package:input_mahasiswa/login.dart';
import 'package:path/path.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://extlcvrdrviwitmwaawz.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV4dGxjdnJkcnZpd2l0bXdhYXd6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTk0MDM2NTQsImV4cCI6MjAzNDk3OTY1NH0.ERpQ-gg63CptIF_OuXcaqZ7nHvWn8xH6jHdl5uv22tc',
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Login(),
    );
  }
}
