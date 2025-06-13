import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tasky/features/QrScanner/Manager/qr_scanner_func.dart';
import 'package:tasky/features/TaskDetails/Presentation/Views/TaskDetails.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  bool scanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan QR Code")),
      body: (Platform.isWindows)
          ? const Center(
              child: Text("This method can't be applied in windows"),
            )
          : MobileScanner(onDetect: (capture) async {
              try {
                if (scanned) return;

                final barcode = capture.barcodes.first;
                final String? code = barcode.rawValue;

                if (code != null) {
                  setState(() {
                    scanned = true;
                  });

                  final task = await fetchTaskById(code);
                  if (task != null && mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskDetails(taskModel: task),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Task not found")),
                    );
                    setState(() => scanned = false);
                  }
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      e.toString(),
                    ),
                  ),
                );
              }
            }),
    );
  }
}

/*


      if (response.statusCode != 200) {
        await refreshAccessToken();
        final token = await getAccessToken();
        debugPrint("This is the second time, and the token is $token");
        final response = await http.get(
          Uri.parse('$baseUrl/todos?page=1'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );
        debugPrint(response.body.toString());

        if (response.statusCode != 200) {
          throw Exception(
            "Failed to load tasks, Maybe an Authentication Problem",
          );
        }
      }
      if (jsonDecode(response.body) == []) {
        throw Exception(
          "No Tasks Found",
        );
      }

      final List<dynamic> data = jsonDecode(response.body);
      final List<TaskModel> tasks = data
          .map(
            (json) => TaskModel.fromJson(json),
          )
          .toList();

      return right(tasks);
    } catch (e) {
      return left(
        (e.toString()),
      );
    }
  }
}

 */
