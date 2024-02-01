import "dart:convert";
import "dart:typed_data";
import "package:pointycastle/export.dart";
import '../Helper/rsa_en_de.dart';

String getEncryptedData(RSAPublicKey publicKey, String input){
  Uint8List bytes = Uint8List.fromList(utf8.encode(input));
  Uint8List enData = rsaEncrypt(publicKey, bytes);
  String bytesEn = base64Encode(enData);
  return bytesEn;
}