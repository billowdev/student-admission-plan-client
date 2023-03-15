import 'dart:convert';

import 'local_storage_util.dart';

Future<String> decodeRoleTokenUtil() async {
  final myToken = await LocalStorageUtil.getItem('token');
  final parts = myToken!.split('.');
  final payload = parts[1];
  final paddedPayload = payload.padRight((payload.length + 3) & ~3, '=');
  final decoded = utf8.decode(base64Url.decode(paddedPayload));
  final Map<String, dynamic> decodedJson = json.decode(decoded);
  final String decodedRole = decodedJson['role'];
  return decodedRole;
}
