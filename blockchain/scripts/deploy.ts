import { network } from "hardhat";

async function main() {
  const { ethers } = await network.connect("localhost");

  const HoneyChain = await ethers.getContractFactory("HoneyChain");

  const honeyChain = await HoneyChain.deploy();

  await honeyChain.waitForDeployment();

  console.log("HoneyChain deployed to:", await honeyChain.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});