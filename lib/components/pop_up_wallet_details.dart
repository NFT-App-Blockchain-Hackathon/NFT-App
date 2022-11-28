import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nft_app_test/components/button.dart';
import 'package:provider/provider.dart';
import 'package:nft_app_test/providers/web3_linking_provider.dart';

class PopUpWalletDetails extends StatefulWidget {
  const PopUpWalletDetails({required this.balance, required this.address});
  final String balance;
  final String address;

  @override
  State<PopUpWalletDetails> createState() => _PopUpWalletDetailsState();
}

class _PopUpWalletDetailsState extends State<PopUpWalletDetails> {
  final _textEditingController = TextEditingController();


  dialogContent(BuildContext context) {
    return Container(
      height: 300.0,
      width: 300.0,
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0), color: Colors.black),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Your Wallet',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            'Balance: ${widget.balance}',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            'Address: ${widget.address}',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20.0),
          Button(
              height: 40.0,
              tapFunction: () {
                Navigator.pop(context);
              },
              title: 'Close'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}
