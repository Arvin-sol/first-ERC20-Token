const {expect} =  require("chai");
const {ethers} = require("harhat")

let ERC 
let erc
let deployer 
let addr1

describe("test ERC contract", async function(){
    ERC = await ethers.getContractFactory("ERC")
    
})