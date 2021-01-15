# react-native-wallet-sdk

## 安装

`yarn add react-native-wallet-sdk`

### ios
```
  $ cd ios
  $ pod install

```
### android 
```
android studio导入 wallet.aar: 
File --> New --> New Module --> 选择 import .JAR/.ARR Package
```

## 使用
```javascript
import WalletSdk from 'react-native-wallet-sdk';

/**
 * @desc 生成助记词
 * @params bits :number
 * @return Promise<string>
*/
const mnemonic = await WalletSdk.NewMnemonic(256)

/**
 * @desc 通过助记词和密码口令生成钱包种子 
 * @params mnemonic :string
 * @params password :string
 * @return Promise<string>
*/
const seed = await WalletSdk.NewSeed(mnemonic, password)

/**
 * @desc 通过钱包种子创建一个SDK钱包 
 * @params seed :string // NewSeed 生成的钱包种子
 * @return Promise<string> 成功返回：‘ok’
*/
const isOk = await WalletSdk.NewWallet(seed);

/**
 * @desc 设置钱包的节点URL 
 * @params coin :string
 * @params url :string
 * @return Promise<string> 成功返回：‘ok’
*/
const isOk = await WalletSdk.SetNodeUrl(coin, url);

/**
 * @desc 钱包根据币种和编号推导出账户地址 
 * @params coin :string
 * @params seq :number
 * @return Promise<string>
*/
const addr = await WalletSdk.DeriveAddress(coin, seq);

/**
 * @desc 钱包导出账户私钥
 * @params coin :string
 * @params seq :number
 * @return Promise<string>
*/
const privateKey = await WalletSdk.ExportAddressPrivateKey(coin, seq);

/**
 * @desc 钱包签名交易
 * @params coin :string
 * @params seq :number
 * @params tx :string // json 字符串
 * @return Promise<string>
*/
const signResult = await WalletSdk.Sign(coin, seq,JSON.stringify({
  To:       "xxxxxxxxxxb",
  Amount:   0.5,
  GasPrice: 21,
  GasLimit: 21000,
  Nonce:    1,
}));

/**
 * @desc 钱包广播交易
 * @params coin :string
 * @params signResult :string // Sign 生成的签名
 * @return Promise<string>
*/
const txID = await WalletSdk.Broadcast('eth', signResult);

```

## 示例参考
`/react-native-wallet-sdk/example`
