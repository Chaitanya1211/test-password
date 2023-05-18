import 'package:passwordless/helper/fileHandler.dart';
import 'package:passwordless/helper/sharedPrefs.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';

class Helper {
  var plainText = "abc";
  late String publicKey;
  late String privateKey;
  SharedPrefs shared = SharedPrefs();
  FileHandler file = FileHandler();
  get(String username) async {
    String privateKey = await file.readFile();
    var publicKey = await shared.getPublicKey();
    var helper = RsaKeyHelper();

    RSAPrivateKey privateConverted = helper.parsePrivateKeyFromPem(privateKey);
    RSAPublicKey publickeyConverted = helper.parsePublicKeyFromPem(publicKey);

    var encryptedText = encrypt(plainText, publickeyConverted);
    var decryptedText = decrypt(encryptedText, privateConverted);
    var flag = 0;
    if (username == "rutvik") {
      return 1;
    } else {
      return 0;
    }
  }
}
