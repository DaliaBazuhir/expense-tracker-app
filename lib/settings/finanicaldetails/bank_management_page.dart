import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../constants/used_widgets.dart';
import '../../data/bank_data.dart';
import 'display_all_banks_screen.dart';

class BankMangementPage extends StatefulWidget {
  static String id ="Bank Mangement Page";

  @override
  State<BankMangementPage> createState() => _BankMangementPageState();
}

class _BankMangementPageState extends State<BankMangementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Consumer<BankModelView>(
            builder: (context, bankModelView, child) {
              List<Bank> addedBanksByUser = bankModelView.UserAddedBanks;

              return addedBanksByUser.isEmpty
                  ? UserDont_HaveBanks(context)
                  : User_HaveBanks(context, addedBanksByUser);
            },
          ),
        ),
      ),
    );
  }
}

Widget UserDont_HaveBanks(BuildContext context){
  return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "No Linked Financial Apps!",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 15),
        Text(
          "Link your frequently used financial app to input expense Claims faster",
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 25),
        UsedGradientButton(
          textButton: "Link Financial App",
          onPressedFunction: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DisplayBanks())), // Add any further action if required
        ),
      ]
  );
}
Widget User_HaveBanks(BuildContext context, List<Bank> addedBanksBy_User) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisAlignment: MainAxisAlignment.start, // Aligns the content to the top
    children: [
      Text(
        "You have linked one of your frequently used financial apps to ExpenseTracker",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      SizedBox(height: 8),
      Flexible(
        child: Consumer<BankModelView>(
          builder: (context, bankModelView, child) {
            return ListView.builder(
              itemCount: addedBanksBy_User.length,
              itemBuilder: (context, index) {
                final bank = addedBanksBy_User[index];

                return Dismissible(
                  key: Key(bank.bankName),
                  background: Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: AlignmentDirectional.centerStart,
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {

                    Provider.of<BankModelView>(context, listen: false)
                        .RemoveBank(bank);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${bank.bankName} removed')),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5), // Reduced padding between list items
                    child: ListTile(
                      leading: Image.asset(
                        bank.bankImage,
                        width: 40,
                        height: 40,
                      ),
                      title: Text(bank.bankName),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      SizedBox(height: 10),  // Reduced space between the ListView and the GestureDetector
      GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DisplayBanks()),
        ),
        child: Text(
          "Link More Financial App",
          style: TextStyle(
              color: usedColor, fontWeight: FontWeight.w600, fontSize: 16),
          textAlign: TextAlign.center, // Centered text
        ),
      ),
    ],
  );
}

