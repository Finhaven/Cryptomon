# Cryptomon ⛰🌪🔥🌊

[![CircleCI](https://circleci.com/gh/Finhaven/Cryptomon/tree/master.svg?style=svg)](https://circleci.com/gh/Finhaven/Cryptomon/tree/master)
[![Maintainability](https://api.codeclimate.com/v1/badges/5e696ad902abc5e35858/maintainability)](https://codeclimate.com/github/Finhaven/Cryptomon/maintainability)

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
> npm run truffle:compile
```

![](https://ethereum.org/images/logos/ETHEREUM-LOGO_LANDSCAPE_Black_small.png)

## Local REPL

```shell
> ganache-cli
```

```node
const Web3 = require('web3');

const provider = new Web3.providers.HttpProvider("http://localhost:8545");
const web3 = new Web3(provider);

const CritterFile = fs.readFileSync('./build/contracts/Critter.json');
const {abi, bytecode} = JSON.parse(CritterFile);

let accounts;
web3.eth.getAccounts().then(accs => {
  accounts = accs
});

// Prove that it worked
accounts; 

let hydroge;
new web3.eth.Contract(abi).deploy({
    data: bytecode,
    arguments: ["Hydroge", 1]
  }).send({
    from: accounts[0],
    gas: "1000000"
  }).then(deployed => {
    hydroge = deployed;
  });

// Prove that it worked
hydroge; 

// hydroge.methods.name().call({ from: accounts[0] }).then(res => console.log(JSON.stringify(res)));

const command = (funName, args = []) => {
  hydroge.methods[funName](...args).call({
    from: accounts[0]
  }).then(res => console.log(JSON.stringify(res)));
};

command('name');
// => "Hydroge"

command('selfHeal', [2]);
// => {}
```

![](https://i.ytimg.com/vi/oNIKXYtCqC4/maxresdefault.jpg)
