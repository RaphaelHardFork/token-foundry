const { expect } = require("chai")
const { ethers } = require("hardhat")

describe("FungibleToken", () => {
  let user1, user2
  beforeEach(async () => {
    ;[user1, user2] = await ethers.getSigners()
  })

  it("Should deploy the contract", async () => {
    const FungibleToken = await ethers.getContractFactory("FungibleToken")
    const token = await FungibleToken.deploy(user1.address)
    await token.deployed()

    expect(await token.recipient()).to.equal(user1.address)
  })
})
