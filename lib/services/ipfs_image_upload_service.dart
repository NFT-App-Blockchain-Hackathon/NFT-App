import 'package:flutter/material.dart';
import 'package:flutter_ipfs/flutter_ipfs.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:nft_app_test/providers/web3_linking_provider.dart';

class IpfsImageUploadService {

  static Future<XFile?> pickImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();

    try {
      // Pick an image
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      //Nothing picked
      if (image == null) {
        Fluttertoast.showToast(
          msg: 'No Image Selected',
        );
        return null;
      } else {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => const ProgressDialog(
            status: 'Uploading to IPFS',
          ),
        );
        // upload image to ipfs
        final cid = await FlutterIpfs().uploadToIpfs(image.path);
        // ignore: use_build_context_synchronously
        Provider.of<Web3LinkingProvider>(context, listen: false).setImageCid(cid);
        debugPrint(cid);

        // Popping out the dialog box
        // ignore: use_build_context_synchronously
        Navigator.pop(context);

        //Return Path
        return image;
      }
    } catch (e) {
      debugPrint('Error at image picker: $e');
      SnackBar(
        content: Text(
          'Error at image picker: $e',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15),
        ),
      );
      return null;
    }
  }
}
