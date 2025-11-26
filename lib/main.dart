import 'package:flutter/widgets.dart';
import 'package:simulasi_ukk/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://oqkxdoqhwqsishzamoxw.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9xa3hkb3Fod3FzaXNoemFtb3h3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjA0Njg5NjIsImV4cCI6MjA3NjA0NDk2Mn0.QihF1JqTlTRq91OrxtUTIwrxhtdY0tdMuQvWQ96wstc',
  );

  runApp(const App());
}