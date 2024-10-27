import 'package:flutter/material.dart';
import 'package:expense_tracker/data/bank_data.dart';
import 'package:expense_tracker/constants/used_widgets.dart';

import 'bank_consent_screen.dart';
class BankTermsPoints extends StatelessWidget {
  BankTermsPoints({required this.selectedBank});
  Bank selectedBank;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child:
        Padding(
            padding: EdgeInsets.all(10),
            child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(selectedBank.bankImage,width: 100,height: 100,),
                    SizedBox(height: 15,),
                    Expanded(child:
                    ListView.builder(itemCount: selectedBank.bankBussinessPoints.length,
                        itemBuilder: (BuildContext context,int index){
                          return Padding(
                            padding: EdgeInsets.all(5),
                            child: ListTile(
                              leading: Icon(Icons.circle,color: Colors.black,size: 10,),
                              title: Text(selectedBank.bankBussinessPoints[index]),
                            ),
                          );
                        }
                    )
                    ),
                    SizedBox(height: 15,),
                    UsedGradientButton(textButton:"Continue",
                        onPressedFunction: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BankConsent(selectedBank: selectedBank)));}
                    ),
                    SizedBox(height: 15,),

                  ],
                )
            )
        ),
        )
    );
  }
}
