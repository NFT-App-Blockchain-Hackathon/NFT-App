import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/services.dart';
import 'package:nft_app_test/constants.dart';
import 'package:nft_app_test/services/ipfs_metadata_upload_service.dart';
import 'package:web3_connect/web3_connect.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class Web3LinkingProvider extends ChangeNotifier {
  // final String _rpcUrl = "http://127.0.0.1:7545";
  // final String _wsUrl = "ws://127.0.0.1:7545";

  final String _rpcUrl =
      "https://eth-goerli.g.alchemy.com/v2/AkraBvdw2CpY1s2DmHCZ-GCC6W64Tyjb";
  final String _wsUrl =
      "wss://eth-goerli.g.alchemy.com/v2/AkraBvdw2CpY1s2DmHCZ-GCC6W64Tyjb";

  bool isLoading = false;
  String? _imageCid;
  String? _metadataCid;
  String? _metadataUri;
  String? _title;
  String? _description;
  // String? _deployedName;
  Web3Client? _web3client;
  Web3Connect? _web3connect;
  String? _abiCode;
  EthereumAddress? _contractAddress;
  EthereumAddress? _walletAddress;
  EtherAmount? _walletBalance;
  Credentials? _credentials;
  DeployedContract? _contract;
  ContractFunction? _safeMint;
  ContractFunction? _tokenURI;

  Web3LinkingProvider() {
    setup();
  }

  setup() async {
    _web3connect = Web3Connect();
    _web3client = Web3Client(
      _rpcUrl,
      Client(),
      socketConnector: () {
        return IOWebSocketChannel.connect(_wsUrl).cast<String>();
      },
    );

    await getAbi();
    // await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiStringFile =
        await rootBundle.loadString('contracts/NftAppTest.json');
    final jsonAbi = jsonDecode(abiStringFile);

    _abiCode = jsonEncode(jsonAbi).toString();
    _contractAddress = EthereumAddress.fromHex(smartContractAddress);
    debugPrint('Contract Address $_contractAddress');
  }

  Future<void> getCredentials() async {
    // _credentials = _web3connect?.credentials;
    _credentials = EthPrivateKey.fromHex(metamaskAccountPrivateKey);
    // _walletAddress = EthereumAddress.fromHex(_web3connect!.account);
    _walletAddress = await _credentials!.extractAddress();
    debugPrint('Credentials ${_credentials.toString()}');
    debugPrint('Wallet Address ${_walletAddress.toString()}');
    notifyListeners();
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode!, "NftAppTest"), _contractAddress!);

    _safeMint = _contract!.function("safeMint");
    _tokenURI = _contract!.function("tokenURI");
  }

  safeMint(BuildContext context) async {
    isLoading = true;
    // await IpfsMetadataUploadService();
    await _web3client!.sendTransaction(
      _credentials!,
      Transaction.callContract(
        contract: _contract!,
        function: _safeMint!,
        parameters: [_walletAddress, _metadataUri],
      ),
      chainId: 5,
    );
    isLoading = false;
    debugPrint('NFT minted');
    notifyListeners();
  }

  Future<void> getWalletBalance() async {
    _walletBalance = await _web3client?.getBalance(_walletAddress!);
    debugPrint('Balance $_walletBalance');
    notifyListeners();
  }

  setImageCid(String cid) {
    _imageCid = cid;
    notifyListeners();
  }

  setMetadataCid(String cid) {
    _metadataCid = cid;
    notifyListeners();
  }

  setMetadataUri(String uri) {
    _metadataUri = uri;
    notifyListeners();
  }

  setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  setDescription(String description) {
    _description = description;
    notifyListeners();
  }

  getImageCid() {
    return _imageCid;
  }

  getMetadataCid() {
    return _metadataCid;
  }

  getWalletAddress() {
    return _walletAddress;
  }

  getTitle() {
    return _title;
  }

  getDescription() {
    return _description;
  }

  connectMetaMask() async {
    await _web3connect?.connect();
    notifyListeners();
  }

  disconnectMetaMask() async {
    await _web3connect?.disconnect();
    notifyListeners();
  }
}
