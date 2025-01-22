import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String progress = "0%";
  bool isDownloading = false;
  String adminIp = "";

  Future<void> fetchAdminIp() async {
    try {
      final url = Uri.parse('http://10.0.2.15:8080/get_ip');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          adminIp = response.body.trim();
        });
        log('Admin IP fetched: $adminIp');
      } else {
        log('Failed to fetch Admin IP: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching Admin IP: $e');
    }
  }

  Future<String> getProcessorType() async {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    return androidInfo.supportedAbis.first;
  }

  Future<String?> sendProcessorType(String processorType) async {
    if (adminIp.isEmpty) {
      await fetchAdminIp();
      if (adminIp.isEmpty) {
        throw Exception('Admin IP could not be fetched');
      }
    }

    final url = Uri.parse('http://$adminIp:8080/get_apk');
    log('Sending processor type to: $url');

    final response = await http.post(
      url,
      body: {'processorType': processorType},
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to get APK URL');
    }
  }

  Future<void> downloadFile(String url, String savePath) async {
    final dio = Dio();

    await dio.download(
      url,
      savePath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          setState(() {
            progress = "${(received / total * 100).toStringAsFixed(2)}%";
          });
        }
      },
    );
  }

  Future<void> installApk(String filePath) async {
    try {
      log("Installing APK: $filePath");
      await InstallPlugin.installApk(filePath);
    } catch (e) {
      log("Error during installation: $e");
    }
  }

  void deleteFile(String filePath) {
    final file = File(filePath);
    if (file.existsSync()) {
      file.deleteSync();
    }
  }

  Future<void> updateApp() async {
    setState(() {
      progress = "0%";
      isDownloading = true;
    });

    try {
      if (adminIp.isEmpty) {
        await fetchAdminIp();
      }

      final processorType = await getProcessorType();
      final downloadUrl = await sendProcessorType(processorType);

      if (downloadUrl != null) {
        final savePath = '${(await getTemporaryDirectory()).path}/update.apk';

        await downloadFile(downloadUrl, savePath);
        await installApk(savePath);
        deleteFile(savePath);

        setState(() {
          progress = "Update Complete!";
        });
      }
    } catch (e) {
      setState(() {
        progress = "Error: $e";
      });
    } finally {
      setState(() {
        isDownloading = false;
      });
    }
  }

  @override
  void initState() {
    fetchAdminIp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("APK Updater")),
      body: Center(
        child: isDownloading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text("Progress: $progress"),
                ],
              )
            : ElevatedButton(
                onPressed: updateApp,
                child: Text("Check for Updates"),
              ),
      ),
    );
  }
}
