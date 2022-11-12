import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nft_app_test/constants.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:nft_app_test/providers/web3_linking_provider.dart';

class IpfsMetadataUploadService {
  static Future<String> uploadMetadata(BuildContext context) async {
    final response = await http.post(
      Uri.parse('https://api.nftport.xyz/v0/metadata'),
      headers: {
        'Content-Type': "application/json",
        'Authorization': nftPortApiKey,
      },
      body:
          "{\n  \"name\": \"Sydney Sweeny Test NFT\",\n  \"description\": \"Sydney Sweeny Sexy\",\n  \"file_url\": \"https://ipfs.io/ipfs/${Provider.of<Web3LinkingProvider>(context, listen: false).getImageCid()}\"\n}",
    );
    final data = jsonDecode(response.body);
    final metadataCid = data["metadata_uri"].substring(7);
    final metadataUri = '$ipfsBaseUri$metadataCid';
    // ignore: use_build_context_synchronously
    Provider.of<Web3LinkingProvider>(context, listen: false).setMetadataUri(metadataUri);
    debugPrint('Metadata cid: $metadataCid');
    debugPrint('Metadata uri: $metadataUri');
    return metadataUri;
  }
}
