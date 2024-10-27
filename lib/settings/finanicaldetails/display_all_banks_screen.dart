import 'package:flutter/material.dart';
import 'package:expense_tracker/data/bank_data.dart';

import 'bank_terms_screen.dart';
class DisplayBanks extends StatelessWidget {
  static String id = "DisplayBanks";
  DisplayBanks({super.key});
  var bankModel = BankModelView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListView.builder(itemCount: bankModel.AllBanks.length ,
                            itemBuilder: (context,index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: ListTile(
                                    leading: Image.asset(
                                      bankModel.AllBanks[index].bankImage,
                                      width: 40, height: 40,),
                                    title: Text(bankModel.AllBanks[index].bankName),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(color: Colors.grey),
                                    ), //BankTerms_points
                                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BankTermsPoints(selectedBank: bankModel.AllBanks[index])))
                                ),
                              );
                            }),
                      )
                    ]
                )

            )
        )
    );
  }
}