import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQR extends StatefulWidget {
  const GenerateQR({super.key});

  @override
  State<GenerateQR> createState() => _GenerateQRState();
}

class _GenerateQRState extends State<GenerateQR> {
  TextEditingController urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Generate QR Code"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (urlController.text.isNotEmpty)

//  need to know more about this    

//  this tutorial  was from    https://www.youtube.com/watch?v=hm5JfFhiXL8&ab_channel=GeeksforGeeks



                 QrImage(data: urlController.text, size: 200).generate(),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: urlController,
                  decoration: const InputDecoration(
                    labelText: "Enter your text",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      // Update the state to trigger a rebuild and display the QR code
                    });
                  },
                  child: Text("Generate QR"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
