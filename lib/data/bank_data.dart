import 'package:flutter/cupertino.dart';

class Bank{
  final String bankImage;
  final String bankName;
  List<String> bankBussinessPoints;
  final String bankConsent;
   bool isAddedByUser = false;
  Bank({required this.bankImage,required this.bankName,
    required this.bankBussinessPoints,
    required this.bankConsent,this.isAddedByUser = true});
}

class BankModelView extends ChangeNotifier{
  List<Bank> UserAddedBanks =[];
  void AddBank(Bank selectedBank){
    UserAddedBanks.add(selectedBank);
    notifyListeners();
  }
  void RemoveBank(Bank selectedBank){
    UserAddedBanks.remove(selectedBank);
    notifyListeners();
  }
  List<Bank> AllBanks =[
    Bank(bankImage: "images/LLOYDS.png",bankName: "Lloyds Bank Business Banking",
        bankBussinessPoints: [
          "We’ll ask for your consent to share your bank transactions with ExpenseTracker",
          "You’ll sign in to Lloyds Bank Business Banking to authorise the connection",
          "We’ll bring you back here to finalise linking"
        ],
        bankConsent: "Lorem ipsum dolor sit amet consectetur.Sit purus id rhoncus arcu et porta. A sed posuere leo mi. Quisque et non penatibus senectus aliquet auctor amet. Sed sed pretium egestas justo gravida congue risus in augue. Quis auctor luctus quam porta lectus.\nUt sed nulla nibh massa pretium nunc ipsum laoreet in. Sagittis amet tortor id sem bibendum aliquam tellus pellentesque proin. Vitae urna vitae semper pellentesque. Donec dictumst ornare magna nisi a. Gravida amet felis in placerat egestas diam curabitur. Dolor sed nulla cras neque bibendum sed tempus et. Cursus scelerisque viverra venenatis dolor egestas sed vitae aliquam feugiat. Est mi egestas morbi venenatis iaculis. Scelerisque commodo sed pellentesque in. Amet massa fringilla dignissim."
    ),
    Bank(bankImage: "images/Starling.png",bankName: "Starling Bank",
        bankBussinessPoints: [
          "We’ll ask for your consent to share your bank transactions with ExpenseTracker",
          "You’ll sign in to Lloyds Bank Business Banking to authorise the connection",
          "We’ll bring you back here to finalise linking"
        ],
        bankConsent: "Lorem ipsum dolor sit amet consectetur.Sit purus id rhoncus arcu et porta. A sed posuere leo mi. Quisque et non penatibus senectus aliquet auctor amet. Sed sed pretium egestas justo gravida congue risus in augue. Quis auctor luctus quam porta lectus.\nUt sed nulla nibh massa pretium nunc ipsum laoreet in. Sagittis amet tortor id sem bibendum aliquam tellus pellentesque proin. Vitae urna vitae semper pellentesque. Donec dictumst ornare magna nisi a. Gravida amet felis in placerat egestas diam curabitur. Dolor sed nulla cras neque bibendum sed tempus et. Cursus scelerisque viverra venenatis dolor egestas sed vitae aliquam feugiat. Est mi egestas morbi venenatis iaculis. Scelerisque commodo sed pellentesque in. Amet massa fringilla dignissim."
    ),
    Bank(bankImage: "images/HSBC.png",bankName: "HSBC Bank - Business Banking",
        bankBussinessPoints: [
          "We’ll ask for your consent to share your bank transactions with ExpenseTracker",
          "You’ll sign in to Lloyds Bank Business Banking to authorise the connection",
          "We’ll bring you back here to finalise linking"
        ],
        bankConsent: "Lorem ipsum dolor sit amet consectetur.Sit purus id rhoncus arcu et porta. A sed posuere leo mi. Quisque et non penatibus senectus aliquet auctor amet. Sed sed pretium egestas justo gravida congue risus in augue. Quis auctor luctus quam porta lectus.\nUt sed nulla nibh massa pretium nunc ipsum laoreet in. Sagittis amet tortor id sem bibendum aliquam tellus pellentesque proin. Vitae urna vitae semper pellentesque. Donec dictumst ornare magna nisi a. Gravida amet felis in placerat egestas diam curabitur. Dolor sed nulla cras neque bibendum sed tempus et. Cursus scelerisque viverra venenatis dolor egestas sed vitae aliquam feugiat. Est mi egestas morbi venenatis iaculis. Scelerisque commodo sed pellentesque in. Amet massa fringilla dignissim."
    ),
    Bank(bankImage: "images/LLOYDS.png",bankName: "Egypt Bank Business Banking",
        bankBussinessPoints: [
          "We’ll ask for your consent to share your bank transactions with ExpenseTracker",
          "You’ll sign in to Lloyds Bank Business Banking to authorise the connection",
          "We’ll bring you back here to finalise linking"
        ],
        bankConsent: "Lorem ipsum dolor sit amet consectetur.Sit purus id rhoncus arcu et porta. A sed posuere leo mi. Quisque et non penatibus senectus aliquet auctor amet. Sed sed pretium egestas justo gravida congue risus in augue. Quis auctor luctus quam porta lectus.\nUt sed nulla nibh massa pretium nunc ipsum laoreet in. Sagittis amet tortor id sem bibendum aliquam tellus pellentesque proin. Vitae urna vitae semper pellentesque. Donec dictumst ornare magna nisi a. Gravida amet felis in placerat egestas diam curabitur. Dolor sed nulla cras neque bibendum sed tempus et. Cursus scelerisque viverra venenatis dolor egestas sed vitae aliquam feugiat. Est mi egestas morbi venenatis iaculis. Scelerisque commodo sed pellentesque in. Amet massa fringilla dignissim."
    ),

  ];


}
