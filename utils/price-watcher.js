const CoinGecko = require("coingecko-api");
const Oracle = artifacts.require("Oracle.sol");

const INTERVAL = 6000;
const coinGeckoClient = new CoinGecko();

module.exports = async (done) => {
  const [_, reporter] = await web3.eth.getAccounts();
  const oracle = await Oracle.deployed();

  while (true) {
    const response = await coinGeckoClient.coins.fetch("bitcoin", {});

    let currentPrice = parseFloat(response.data.market_data.current_price.usd);
    currentPrice = parseInt(currentPrice * 100);

    await oracle.updateData(web3.utils.soliditySha3("BTC/USD"), currentPrice, {
      from: reporter,
    });
    console.log(`New price for BTC/USD ${currentPrice}`);
    await new Promise((resolve) => setTimeout(resolve, INTERVAL));
  }

  done();
};
