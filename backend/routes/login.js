const express = require("express");
const crypto = require("crypto");
const route = express.Router();
const User = require("../schema/userSchema");
route.get("/", (req, res) => {
  res.send("Login Page");
});

route.get("/secret", async (req, res) => {
  const { username } = req.body;
  try {
    const response = await User.findOne({ username: username });
    console.log(response["publicKey"]);
    var dataToEncrypt = "Hello";
    const publicKey = response["publicKey"];
    const buffer = Buffer.from("Hello", "utf8");
    const encrypted = crypto.publicEncrypt(publicKey, buffer);
    res.send({ secret: encrypted.toString("base64") });
  } catch (err) {}
});

route.get("/verify", async (req, res) => {
  const { username, decryptedText, flag } = req.body;
  try {
    if (decryptedText == "Hello" && flag == 1) {
      res.send({ message: "granted" });
    } else {
      res.send({ message: "denied" });
    }
  } catch (err) {
    res.send({ message: err });
  }
});
module.exports = route;
