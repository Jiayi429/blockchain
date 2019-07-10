const SHA256 = require('crypto-js/sha256');

class Block{
	constructor(index,timestamp,data,previoushash=''){
		this.BlockNo = index;
		this.timestamp = timestamp;
		this.data = data;
		this.previoushash = previoushash;
		this.hash = this.toHash();
	}
	toHash(){
		return SHA256(this.index+this.previoushash+this.timestamp+JSON.stringify(this.data)).toString()
	}
}

class Blockchain{
	constructor(){
		this.chain = [this.creategenesisblock()];
	}
	creategenesisblock(){
		return new Block(0,"01/01/2017","Genesis Block","0")
	}
	getlatestblock(){
		return this.chain[this.chain.length-1];
	}
	addblock(newblock){
		newblock.previoushash = this.getlatestblock().hash
		newblock.hash = newblock.toHash();
		this.chain.push(newblock);
	}
	isvalid(){
		for(let i=1; i<this.chain.length;i++){
			const currentblock = this.chain[i];
			const previousblock = this.chain[i-1];
			if(currentblock.hash!=currentblock.toHash()){
				return false;
			}
			if(currentblock.previoushash!=previousblock.hash){
				return false;
			}
			return true;
		}
	}
}

let myChain = new Blockchain();
myChain.addblock(new Block(1,"12/25/2017",{amount:5}));
myChain.addblock(new Block(2,"12/25/2017",{amount:6}));

console.log(JSON.stringify(myChain,null,4));
console.log("Is the blockchain valid?"+myChain.isvalid());
