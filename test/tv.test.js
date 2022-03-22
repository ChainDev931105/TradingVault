const TradingVault = artifacts.require('TradingVault');
const MockWETH = artifacts.require('MockWETH');

const PRINT_LOG = true;

contract('TradingVault test', async (accounts) => {
  let weth;
  let tv;

  it('check deployed', async () => {
    weth = await MockWETH.deployed();
    tv = await TradingVault.deployed();

    assert.notEqual(weth.address, undefined, 'MockWETH is not deployed');
    assert.notEqual(tv.address, undefined, 'TradingView is not deployed');
  });

  it('allow user', async() => {
    let allowedBefore = await tv.userPerm.call(accounts[1]);

    await tv.allowUser.sendTransaction(accounts[1]);

    let allowedAfter = await tv.userPerm.call(accounts[1]);

    assert.equal(allowedBefore, false, 'account should be not allowed before call');
    assert.equal(allowedAfter, true, 'account should be allowed after call');
  });

  it('wrap & unwrap', async() => {
    const balance0 = (await weth.balanceOf(accounts[1])).toNumber();
    const amount = 1000000000;

    // wrap
    await weth.deposit.sendTransaction({
      from: accounts[1],
      value: amount
    });
    const balance1 = (await weth.balanceOf(accounts[1])).toNumber();

    // unwrap
    await weth.withdraw.sendTransaction(amount, {
      from: accounts[1]
    });
    const balance2 = (await weth.balanceOf(accounts[1])).toNumber();
    assert.equal(balance1 - balance0, amount, 'wrap is not processed correctly');
    assert.equal(balance1 - balance2, amount, 'unwrap is not processed correctly');
  });

  it('deposit & withdraw WETH', async() => {
    const amount = 1000000000;
    // wrap
    await weth.deposit.sendTransaction({
      from: accounts[1],
      value: amount
    });
    const token = weth.address;

    const balance0 = (await tv.vaults.call(accounts[1], token)).balance.toNumber();

    // deposit
    await weth.approve.sendTransaction(tv.address, amount, {
      from: accounts[1]
    });
    await tv.deposit.sendTransaction(token, amount, {
      from: accounts[1]
    });
    const balance1 = (await tv.vaults.call(accounts[1], token)).balance.toNumber();

    // withdraw
    await tv.withdraw.sendTransaction(token, amount, {
      from: accounts[1]
    });
    const balance2 = (await tv.vaults.call(accounts[1], token)).balance.toNumber();

    assert.equal(balance1 - balance0, amount, 'deposit is not processed correctly');
    assert.equal(balance1 - balance2, amount, 'withdraw is not processed correctly');
  });

  it('depositETH & withdrawETH', async() => {
    const token = weth.address;

    const amount = 1000000000;
    const balance0 = (await tv.vaults.call(accounts[1], token)).balance.toNumber();

    // deposit
    await tv.depositETH.sendTransaction({
      from: accounts[1],
      value: amount
    });
    const balance1 = (await tv.vaults.call(accounts[1], token)).balance.toNumber();

    // withdraw
    await tv.withdrawETH.sendTransaction(amount, {
      from: accounts[1]
    });
    const balance2 = (await tv.vaults.call(accounts[1], token)).balance.toNumber();

    assert.equal(balance1 - balance0, amount, 'depositETH is not processed correctly');
    assert.equal(balance1 - balance2, amount, 'withdrawETH is not processed correctly');
  });
});
