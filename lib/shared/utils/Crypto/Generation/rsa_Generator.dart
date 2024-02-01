import 'dart:typed_data';
import 'package:pointycastle/api.dart' as crypto;
import 'dart:convert';
import '../../../storage.dart';
import '../Helper/CryptoUtils.dart';
import "package:pointycastle/export.dart";

class RSAGeneration {
  String _email;
  String _password;
  String myPublicKey = '';
  String myPrivateKey = '';

  RSAGeneration({required String email, required String password}) : _email = email, _password = password;

  Uint8List deriveKeyFromInput(String input) {
    Digest digest = SHA256Digest();
    Uint8List data = Uint8List.fromList(utf8.encode(input));
    Uint8List hash = digest.process(data);
    return hash;
  }

  AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey> generateRSAkeyPair(
      SecureRandom secureRandom,
      {int bitLength = 2048}) {
    // Create an RSA key generator and initialize it

    // final keyGen = KeyGenerator('RSA'); // Get using registry
    final keyGen = RSAKeyGenerator();

    keyGen.init(ParametersWithRandom(
        RSAKeyGeneratorParameters(BigInt.parse('65537'), bitLength, 64),
        secureRandom));

    // Use the generator
    print("Generating Key Pairs");
    final pair = keyGen.generateKeyPair();

    // Cast the generated key pair into the RSA key types

    final myPublic = pair.publicKey as RSAPublicKey;
    final myPrivate = pair.privateKey as RSAPrivateKey;
    print(myPublic);

    return AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey>(myPublic, myPrivate);
  }

  SecureRandom exampleSecureRandom() {
    String input = _email + _password;
    final seed = deriveKeyFromInput(input);
    final secureRandom = SecureRandom('Fortuna')
      ..seed(crypto.KeyParameter(seed));
    return secureRandom;
  }

  void generateMyRSAKeyPairs() {
    final pair = generateRSAkeyPair(exampleSecureRandom());
    print('GENERATED KEY PAIRS');
    final public = pair.publicKey;
    final private = pair.privateKey;
    print('PRIVATE KEY');
    myPrivateKey = CryptoUtils.encodeRSAPrivateKeyToPem(private);
    print(myPrivateKey);
    print('PUBLIC KEY');
    myPublicKey = CryptoUtils.encodeRSAPublicKeyToPem(public);
    print(myPublicKey);
    Storage.saveUserRSAKeys(myPublicKey, myPrivateKey);
    _email = '';
    _password = '';
  }
}
RSAPublicKey decodeRSAPublicKeyFromPem(String input){
  RSAPublicKey publicKey =  CryptoUtils.rsaPublicKeyFromPem(input);
  return publicKey;
}
RSAPrivateKey decodeRSAPrivateKeyFromPem(String input){
  RSAPrivateKey privateKey =  CryptoUtils.rsaPrivateKeyFromPem(input);
  return privateKey;
}