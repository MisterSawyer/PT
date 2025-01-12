import { ethers } from 'ethers'
import fs from "fs";

/**
 * Deploy the given contract
 * @param {string} contractName name of the contract to deploy
 * @param {Array<any>} args list of constructor' parameters
 * @param {Number} accountIndex account index from the exposed account
 * @return {Contract} deployed contract
 */
export const deploy = async (contractPath: string, contractName: string, args: Array<any>, accountIndex?: number): Promise<ethers.Contract> => {

  console.log(`deploying ${contractName}`)
  // Note that the script needs the ABI which is generated from the compilation artifact.
  // Make sure contract is compiled and artifacts are generated
  const artifactsPath = `artifacts/${contractPath}/${contractName}.sol/${contractName}.json` // Change this for different path

  const metadata = JSON.parse(fs.readFileSync(artifactsPath, 'utf8'));

  const provider = new ethers.JsonRpcProvider("http://localhost:8545/");

  const signer = await provider.getSigner(accountIndex);
  
  const factory = new ethers.ContractFactory<any[], ethers.Contract>(metadata.abi, metadata.bytecode, signer)

  const contract = await factory.deploy(...args)
  // The contract is NOT deployed yet; we must wait until it is mined
  await contract.waitForDeployment()
  return contract
}