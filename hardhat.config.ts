import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require("dotenv").config();

const config: HardhatUserConfig = {
  solidity: "0.8.19",
  networks:{
    sepolia:{
      url:"https://eth-sepolia.g.alchemy.com/v2/9E2aTJwVzphtoZ59u4-dD7mKIA4-o__A",
      // @ts-ignore
      accounts:[process.env.WALLET]
    }
  },
  etherscan:{
    apiKey:process.env.ETHERSCAN
  }
};

export default config;
