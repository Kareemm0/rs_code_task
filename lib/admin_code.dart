import 'dart:developer';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

void main() async {
  handler(Request request) async {
    if (request.method == 'POST' && request.url.path == 'get_apk') {
      final payload = await request.readAsString();
      final processorType = Uri.splitQueryString(payload)['processorType'];

      // Map processor type to an APK URL
      final apkUrl = getApkUrlForProcessor(processorType ?? " ");
      return Response.ok(apkUrl);
    }

    return Response.notFound('Not Found');
  }

  // Bind to all IPv4 addresses
  final server = await io.serve(handler, InternetAddress.anyIPv4, 8080);

  // Fetch and log the actual IP address assigned by the hotspot
  final interfaces = await NetworkInterface.list();
  for (var interface in interfaces) {
    for (var address in interface.addresses) {
      if (address.type == InternetAddressType.IPv4) {
        log('Server accessible at http://${address.address}:8080');
      }
    }
  }

  log('Server is running on ${server.address.address}:${server.port}');
}

String getApkUrlForProcessor(String processorType) {
  return "http://yourserver.com/apk/$processorType.apk";
}
