import { network } from "hardhat";

async function main() {
  const { ethers } = await network.connect("localhost");

  const contract = await ethers.getContractAt(
    "HoneyChain",
    "0x5FbDB2315678afecb367f032d93F642f64180aa3"
  );

const batchId = "BT-E7VNM3S7Y50O-20260909-01";
  const hash = await contract.getBatchRecordHash(batchId);

  console.log("Batch ID:", batchId);
  console.log("Record Hash:", hash);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});