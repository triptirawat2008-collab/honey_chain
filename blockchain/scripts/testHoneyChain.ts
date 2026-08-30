import hre from "hardhat";

async function main() {
  const connection = await hre.network.connect();

  const contract = await connection.ethers.getContractAt(
    "HoneyChain",
    "0x5FbDB2315678afecb367f032d93F642f64180aa3"
  );

  console.log("Registering test beekeeper...");

  const tx = await contract.registerBeekeeper(
    "BK001",
    "ACTIVE"
  );

  await tx.wait();

  console.log("Beekeeper registered!");

  const beekeeper = await contract.beekeepers("BK001");

  console.log("Blockchain data:");
  console.log(beekeeper);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});