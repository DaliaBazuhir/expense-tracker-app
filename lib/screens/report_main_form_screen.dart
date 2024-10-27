import 'package:flutter/material.dart';
import 'package:flutter_gradient_button/flutter_gradient_button.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:expense_tracker/screens/after_fill_report_data_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../constants/used_widgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:expense_tracker/data/report.dart';
import 'package:http/http.dart' as http;


class CreateReportScreen extends StatefulWidget {
  static String id = "Create report screen";
  final String reportName;
  CreateReportScreen({
    required this.reportName,
  });

  @override
  _CreateReportScreenState createState() => _CreateReportScreenState();
}

class _CreateReportScreenState extends State<CreateReportScreen> {

  String selectedOption = 'Manual';
  List<String> cateogryOptions = ["Food", "Travel", "Furniture and Equipment", "Lodging", "Meals and Entertainment"];
  bool isActive = false;
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  final _descriptionController = TextEditingController();
  var tempCat;
  final _vatTaxController = TextEditingController();
  File? _selectedImage;
  bool _isListening = false;
  bool _isLoading = false;
  late SpeechToText _speech;
  

  // //
  //   Future<void> _pickImage(String src) async {
//     final pickedImage;
//     final picker = ImagePicker();
//     if(src == 'camera'){
//        pickedImage = await picker.pickImage(source: ImageSource.camera);
//     }else{
//        pickedImage = await picker.pickImage(source: ImageSource.gallery);
//     }
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage = File(pickedImage.path);
//       });
//       if(selectedOption == 'Scan'){
//         _ScanImage(pickedImage);
//       }
//     }
//   }
//   Future<void> _ScanImage(XFile pickedImage) async{
//      final inputImg =  InputImage.fromFilePath(pickedImage.path);
//      final Recognizer = TextRecognizer(script: TextRecognitionScript.latin);
//      final scanedTxt = await Recognizer.processImage(inputImg);
//      RegExp amountRegex = RegExp(r'\b\d{1,3}(?:[.,]\d{3})*(?:[.,]\d{2})?\b');  // Matches currency amounts
//      RegExp dateRegex = RegExp(r'\b\d{1,2}[/-]\d{1,2}[/-]\d{2,4}\b');  // Matches dates
//      String amount= '';
//      String date= '';
//      Recognizer.close();
//
//      if(scanedTxt.blocks.isNotEmpty){
//        setState(() {
//          _nameController.text = scanedTxt.blocks.first.text;
//        });
//      }
//
//      for (TextBlock block in scanedTxt.blocks) {
//        for (TextLine line in block.lines) {
//          if (amount.isEmpty) {
//            var match = amountRegex.firstMatch(line.text);
//            if (match != null) {
//              setState(() {
//                _amountController.text = match.group(0)!;
//              });
//            }
//          }
//
//          if (date.isEmpty) {
//            var match = dateRegex.firstMatch(line.text);
//            if (match != null) {
//              setState(() {
//                _dateController.text = match.group(0)!;
//              });
//            }
//          }
//        }
//      }
//   }
  ////
  Future<void> _pickImage(String src) async {
    final pickedImage;
    final picker = ImagePicker();
    if(src == 'camera'){
      pickedImage = await picker.pickImage(source: ImageSource.camera);
    }else{
      pickedImage = await picker.pickImage(source: ImageSource.gallery);
    }
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
      if(selectedOption == 'Scan'){
        // _ScanImage(pickedImage);
        // _extractTextFromImageUsingAPI(_selectedImage!);
      }
    }
  }
  // Future<void> _extractTextFromImageUsingAPI(File imageFile) async {
  //   final bytes = imageFile.readAsBytesSync();
  //   final response = await http.post(
  //     Uri.parse('https://api.openai.com/v1/images-to-text'),  // Hypothetical API
  //     headers: {
  //       'Authorization': 'Bearer YOUR_OPENAI_API_KEY',
  //       'Content-Type': 'application/json',
  //     },
  //     body: jsonEncode({
  //       'image': base64Encode(bytes),
  //     }),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final result = jsonDecode(response.body);
  //     setState(() {
  //       _text = result['text'];  // Assuming API returns the text in 'text'
  //     });
  //     print(_text);
  //   } else {
  //     throw Exception('Failed to extract text');
  //   }
  // }
  //
  // Future<void> _ScanImageWithFireBase(XFile pickedImage) async{
  //   final inputImg =  File(pickedImage.path);
  //
  //   final TextRecognizer _cloudRecognizer = FirebaseVision.instance.cloudTextRecognizer();
  //   final FirebaseVisionImage visionImage =FirebaseVisionImage.fromFile(inputImg);
  //
  //   // final inputImg =  InputImage.fromFilePath(pickedImage.path);
  //   dynamic scanedTxt = await _cloudRecognizer.processImage(visionImage);
  //   final Recognizer = TextRecognizer(script: TextRecognitionScript.latin);
  //   // final scanedTxt = await Recognizer.processImage(inputImg);
  //   _extractTextFromImage(_image!);
  //
  //   RegExp amountRegex = RegExp(r'\b\d{1,3}(?:[.,]\d{3})*(?:[.,]\d{2})?\b');  // Matches currency amounts
  //   RegExp dateRegex = RegExp(r'\b\d{1,2}[/-]\d{1,2}[/-]\d{2,4}\b');  // Matches dates
  //   String amount= '';
  //   String date= '';
  //   // Recognizer.close();
  //
  //   if(scanedTxt.blocks.isNotEmpty){
  //     setState(() {
  //       _nameController.text = scanedTxt.blocks.first.text;
  //     });
  //   }
  //
  //   for (TextBlock block in scanedTxt.blocks) {
  //     for (TextLine line in block.lines) {
  //       for(TextElement element in line.elements){
  //         if (amount.isEmpty) {
  //           // var match = amountRegex.firstMatch(element.text);
  //           var match = amountRegex.firstMatch(element.text!);
  //           if (match != null) {
  //             setState(() {
  //               _amountController.text = match.group(0)!;
  //             });
  //           }
  //         }
  //
  //         if (date.isEmpty) {
  //           var match = dateRegex.firstMatch(line.text!);
  //           if (match != null) {
  //             setState(() {
  //               _dateController.text = match.group(0)!;
  //             });
  //           }
  //         }
  //       }
  //     }
  //   }
  // }
  void _toggleListening() async {
    final PermissionStatus permission = await Permission.microphone.status;
    if (!_isListening) {
      // Start listening
      bool available = await _speech.initialize();
      if (available) {
        setState(() {
          _isLoading = true; // Show the loading spinner
          _isListening = true; // Set listening to true
        });
         _speech.listen(
          onResult: (result) {
            setState(() {
               RegExp priceRegExp = RegExp(r'\b(\d+(\.\d{1,2})?)\b(?!\s*(dollars|usd|currency))', caseSensitive: false);
               Match priceMatch = priceRegExp.firstMatch(result.recognizedWords)!;
               String? price = priceMatch != null ? priceMatch.group(1) : '';
               _nameController.text =result.recognizedWords.split(' ').last;
               _amountController.text = price!; // Example field
                _dateController.text = "DD/MM/YY";
               _descriptionController.text = "Description ...";// Example field
            });
          },
        );
      }
    } else {
      // Stop listening
      setState(() {
        _isListening = false;
        _isLoading = false;
      });
      _speech.stop();
    }
  }

  Report Creat_Report_object(){
    final report = Report(
      report_name: widget.reportName ,
      name: _nameController.text,
      amount: double.tryParse(_amountController.text) ?? 0,
      date : _dateController.text,
      description: _descriptionController.text,
      category: selectedOption,
      vat: double.tryParse(_vatTaxController.text) ?? 0,
      image: _selectedImage,
      submitted: false,
    );
    _nameController.clear();
    _amountController.clear();
    _descriptionController.clear();
    _dateController.clear();
    _vatTaxController.clear();

    _selectedImage = null;
    return report;
  }

  @override
  void initState() {
    super.initState();
    _speech = SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  // Radio buttons for selecting form type
                  Text("How do you want to input your expense?",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
                  Row(
                      children: [
                        Radio(
                          value: 'Manual',
                          groupValue: selectedOption,
                          activeColor: usedColor,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value!;
                            });
                          },
                        ),
                        Text('Manual input'),
                      ]),
                  GestureDetector(
                    onTap:(){
                      Select_photo_Dialog(context);
                    },
                    child :Row(
                        children: [
                          Radio(
                            value: 'Scan',
                            groupValue: selectedOption,
                            activeColor: usedColor,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value!;
                              });
                            },
                          ),

                          Text('Scan receipt'),

                        ]),
                  ),
                  GestureDetector(
                      onTap: _toggleListening,
                      child: Row(
                        children: [
                          Radio(
                            value: 'Record',
                            groupValue: selectedOption,
                            activeColor: usedColor,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value!;
                              });
                            },
                          ),
                          Text('Voice recognition'),
                        ],
                      ),
                  ),

                  // Display form based on selected option
                  if (selectedOption == 'Manual')  _buildManualForm(),
                  if (selectedOption == 'Scan') _buildScanForm(),

                  if (selectedOption == 'Record')  _buildRecordForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }

  // Manual Form
  Widget _buildManualForm() {

    String? dropdownValue;
    dropdownValue = cateogryOptions[0];
    String? selectedCategory =  cateogryOptions[1]; // Declare as a state variable

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Merchant Name",style: TextStyle(fontWeight: FontWeight.w300),),
        TextField(
          controller: _nameController,
          decoration:InputDecoration(
            hintText: "Name",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
            ),
            hintStyle: TextStyle(color: Colors.grey,fontSize: 15),

          ),
          cursorColor: usedColor,
        ),
        SizedBox(height: 15,),
        Text("Amount",style: TextStyle(fontWeight: FontWeight.w300),),
        TextField(
          controller: _amountController,
          decoration: InputDecoration(
            hintText: "Amount",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
            ),
            hintStyle: TextStyle(color: Colors.grey,fontSize: 15),

          ),
          cursorColor: usedColor,
        ),
        SizedBox(height: 15,),
        Text("Date",style: TextStyle(fontWeight: FontWeight.w300),),
        TextField(
          controller: _dateController,
          decoration: InputDecoration(
            hintText: "D/M/Y",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
            ),
            hintStyle: TextStyle(color: Colors.grey,fontSize: 15),

          ),
          cursorColor: usedColor,
        ),
        SizedBox(height: 15,),
        Text("Description",style: TextStyle(fontWeight: FontWeight.w300),),

        TextField(
          controller: _descriptionController,
          decoration: InputDecoration(
            hintText: "Descritption",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
            ),
            hintStyle: TextStyle(color: Colors.grey,fontSize: 15),

          ),
          cursorColor: usedColor,
        ),
        SizedBox(height: 15,),
        Text("Category",style: TextStyle(fontWeight: FontWeight.w300),),
        TextButton(
          onPressed:()=> showAddDialog(context),
          child: Row(
              children: [
                Icon(Icons.add,color: usedColor,size: 17,),
                Text("Add New Category",style: TextStyle(color: usedColor,fontSize: 15),),
              ]),
        ),
        DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          underline: Container(
            height: 2,
            color: usedColor,
          ),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
            });
          },
          items: cateogryOptions.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),

        SizedBox(height: 15,),
        ListTile(
          leading: Transform.scale(
            scale: 0.7,
            child: Switch(
              value: isActive,
              activeColor: Colors.white,
              activeTrackColor: usedColor,
              onChanged: (value) {
                setState(() {
                  isActive = value;
                });
              },
            ),
          ),
          title: Text("Include Vat tax",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
        ),
        SizedBox(height: 15,),
        showVatTax(isActive,_vatTaxController),
        DottedBorder(
            dashPattern: [6,6,6,6],
            borderType: BorderType.RRect,
            color: usedColor,
            padding: EdgeInsets.all(15),
            child: GestureDetector(
                onTap: (){
                  // _pickImage();
                  Select_photo_Dialog(context);
                },
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle_outline,color: Colors.grey,size: 20,),
                    SizedBox(width: 15,),
                    Text("Upload images",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 15),)
                  ],
                )
            )
        ),
        SizedBox(height: 10,),
        if (_selectedImage != null)
          Image.file(_selectedImage!, height: 100, width: 100),
        SizedBox(height: 15,),
        UsedGradientButton(
          textButton: "Save Expense",
          onPressedFunction: (){
            var createdReport = Creat_Report_object();

            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DecsideSubmitOrNot(reportName: widget.reportName,report:createdReport)));
          },
        ),

      ],
    );
  }
  Widget _buildScanForm() {

    String? dropdownValue;
    dropdownValue = cateogryOptions[0];
    String? selectedCategory =  cateogryOptions[1]; // Declare as a state variable
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Merchant Name",style: TextStyle(fontWeight: FontWeight.w300),),
        TextField(
          controller: _nameController,
          decoration:InputDecoration(
            hintText: "Name",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
            ),
            hintStyle: TextStyle(color: Colors.grey,fontSize: 15),

          ),
          cursorColor: usedColor,
        ),
        SizedBox(height: 15,),
        Text("Amount",style: TextStyle(fontWeight: FontWeight.w300),),
        TextField(
          controller: _amountController,
          decoration: InputDecoration(
            hintText: "Amount",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
            ),
            hintStyle: TextStyle(color: Colors.grey,fontSize: 15),

          ),
          cursorColor: usedColor,
        ),
        SizedBox(height: 15,),
        Text("Date",style: TextStyle(fontWeight: FontWeight.w300),),
        TextField(
          controller: _dateController,
          decoration: InputDecoration(
            hintText: "D/M/Y",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
            ),
            hintStyle: TextStyle(color: Colors.grey,fontSize: 15),

          ),
          cursorColor: usedColor,
        ),
        SizedBox(height: 15,),
        Text("Description",style: TextStyle(fontWeight: FontWeight.w300),),

        TextField(
          controller: _descriptionController,
          decoration: InputDecoration(
            hintText: "Descritption",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
            ),
            hintStyle: TextStyle(color: Colors.grey,fontSize: 15),

          ),
          cursorColor: usedColor,
        ),
        SizedBox(height: 15,),
        Text("Category",style: TextStyle(fontWeight: FontWeight.w300),),
        TextButton(
          onPressed:()=> showAddDialog(context),
          child: Row(
              children: [
                Icon(Icons.add,color: usedColor,size: 17,),
                Text("Add New Category",style: TextStyle(color: usedColor,fontSize: 15),),
              ]),
        ),
        DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          underline: Container(
            height: 2,
            color: usedColor,
          ),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
            });
          },
          items: cateogryOptions.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),

        SizedBox(height: 15,),
        ListTile(
          leading: Transform.scale(
            scale: 0.7,
            child: Switch(
              value: isActive,
              activeColor: Colors.white,
              activeTrackColor: usedColor,
              onChanged: (value) {
                setState(() {
                  isActive = value;
                });
              },
            ),
          ),
          title: Text("Include Vat tax",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
        ),
        SizedBox(height: 15,),
        showVatTax(isActive,_vatTaxController),
        DottedBorder(
            dashPattern: [6,6,6,6],
            borderType: BorderType.RRect,
            color: usedColor,
            padding: EdgeInsets.all(15),
            child: GestureDetector(
                onTap: (){
                  // _pickImage();
                  Select_photo_Dialog(context);
                },
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle_outline,color: Colors.grey,size: 20,),
                    SizedBox(width: 15,),
                    Text("Upload images",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 15),)
                  ],
                )
            )
        ),
        SizedBox(height: 10,),
        if (_selectedImage != null)
          Image.file(_selectedImage!, height: 100, width: 100),
        SizedBox(height: 15,),
        UsedGradientButton(
          textButton: "Save Expense",
          onPressedFunction: (){
            var createdReport = Creat_Report_object();

            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DecsideSubmitOrNot(reportName: widget.reportName,report:createdReport)));
          },
        ),
      ],
    );
  }
  void showAddDialog(BuildContext context) {
    TextEditingController cateoryController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: EdgeInsets.all(20.0),
            height: 200,
            child: Column(
              children: [
                TextField(
                    controller: cateoryController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
                    )
                ),
                SizedBox(height: 20),
                GradientButton(
                    colors: [Color(0xFFFC3C58),Color(0xFFFE3B82),Color(0xFFE93385)],
                    height: 50,
                    width: 80,
                    radius: 10,
                    gradientDirection: GradientDirection.topToBottom ,
                    textStyle: TextStyle(color: Colors.white,fontSize: 15),
                    text: "Enter",
                    onPressed: (){
                      setState(() {
                        cateogryOptions.add(cateoryController.text);
                      });
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        );
      },
    );
  }
  // Scan Form (you can customize this)
  Widget _buildRecordForm() {
    {
     String? dropdownValue;
      dropdownValue = cateogryOptions[0];
      String? selectedCategory =  cateogryOptions[1]; // Declare as a state variable
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _isLoading
              ? Container(
            width: 10,
            height: 20,
            margin: EdgeInsets.symmetric(horizontal: 150),
            child: CircularProgressIndicator(
              color: usedColor,
            ),
          )
              : Icon(
            _isListening ? Icons.mic_off : Icons.mic,
            color: usedColor,
          ),
          SizedBox(height: 20),
          Text("Merchant Name",style: TextStyle(fontWeight: FontWeight.w300),),
          TextField(
            controller: _nameController,
            decoration:InputDecoration(
              hintText: "Name",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
              ),
              hintStyle: TextStyle(color: Colors.grey,fontSize: 15),

            ),
            cursorColor: usedColor,
          ),
          SizedBox(height: 15,),
          Text("Amount",style: TextStyle(fontWeight: FontWeight.w300),),
          TextField(
            controller: _amountController,
            decoration: InputDecoration(
              hintText: "Amount",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
              ),
              hintStyle: TextStyle(color: Colors.grey,fontSize: 15),

            ),
            cursorColor: usedColor,
          ),
          SizedBox(height: 15,),
          Text("Date",style: TextStyle(fontWeight: FontWeight.w300),),
          TextField(
            controller: _dateController,
            decoration: InputDecoration(
              hintText: "D/M/Y",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
              ),
              hintStyle: TextStyle(color: Colors.grey,fontSize: 15),

            ),
            cursorColor: usedColor,
          ),
          SizedBox(height: 15,),
          Text("Description",style: TextStyle(fontWeight: FontWeight.w300),),

          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(
              hintText: "Descritption",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
              ),
              hintStyle: TextStyle(color: Colors.grey,fontSize: 15),

            ),
            cursorColor: usedColor,
          ),
          SizedBox(height: 15,),
          Text("Category",style: TextStyle(fontWeight: FontWeight.w300),),
          TextButton(
            onPressed:()=> showAddDialog(context),
            child: Row(
                children: [
                  Icon(Icons.add,color: usedColor,size: 17,),
                  Text("Add New Category",style: TextStyle(color: usedColor,fontSize: 15),),
                ]),
          ),
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            underline: Container(
              height: 2,
              color: usedColor,
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
            },
            items: cateogryOptions.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),

          SizedBox(height: 15,),
          ListTile(
            leading: Transform.scale(
              scale: 0.7,
              child: Switch(
                value: isActive,
                activeColor: Colors.white,
                activeTrackColor: usedColor,
                onChanged: (value) {
                  setState(() {
                    isActive = value;
                  });
                },
              ),
            ),
            title: Text("Include Vat tax",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
          ),
          SizedBox(height: 15,),
          showVatTax(isActive,_vatTaxController),
          DottedBorder(
              dashPattern: [6,6,6,6],
              borderType: BorderType.RRect,
              color: usedColor,
              padding: EdgeInsets.all(15),
              child: GestureDetector(
                  onTap: (){
                    // _pickImage();
                    Select_photo_Dialog(context);
                  },
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_circle_outline,color: Colors.grey,size: 20,),
                      SizedBox(width: 15,),
                      Text("Upload images",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 15),)
                    ],
                  )
              )
          ),
          SizedBox(height: 10,),
          if (_selectedImage != null)
            Image.file(_selectedImage!, height: 100, width: 100),
          SizedBox(height: 15,),
          UsedGradientButton(
            textButton: "Save Expense",
            onPressedFunction: (){
              var createdReport = Creat_Report_object();

              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DecsideSubmitOrNot(reportName: widget.reportName,report:createdReport)));
            },
          ),
        ],
      );
    }
  }
  Widget showVatTax(bool isActive,_vatTaxController) {
    if (isActive) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Vat Tax",style: TextStyle(fontWeight: FontWeight.w300),),
          TextField(
            controller: _vatTaxController,
            decoration: InputDecoration(
              hintText: "Vat Tax",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
              ),
              hintStyle: TextStyle(color: Colors.grey,fontSize: 15),

            ),
            cursorColor: usedColor,
          ),

          SizedBox(height: 15,),
        ],
      );
    } else {
      return SizedBox(height: 15,); // Return an empty widget when inactive
    }
  }


  void Select_photo_Dialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child:  Container(
              padding: EdgeInsets.all(20.0),
              height: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  UsedGradientButton(
                    textButton: 'Take Photo', onPressedFunction: (){
                    _pickImage('camera');
                    Navigator.of(context).pop();
                  },),
                  SizedBox(height: 15,),
                  UsedGradientButton(
                    textButton: 'From Gallery', onPressedFunction: (){
                    _pickImage('gallery');
                    Navigator.of(context).pop();
                  },)
                ],
              ),
            )
        );
      },
    );
  }
}

// //----------------------------------------------------
// import 'package:flutter/material.dart';
// import 'package:flutter_gradient_button/flutter_gradient_button.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:expense_tracker/screens/after_fill_report_data_screen.dart';
// import '../constants/used_widgets.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:expense_tracker/data/report.dart';
//
//
// class CreateReportScreen extends StatefulWidget {
//   static String id = "Create report screen";
//   final String reportName;
//   CreateReportScreen({
//     required this.reportName,
//   });
//
//   @override
//   _CreateReportScreenState createState() => _CreateReportScreenState();
// }
//
// class _CreateReportScreenState extends State<CreateReportScreen> {
//
//   String selectedOption = 'Manual';
//   List<String> cateogryOptions = ["Food", "Travel", "Furniture and Equipment", "Lodging", "Meals and Entertainment"];
//   bool isActive = false;
//   final _nameController = TextEditingController();
//   final _amountController = TextEditingController();
//   final _dateController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   var tempCat;
//   final _vatTaxController = TextEditingController();
//   File? _selectedImage;
//   Future<void> _pickImage(String src) async {
//     final pickedImage;
//     final picker = ImagePicker();
//     if(src == 'camera'){
//        pickedImage = await picker.pickImage(source: ImageSource.camera);
//     }else{
//        pickedImage = await picker.pickImage(source: ImageSource.gallery);
//     }
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage = File(pickedImage.path);
//       });
//       if(selectedOption == 'Scan'){
//         _ScanImage(pickedImage);
//       }
//     }
//   }
//   Future<void> _ScanImage(XFile pickedImage) async{
//      final inputImg =  InputImage.fromFilePath(pickedImage.path);
//      final Recognizer = TextRecognizer(script: TextRecognitionScript.latin);
//      final scanedTxt = await Recognizer.processImage(inputImg);
//      RegExp amountRegex = RegExp(r'\b\d{1,3}(?:[.,]\d{3})*(?:[.,]\d{2})?\b');  // Matches currency amounts
//      RegExp dateRegex = RegExp(r'\b\d{1,2}[/-]\d{1,2}[/-]\d{2,4}\b');  // Matches dates
//      String amount= '';
//      String date= '';
//      Recognizer.close();
//
//      if(scanedTxt.blocks.isNotEmpty){
//        setState(() {
//          _nameController.text = scanedTxt.blocks.first.text;
//        });
//      }
//
//      for (TextBlock block in scanedTxt.blocks) {
//        for (TextLine line in block.lines) {
//          if (amount.isEmpty) {
//            var match = amountRegex.firstMatch(line.text);
//            if (match != null) {
//              setState(() {
//                _amountController.text = match.group(0)!;
//              });
//            }
//          }
//
//          if (date.isEmpty) {
//            var match = dateRegex.firstMatch(line.text);
//            if (match != null) {
//              setState(() {
//                _dateController.text = match.group(0)!;
//              });
//            }
//          }
//        }
//      }
//   }
//
//   Report Creat_Report_object(){
//     final report = Report(
//       report_name: widget.reportName ,
//       name: _nameController.text,
//       amount: double.tryParse(_amountController.text) ?? 0,
//       date : _dateController.text,
//       description: _descriptionController.text,
//       category: selectedOption,
//       vat: double.tryParse(_vatTaxController.text) ?? 0,
//       image: _selectedImage,
//       submitted: false,
//     );
//     _nameController.clear();
//     _amountController.clear();
//     _descriptionController.clear();
//     _dateController.clear();
//     _vatTaxController.clear();
//
//     _selectedImage = null;
//     return report;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: SingleChildScrollView(
//             child: Center(
//               child: Column(
//                 children: [
//                   // Radio buttons for selecting form type
//                   Text("How do you want to input your expense?",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
//                   Row(
//                       children: [
//                         Radio(
//                           value: 'Manual',
//                           groupValue: selectedOption,
//                           activeColor: usedColor,
//                           onChanged: (value) {
//                             setState(() {
//                               selectedOption = value!;
//                             });
//                           },
//                         ),
//                         Text('Manual input'),
//                       ]),
//                   GestureDetector(
//                     onTap:(){
//                       Select_photo_Dialog(context);
//                       },
//                     child :Row(
//                       children: [
//                         Radio(
//                             value: 'Scan',
//                             groupValue: selectedOption,
//                             activeColor: usedColor,
//                             onChanged: (value) {
//                               setState(() {
//                                 selectedOption = value!;
//                               });
//                             },
//                           ),
//
//                         Text('Scan receipt'),
//
//                       ]),
//                   ),
//                   Row(
//                     children: [
//                       Radio(
//                         value: 'Record',
//                         groupValue: selectedOption,
//                         activeColor: usedColor,
//                         onChanged: (value) {
//                           setState(() {
//                             selectedOption = value!;
//                           });
//                         },
//                       ),
//                       Text('Voice recognition'),
//                     ],
//                   ),
//                   // Display form based on selected option
//                   if (selectedOption == 'Manual')  _buildManualForm(),
//                   if (selectedOption == 'Scan') _buildScanForm(),
//
//                   if (selectedOption == 'Record')  _buildRecordForm(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//
//   }
//
//   // Manual Form
//   Widget _buildManualForm() {
//
//     String? dropdownValue;
//     dropdownValue = cateogryOptions[0];
//     String? selectedCategory =  cateogryOptions[1]; // Declare as a state variable
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text("Merchant Name",style: TextStyle(fontWeight: FontWeight.w300),),
//         TextField(
//           controller: _nameController,
//           decoration:InputDecoration(
//             hintText: "Name",
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
//             ),
//             hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
//
//           ),
//           cursorColor: usedColor,
//         ),
//         SizedBox(height: 15,),
//         Text("Amount",style: TextStyle(fontWeight: FontWeight.w300),),
//         TextField(
//           controller: _amountController,
//           decoration: InputDecoration(
//             hintText: "Amount",
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
//             ),
//             hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
//
//           ),
//           cursorColor: usedColor,
//         ),
//         SizedBox(height: 15,),
//         Text("Date",style: TextStyle(fontWeight: FontWeight.w300),),
//         TextField(
//           controller: _dateController,
//           decoration: InputDecoration(
//             hintText: "D/M/Y",
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
//             ),
//             hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
//
//           ),
//           cursorColor: usedColor,
//         ),
//         SizedBox(height: 15,),
//         Text("Description",style: TextStyle(fontWeight: FontWeight.w300),),
//
//         TextField(
//           controller: _descriptionController,
//           decoration: InputDecoration(
//             hintText: "Descritption",
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
//             ),
//             hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
//
//           ),
//           cursorColor: usedColor,
//         ),
//         SizedBox(height: 15,),
//         Text("Category",style: TextStyle(fontWeight: FontWeight.w300),),
//         TextButton(
//           onPressed:()=> showAddDialog(context),
//           child: Row(
//               children: [
//                 Icon(Icons.add,color: usedColor,size: 17,),
//                 Text("Add New Category",style: TextStyle(color: usedColor,fontSize: 15),),
//               ]),
//         ),
//         DropdownButton<String>(
//           value: dropdownValue,
//           icon: const Icon(Icons.arrow_downward),
//           elevation: 16,
//           underline: Container(
//             height: 2,
//             color: usedColor,
//           ),
//           onChanged: (String? value) {
//             // This is called when the user selects an item.
//             setState(() {
//               dropdownValue = value!;
//             });
//           },
//           items: cateogryOptions.map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//         ),
//
//         SizedBox(height: 15,),
//         ListTile(
//           leading: Transform.scale(
//             scale: 0.7,
//             child: Switch(
//               value: isActive,
//               activeColor: Colors.white,
//               activeTrackColor: usedColor,
//               onChanged: (value) {
//                 setState(() {
//                   isActive = value;
//                 });
//               },
//             ),
//           ),
//           title: Text("Include Vat tax",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
//         ),
//         SizedBox(height: 15,),
//         showVatTax(isActive,_vatTaxController),
//         DottedBorder(
//             dashPattern: [6,6,6,6],
//             borderType: BorderType.RRect,
//             color: usedColor,
//             padding: EdgeInsets.all(15),
//             child: GestureDetector(
//                 onTap: (){
//                   // _pickImage();
//                   Select_photo_Dialog(context);
//                 },
//                 child:  Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.add_circle_outline,color: Colors.grey,size: 20,),
//                     SizedBox(width: 15,),
//                     Text("Upload images",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 15),)
//                   ],
//                 )
//             )
//         ),
//         SizedBox(height: 10,),
//         if (_selectedImage != null)
//           Image.file(_selectedImage!, height: 100, width: 100),
//         SizedBox(height: 15,),
//         UsedGradientButton(
//           textButton: "Save Expense",
//           onPressedFunction: (){
//             var createdReport = Creat_Report_object();
//
//             Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Decside_Submit_or_Not(reportName: widget.reportName,report:createdReport)));
//           },
//         ),
//
//       ],
//     );
//   }
//   Widget _buildScanForm() {
//
//     String? dropdownValue;
//     dropdownValue = cateogryOptions[0];
//     String? selectedCategory =  cateogryOptions[1]; // Declare as a state variable
//       return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text("Merchant Name",style: TextStyle(fontWeight: FontWeight.w300),),
//         TextField(
//           controller: _nameController,
//           decoration:InputDecoration(
//             hintText: "Name",
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
//             ),
//             hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
//
//           ),
//           cursorColor: usedColor,
//         ),
//         SizedBox(height: 15,),
//         Text("Amount",style: TextStyle(fontWeight: FontWeight.w300),),
//         TextField(
//           controller: _amountController,
//           decoration: InputDecoration(
//             hintText: "Amount",
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
//             ),
//             hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
//
//           ),
//           cursorColor: usedColor,
//         ),
//         SizedBox(height: 15,),
//         Text("Date",style: TextStyle(fontWeight: FontWeight.w300),),
//         TextField(
//           controller: _dateController,
//           decoration: InputDecoration(
//             hintText: "D/M/Y",
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
//             ),
//             hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
//
//           ),
//           cursorColor: usedColor,
//         ),
//         SizedBox(height: 15,),
//         Text("Description",style: TextStyle(fontWeight: FontWeight.w300),),
//
//         TextField(
//           controller: _descriptionController,
//           decoration: InputDecoration(
//             hintText: "Descritption",
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
//             ),
//             hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
//
//           ),
//           cursorColor: usedColor,
//         ),
//         SizedBox(height: 15,),
//         Text("Category",style: TextStyle(fontWeight: FontWeight.w300),),
//         TextButton(
//           onPressed:()=> showAddDialog(context),
//           child: Row(
//               children: [
//                 Icon(Icons.add,color: usedColor,size: 17,),
//                 Text("Add New Category",style: TextStyle(color: usedColor,fontSize: 15),),
//               ]),
//         ),
//         DropdownButton<String>(
//           value: dropdownValue,
//           icon: const Icon(Icons.arrow_downward),
//           elevation: 16,
//           underline: Container(
//             height: 2,
//             color: usedColor,
//           ),
//           onChanged: (String? value) {
//             // This is called when the user selects an item.
//             setState(() {
//               dropdownValue = value!;
//             });
//           },
//           items: cateogryOptions.map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//         ),
//
//         SizedBox(height: 15,),
//         ListTile(
//           leading: Transform.scale(
//             scale: 0.7,
//             child: Switch(
//               value: isActive,
//               activeColor: Colors.white,
//               activeTrackColor: usedColor,
//               onChanged: (value) {
//                 setState(() {
//                   isActive = value;
//                 });
//               },
//             ),
//           ),
//           title: Text("Include Vat tax",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
//         ),
//         SizedBox(height: 15,),
//         showVatTax(isActive,_vatTaxController),
//         DottedBorder(
//             dashPattern: [6,6,6,6],
//             borderType: BorderType.RRect,
//             color: usedColor,
//             padding: EdgeInsets.all(15),
//             child: GestureDetector(
//                 onTap: (){
//                   // _pickImage();
//                   Select_photo_Dialog(context);
//                 },
//                 child:  Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.add_circle_outline,color: Colors.grey,size: 20,),
//                     SizedBox(width: 15,),
//                     Text("Upload images",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 15),)
//                   ],
//                 )
//             )
//         ),
//         SizedBox(height: 10,),
//         if (_selectedImage != null)
//           Image.file(_selectedImage!, height: 100, width: 100),
//         SizedBox(height: 15,),
//         UsedGradientButton(
//           textButton: "Save Expense",
//           onPressedFunction: (){
//             var createdReport = Creat_Report_object();
//
//             Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Decside_Submit_or_Not(reportName: widget.reportName,report:createdReport)));
//           },
//         ),
//       ],
//     );
//   }
//   void showAddDialog(BuildContext context) {
//     TextEditingController cateoryController = TextEditingController();
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20.0),
//           ),
//           child: Container(
//             padding: EdgeInsets.all(20.0),
//             height: 200,
//             child: Column(
//               children: [
//                 TextField(
//               controller: cateoryController,
//                   decoration: InputDecoration(
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(5),
//                     borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(5),
//                     borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
//                   ),
//                   hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
//                   )
//                 ),
//                 SizedBox(height: 20),
//             GradientButton(
//                 colors: [Color(0xFFFC3C58),Color(0xFFFE3B82),Color(0xFFE93385)],
//                 height: 50,
//                 width: 80,
//                 radius: 10,
//                 gradientDirection: GradientDirection.topToBottom ,
//                 textStyle: TextStyle(color: Colors.white,fontSize: 15),
//                 text: "Enter",
//                 onPressed: (){
//                   setState(() {
//                     cateogryOptions.add(cateoryController.text);
//                   });
//                   Navigator.pop(context);
//                 })
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   void Select_photo_Dialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20.0),
//             ),
//             child:  Container(
//               padding: EdgeInsets.all(20.0),
//               height: 250,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.close),
//                         onPressed: () {
//                           Navigator.of(context).pop(); // Close the dialog
//                         },
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 10,),
//                   UsedGradientButton(
//                     textButton: 'Take Photo', onPressedFunction: (){
//                     _pickImage('camera');
//                     Navigator.of(context).pop();
//                   },),
//                   SizedBox(height: 15,),
//                   UsedGradientButton(
//                     textButton: 'From Gallery', onPressedFunction: (){
//                       _pickImage('gallery');
//                     Navigator.of(context).pop();
//                   },)
//                 ],
//               ),
//             )
//         );
//       },
//     );
//   }
// }
// // Scan Form (you can customize this)
// Widget _buildRecordForm() {
//
//   return Text("Record ");
// }
// Widget showVatTax(bool isActive,_vatTaxController) {
//   if (isActive) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Text("Vat Tax",style: TextStyle(fontWeight: FontWeight.w300),),
//         TextField(
//           controller: _vatTaxController,
//           decoration: InputDecoration(
//             hintText: "Vat Tax",
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
//             ),
//             hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
//
//           ),
//           cursorColor: usedColor,
//         ),
//
//         SizedBox(height: 15,),
//       ],
//     );
//   } else {
//     return SizedBox(height: 15,); // Return an empty widget when inactive
//   }
// }
