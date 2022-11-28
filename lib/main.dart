import 'package:flutter/material.dart';
import 'package:nft_app_test/screens/home_screen.dart';
import 'package:nft_app_test/screens/welcome_screen.dart';
import 'package:nft_app_test/services/ipfs_metadata_upload_service.dart';
import 'package:provider/provider.dart';
import 'providers/web3_linking_provider.dart';
import 'services/ipfs_image_upload_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Web3LinkingProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NFT App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id : (context) => WelcomeScreen(),
          HomeScreen.id : (context) => HomeScreen(),
          NftAppTest.id : (context) => NftAppTest(),
        },
        home: const WelcomeScreen(),
      ),
    );
  }
}

class NftAppTest extends StatefulWidget {
  const NftAppTest({Key? key}) : super(key: key);
  static String id = 'main';


  @override
  State<NftAppTest> createState() => _NftAppTestState();
}

class _NftAppTestState extends State<NftAppTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: ElevatedButton(
              onPressed: () async {
                await Provider.of<Web3LinkingProvider>(context, listen: false)
                    .connectMetaMask();
                await Provider.of<Web3LinkingProvider>(context, listen: false).getCredentials();
              },
              child: const Text('Connect'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                await Provider.of<Web3LinkingProvider>(context, listen: false)
                    .disconnectMetaMask();
              },
              child: const Text('Disconnect'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                await IpfsImageUploadService.pickImage(context);
                debugPrint(
                  // ignore: use_build_context_synchronously
                  'Image cid: ${Provider.of<Web3LinkingProvider>(context, listen: false).getImageCid()}',
                );
              },
              child: const Text('Upload Image'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                await IpfsMetadataUploadService.uploadMetadata(context);
              },
              child: const Text('Upload Metadata'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                await Provider.of<Web3LinkingProvider>(context, listen: false).safeMint(context);
              },
              child: const Text('Mint NFT'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                await Provider.of<Web3LinkingProvider>(context, listen: false).getWalletBalance();
              },
              child: const Text('Check Balance'),
            ),
          ),
        ],
      ),
    );
  }
}
