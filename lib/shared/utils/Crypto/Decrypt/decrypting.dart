import "dart:convert";
import "dart:typed_data";
import "package:pointycastle/export.dart";
import '../Helper/rsa_en_de.dart';

String getDecryptedData(RSAPrivateKey privateKey, String input){
  Uint8List bytes = Uint8List.fromList(base64Decode(input));
  Uint8List deData = rsaDecrypt(privateKey, bytes);
  String bytesde = utf8.decode(deData);
  return bytesde;
}