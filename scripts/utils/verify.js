/* eslint-disable comma-dangle */
/* eslint-disable dot-notation */
const { run } = require("hardhat")
const hre = require("hardhat")
const { readFile } = require("fs/promises")

const main = async () => {
  const CONTRACTS_DEPLOYED = JSON.parse(
    await readFile("./scripts/deployed.json", "utf-8")
  )

  const fungibleToken = CONTRACTS_DEPLOYED["FungibleToken"][hre.network.name]

  try {
    await run("verify:verify", {
      address: fungibleToken.address,
      constructorArguments: fungibleToken.constructorArguments,
    })
  } catch (e) {
    console.log(e)
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })
