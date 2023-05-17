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
    // print(encrypted.toString("base64"));
    // print(encryptedData.toString("base64"));
    // res.send(encrypted.toString("base64"));
    res.send({ secret: encrypted.toString("base64") });
  } catch (err) {}
});
module.exports = route;
