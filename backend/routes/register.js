const express = require("express");
const route = express.Router();
const User = require("../schema/userSchema");
route.get("/", (req, res) => {
  res.send("Register route");
});

route.get("/check", async (req, res) => {
  const { username } = req.body;
  try {
    const response = await User.findOne({ username: username });

    if (response) {
      return res.status(200).json({ message: "user exists" });
    } else {
      return res.status(200).json({ message: "user does not exists" });
    }
  } catch (err) {
    res.send(err);
  }
});

route.post("/new", async (req, res) => {
  const { username, publicKey } = req.body;
  const user = new User({ username, publicKey });
  // do hashing here
  const newUser = user.save();

  if (newUser) {
    res.status(200).json({
      message: "User Registered Successfully",
      publicKey: publicKey,
    });
  } else {
    res.status(200).json({ message: "Failed" });
  }
});

module.exports = route;
