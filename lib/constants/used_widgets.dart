import 'package:flutter/material.dart';
import 'package:flutter_gradient_button/flutter_gradient_button.dart';
Color usedColor =  Color(0xFFFD3B82);
class UsedGradientButton extends StatelessWidget {
  UsedGradientButton({required this.textButton,required this.onPressedFunction});
  final String textButton;
  final Function onPressedFunction;
  @override
  Widget build(BuildContext context) {
    return GradientButton(

        colors: [Color(0xFFFC3C58),Color(0xFFFE3B82),Color(0xFFE93385)],
        height: 50,
        width: 80,
        radius: 10,
        gradientDirection: GradientDirection.topToBottom ,
        textStyle: TextStyle(color: Colors.white,fontSize: 15),
        text: textButton,
        onPressed: (){
          onPressedFunction();
        });
  }
}


class CustomTextField extends StatelessWidget {
  final String HintText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  const CustomTextField({
    Key? key,

    required this.HintText,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration:InputDecoration(
      hintText: HintText,
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
      validator: validator,
      onSaved: onSaved,
    );
  }
}

class UsedTextField extends StatelessWidget {
  const UsedTextField({
    required this.hintText,
    required this.onChangeFunction
  });
  final String hintText;
  final Function onChangeFunction;
  @override
  Widget build(BuildContext context) {
    return TextField(

      onChanged: onChangeFunction(),
      decoration: InputDecoration(
        hintText: hintText,
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
    );
  }
}


class UsedOutlinedButton extends StatelessWidget {
  UsedOutlinedButton({
    required this.text, required this.raduis, required this.onPressedFunction
  });
  final double raduis;
  final String text;
  final Function onPressedFunction;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressedFunction(),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: usedColor),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(raduis)),
          minimumSize: Size(double.infinity, 48),
        ),
        child: Text(text,style: TextStyle(color: usedColor),));
  }
}


class home_screen_Card extends StatelessWidget {
  home_screen_Card({required this.cardNumber,required this.cardText});
  final String cardNumber;
  final String cardText;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:  Container(
        height: 100,
        width: 160,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade400)

        ),
        child: ListTile(
          title: Text(cardNumber,style: TextStyle(fontWeight: FontWeight.w600),),
          subtitle: Text(cardText,style: TextStyle(fontWeight: FontWeight.w400),),

        ),
      ),);
  }
}


