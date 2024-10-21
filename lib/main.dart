import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:js/js_util.dart';
import 'package:wakutori/utils/flutter_liff.dart';
import 'app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_KEY']!,
  );
  await promiseToFuture(initLiff('2006055281-4m3ng7xL'));
  usePathUrlStrategy();
  runApp(
    const ProviderScope(child: MyApp()),
  );
}
