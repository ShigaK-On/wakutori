@JS()
library flutter_liff;
import 'package:js/js.dart';

@JS('initLiff')
external Object initLiff(String liffId);

@JS('getProfile')
external Object getProfile();

@JS('getIsGroup')
external Object getIsGroup();