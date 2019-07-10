
Transfer: event({_from: indexed(address),_to: indexed(address),_value: unit256})
Approval: event({_owner: indexed(address), _spender: indexed(address), _value:unit256})

name: public(string[64])
symbol: public(string[32])
decimal: public(unit256)

balanceOf: public(map(address, unit256))
allowances: map(address, map(address,unit256))

total_supply: unit256

@public
def __init__(_name:string[64],_symbol:string[32],_decimals:unit256,_supply:unit256):
	init_supply: unit256 = _supply * 10 * _decimals
	self.name = _name
	self.symbol = _symbol
	self.decimal = _decimals
	self.total_supply = init_supply
	log.Transfer(ZERO_ADDRESS,msg.sender,init_supply)


@public
@constant
def totalSupply() ->unit256:
	return total_supply

@public
@constant
def allowance(_owner:address, _spender:address) ->unit256:
	return self.allowances[_owner][_spender]

@public
@constant
def transfer(_to:address,_value:unit256) -> bool:
	self.balanceOf[msg.sender] -= _value
	self.balanceOf[_to] +=_value
	log.Transfer(msg.sender,_to,_value)
	return True

@public
def transferFrom(_from:address,, _to:address,_value:unit256) ->bool:
	self.balanceOf[_from] -= _value
	self.balanceOf[_to] += _value
	self.allowances[_from][msg.sender] -= _value
	log.Transfer(_from, _to, _value)
	return True

@public
def approve(_spender:address,_value:unit256)->bool:
	self.allowances[msg.sender][_spender] = _value
	log.Approval(msg.sender, _spender, _value)
	return True