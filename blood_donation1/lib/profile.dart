import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/imageController.dart';
import 'package:get/get.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _homepageState();
}

class _homepageState extends State<profile> {
  final ImageController imageController = Get.put(ImageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('profile'),
          centerTitle: true,
        ),
        body: Obx(
           () {
            return Column(
              children: [
                kIsWeb
                    ? Image.memory(imageController.memoryImage.value,height: 50,width:50)
                    : Image.file(imageController.image.value),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[ ElevatedButton(
                      child: Text('pick image'),
                      onPressed: () => imageController.pickImage(
                          isFromGallary: true, context: context)),

                          SizedBox(width: 20,),

                          ElevatedButton( child: Text('update image'),onPressed:()=>{  },)

                  ]
                        
                ),
                
              ],
            );
          }
        ));
  }
}
