"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const hardhat_1 = require("hardhat");
async function main() {
    const Somto = await hardhat_1.ethers.deployContract("MaZi");
    await Somto.waitForDeployment();
    let addr = await Somto.getAddress();
    console.log("deployed SomtoT:", addr);
}
// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
