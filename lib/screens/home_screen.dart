import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nft_app_test/components/button.dart';
import 'package:nft_app_test/components/pop_up_title.dart';
import 'package:nft_app_test/components/pop_up_description.dart';
import 'package:nft_app_test/components/pop_up_wallet_details.dart';
import 'package:provider/provider.dart';
import 'package:nft_app_test/providers/web3_linking_provider.dart';
import 'package:nft_app_test/services/ipfs_image_upload_service.dart';
import 'package:nft_app_test/services/ipfs_metadata_upload_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _textEditingController = TextEditingController();
  late String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: SafeArea(
          top: true,
          bottom: true,
          left: false,
          right: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Hey there!',
                      style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        // var balance = Provider.of<Web3LinkingProvider>(context,
                        //         listen: false)
                        //     .getWalletBalance()
                        //     .toString();
                        // String address = Provider.of<Web3LinkingProvider>(
                        //         context,
                        //         listen: false)
                        //     .getWalletAddress()
                        //     .toString();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return PopUpWalletDetails(
                                balance: '0.9945', address: '0xAE...15');
                          },
                        );
                      },
                      child: const CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/images/vector.png',
                        ),
                        radius: 20.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50.0),
                // Container(
                //   height: 400.0,
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(25.0),
                //     color: Colors.white,
                //   ),
                // ),
                // const Spacer(),
                Button(
                  height: 50.0,
                  tapFunction: () async {
                    await IpfsImageUploadService.pickImage(context);
                    debugPrint(
                      // ignore: use_build_context_synchronously
                      'Image cid: ${Provider.of<Web3LinkingProvider>(context, listen: false).getImageCid()}',
                    );
                  },
                  title: 'Upload Image',
                ),
                const SizedBox(height: 10.0),
                Button(
                  height: 50.0,
                  tapFunction: () async {
                    // await IpfsMetadataUploadService.uploadMetadata(context);
                  },
                  title: 'Upload Metadata',
                ),
                const SizedBox(height: 10.0),
                Button(
                  height: 50.0,
                  tapFunction: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return PopUpTitle();
                      },
                    );
                  },
                  title: 'Enter Title',
                ),
                const SizedBox(height: 10.0),
                Button(
                  height: 50.0,
                  tapFunction: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return PopUpDescription();
                      },
                    );
                  },
                  title: 'Enter Description',
                ),
                const SizedBox(height: 10.0),
                Button(
                  height: 50.0,
                  tapFunction: () async {
                    // await Provider.of<Web3LinkingProvider>(context,
                    //         listen: false)
                    //     .getCredentials();
                    // await Provider.of<Web3LinkingProvider>(context,
                    //         listen: false)
                    //     .safeMint(context);
                  },
                  title: 'Mint',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
