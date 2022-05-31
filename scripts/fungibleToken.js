const hre = require("hardhat")
const { ethers } = require("hardhat")
const { deployed } = require("./utils/deployed")

const ADDRESS_ZERO = ethers.constants.AddressZero

const main = async () => {
  const [deployer] = await ethers.getSigners()
  console.log("Deploying contracts with the account:", deployer.address)

  const FungibleToken = await hre.ethers.getContractFactory("FungibleToken")
  const token = await FungibleToken.deploy(deployer.address)
  await token.deployed()
  await deployed("FungibleToken", hre.network.name, token.address, [
    deployer.address,
  ])
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })
