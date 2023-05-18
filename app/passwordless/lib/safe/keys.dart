import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:passwordless/helper/fileHandler.dart';
import 'package:passwordless/helper/helper.dart';
import 'package:pointycastle/asymmetric/pkcs1.dart';
import 'package:pointycastle/asymmetric/rsa.dart';
import 'package:pointycastle/key_generators/rsa_key_generator.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:pointycastle/random/fortuna_random.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';

import '../helper/sharedPrefs.dart';

class Keys {
  var plainText = 'Hello';
  late String publicKey;
  late String privateKey;
  SharedPrefs shared = SharedPrefs();
  FileHandler file = FileHandler();
  Helper helper = Helper();
  List<String> generateRSAKeyPair(int bitLength) {
    // Create a random secure seed
    final secureRandom = FortunaRandom();
    final seedSource = Random.secure();
    final seeds = <int>[];
    for (var i = 0; i < 32; i++) {
      seeds.add(seedSource.nextInt(255));
    }
    secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));

    // Generate RSA key pair
    final keyGenParams = RSAKeyGeneratorParameters(
      BigInt.from(65537),
      bitLength,
      12,
    );
    final keyGenerator = RSAKeyGenerator();
    keyGenerator.init(ParametersWithRandom(keyGenParams, secureRandom));
    final keyPair = keyGenerator.generateKeyPair();
    publicKey = RsaKeyHelper()
        .encodePublicKeyToPemPKCS1(keyPair.publicKey as RSAPublicKey);
    privateKey = RsaKeyHelper()
        .encodePrivateKeyToPemPKCS1(keyPair.privateKey as RSAPrivateKey);
    print("Public Key :" + publicKey);
    print("Private key :" + privateKey);
    return [publicKey, privateKey];
  }

  encryptDecrypt(String username, String encryptedText) async {
    // var plainText = 'something';
    // String privateKeyString = await file.readFile();
    // var helper = RsaKeyHelper();
    // var publicKey = await shared.getPublicKey();
    // RSAPrivateKey privateConverted =helper.parsePrivateKeyFromPem(privateKeyString);
    // RSAPublicKey publickeyConverted = helper.parsePublicKeyFromPem(publicKey);

    // var encryptedText = encrypt(plainText, publickeyConverted);
    // var decryptedText = decrypt(encryptedText, privateConverted);

    // print("decrypted :" + decryptedText);

    String privateKey = await file.readFile();
    var publicKey = await shared.getPublicKey();
    var helper = RsaKeyHelper();

    RSAPrivateKey privateConverted = helper.parsePrivateKeyFromPem(privateKey);
    RSAPublicKey publickeyConverted = helper.parsePublicKeyFromPem(publicKey);

    var encryptedText = encrypt(plainText, publickeyConverted);
    var decryptedText = decrypt(encryptedText, privateConverted);

    return decryptedText;
  }
}
