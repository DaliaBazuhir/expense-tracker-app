import 'package:expense_tracker/Settings/FinanicalDetails/bank_management_page.dart';
import 'package:expense_tracker/Settings/FinanicalDetails/display_all_banks_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_button/flutter_gradient_button.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import '../../constants/used_widgets.dart';
import '../../data/bank_data.dart';
class BankConsent extends StatelessWidget {
  BankConsent ({required this.selectedBank});
  Bank selectedBank;
  var bankmodel = BankModelView();
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
                    Text(selectedBank.bankConsent)
                    ),
                    SizedBox(height: 15,),
                    UsedGradientButton(textButton:"Agree", onPressedFunction: (){

                      Provider.of<BankModelView>(context, listen: false).AddBank(selectedBank);

                      Navigator.popUntil(context, (route) {
                        if (route.settings.name == BankMangementPage.id) {
                          return true;
                        }
                        return false;
                      });
                    }),
                    SizedBox(height: 15,),
                    UsedOutlinedButton(
                        text: "Cancel", raduis: 8,
                        onPressedFunction: (){
                          // Navigator.popUntil(context, (route) {
                          //   if (route.settings.name == DisplayBanks.id) {
                          //   return true;
                          //   }
                          //   return false;
                          //   });
                        }),
                  ],
                )
            )
        ),
        )
    );
  }
}
