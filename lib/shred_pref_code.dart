import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveProcessorTypeOffline(String processorType) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('offlineProcessorType', processorType);
  log('Processor type saved offline: $processorType');
}
