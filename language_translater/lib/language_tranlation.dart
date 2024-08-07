import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:translator/translator.dart';

class LanguageTranslationPage extends StatefulWidget {
  const LanguageTranslationPage({super.key});

  @override
  State<LanguageTranslationPage> createState() => _LanguageTranslationState();
}

class _LanguageTranslationState extends State<LanguageTranslationPage> {
  var languages = ['Hindi', 'English','Nepali'];
  var originLanguage = "From";
  var DestinationLanguage = "To";
  var output = "";
  TextEditingController languageController = TextEditingController();


// translate method
void translate(String src,String dest, String input)async{

GoogleTranslator translator=new GoogleTranslator();
var translation = await translator.translate(input,from: src,to:dest);
setState(() {
  output=translation.text.toString();
});

if (src =='--'|| dest=='--'){
setState(() {
  output="fail to translate ";
});
} 

}



// getlanguage code

String getLanguageCode(String language){
  if(language=='English'){
    return "en";
  }
  else if(language=='Hindi'){
    return "hi";
  }
  else if(language=='Nepali'){
    return "ne";
  }
  else {return("--");}
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Language Translator'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Center(
            child: SingleChildScrollView(
                child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                    hint: Text(
                      originLanguage,
                      style: TextStyle(color: Colors.black),
                    ),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        child: Text(dropDownStringItem),
                        value: dropDownStringItem,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        originLanguage = value!;
                      });
                    }),
                SizedBox(
                  width: 40,
                ),
                Icon(
                  Icons.arrow_right_alt_outlined,
                  color: Colors.black,
                  size: 40,
                ),
                SizedBox(
                  width: 40,
                ),
                DropdownButton(
                    hint: Text(
                      DestinationLanguage,
                      style: TextStyle(color: Colors.black),
                    ),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        child: Text(dropDownStringItem),
                        value: dropDownStringItem,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        DestinationLanguage = value!;
                      });
                    }),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'please enter your text here...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    errorStyle: TextStyle(color: Colors.red),
                  ),
                  controller: languageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter text to translate";
                    }
                    return null;
                  },
                )),
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(color: Colors.black, fontSize: 20),
                ),
                child: Text(
                  "translate",
                ),
                onPressed: () {
                  // translate (src, dest,input)
                  translate(getLanguageCode(originLanguage),getLanguageCode(DestinationLanguage),languageController.text.toString()); 
                },
              ),
            ),
            SizedBox(height: 30,),
            Text(
              "\n$output",
            )
            
          ],
        ))));
  }
}
