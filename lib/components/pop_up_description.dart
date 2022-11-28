import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nft_app_test/components/button.dart';
import 'package:provider/provider.dart';
import 'package:nft_app_test/providers/web3_linking_provider.dart';

class PopUpDescription extends StatefulWidget {
  @override
  State<PopUpDescription> createState() => _PopUpDescriptionState();
}

class _PopUpDescriptionState extends State<PopUpDescription> {
  final _textEditingController = TextEditingController();

  late String description;

  dialogContent(BuildContext context) {
    return Container(
      height: 200.0,
      width: 300.0,
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0), color: Colors.black),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Enter the title',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          // const SizedBox(height: 20.0),
          TextField(
            cursorColor: Colors.white,
            maxLines: 1,
            controller: _textEditingController,
            onChanged: (value) => setState(() {
              description = value;
              print(description);
            }),
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
            decoration: InputDecoration(
              filled: false,
              hintText: 'Type here',
              hintStyle: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Button(
              height: 40.0,
              tapFunction: () {
                Provider.of<Web3LinkingProvider>(context, listen: false)
                    .setDescription(
                  description,
                );
                print('Description');
                print(
                  Provider.of<Web3LinkingProvider>(context, listen: false)
                      .getDescription(),
                );
                Navigator.pop(context);
              },
              title: 'Submit'),
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
