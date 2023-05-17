import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/key_generators/rsa_key_generator.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:pointycastle/random/fortuna_random.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';

class Keys {
  late String publicKey;
  late String privateKey;

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

  encryptDecrypt() async {
    var plainText = 'something';

    var helper = RsaKeyHelper();

    RSAPrivateKey private_converted = helper.parsePrivateKeyFromPem(privateKey);
    RSAPublicKey publicKey_converted = helper.parsePublicKeyFromPem(publicKey);

    var encryptedText = encrypt(plainText, publicKey_converted);
    var decryptedText = decrypt(encryptedText, private_converted);

    print(" Encrypted :" + encryptedText);
    print(" Decrypted :" + decryptedText);
  }
}
