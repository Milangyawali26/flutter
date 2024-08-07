import 'package:flutter/material.dart';
import 'package:qr_code_read_and_generate/generate_qr.dart';
import 'package:qr_code_read_and_generate/scan_qr.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "OR code scanner and generator",
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR scanner and Generator"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        heightFactor: 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 200, //
                height: 50, //

                child: ElevatedButton(
                    // Within the `FirstRoute` widget:
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ScanQR()),
                      );
                    },
                    child: Text("Scan Qr code"))),
            SizedBox(
              height: 40,
            ),
            SizedBox(
                width: 200, //
                height: 50,
                child: ElevatedButton(
                    // Within the `FirstRoute` widget:
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GenerateQR()),
                      );
                    },
                    child: Text("Generate Qr code"))),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
