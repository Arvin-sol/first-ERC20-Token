require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.9",
  networks:{
    mumbai:{
      url:"https://rpc-mumbai.maticvigil.com",
      accounts:["495f8fbe41f5484cd5f1517dfd06ebd4b2dd1dea3e60e43122dc1d67f36ae30d"]
    }
  }
};
