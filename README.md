# Luna

[![CircleCI](https://circleci.com/gh/Finhaven/Luna/tree/master.svg?style=svg)](https://circleci.com/gh/Finhaven/Luna/tree/master)
[![Maintainability](https://api.codeclimate.com/v1/badges/5e696ad902abc5e35858/maintainability)](https://codeclimate.com/github/Finhaven/Luna/maintainability)

Finhaven tokens and other [Ethereum](https://ethereum.org) smart contracts

We are using the [Truffle Framework](http://truffleframework.com/)

## Install

```shell
> npm install
```

## Test

```shell
> npm run test
```

## Compile

However, if you change smart contracts, you will need to recompile them. You can do this with

```shell
> truffle compile
> truffle migrate
```

![](https://ethereum.org/images/logos/ETHEREUM-LOGO_LANDSCAPE_Black_small.png)

## Local REPL

```bash
> ganache-cli
```

```node
const Web3 = require('web3');

const provider = new Web3.providers.HttpProvider("http://localhost:8545");
const web3 = new Web3(provider);

const CritterFile = fs.readFileSync('./build/contracts/Critter.json');
const {abi, bytecode} = JSON.parse(CritterFile);

let accounts;
web3.eth.getAccounts().then(as => accounts = as);

// Prove that it worked
accounts; 

let squirtle;
new web3.eth.Contract(abi).deploy({
    data: bytecode,
    arguments: ["Squirtle", 1]
  }).send({
    from: accounts[0],
    gas: "1000000"
  }).then(result => squirtle = result);

// Prove that it worked
squirtle; 

// squirtle.methods.name().call({ from: accounts[0] }).then(res => console.log(JSON.stringify(res)));

const command = (funName, args = []) => {
  squirtle.methods[funName](...args).call({
    from: accounts[0]
  }).then(res => console.log(JSON.stringify(res)));
};

command('selfHeal', [2]);
```
