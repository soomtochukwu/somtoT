import { ethers } from "hardhat";

async function main() {
  const Token = await ethers.getContractFactory("SomtoT");
  const Somto = await ethers.deployContract("SomtoT");

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
