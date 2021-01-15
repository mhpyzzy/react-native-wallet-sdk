package com.wallet.sdk;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;

import wallet.Wallet_;


public class WalletSdkModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;

    Wallet_ w = null;

    public WalletSdkModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "WalletSdk";
    }


    // 通过1228-256字节的熵值创建返回一个随机生成的BIP-39助记词
    @ReactMethod
    public  void NewMnemonic(int bits, Promise promise){
        try {
            String mnemonic = wallet.Wallet.newMnemonic(bits);
            promise.resolve(mnemonic);

        }catch (Exception e){
            promise.reject(e.getMessage(),e);
        }
    }


    // 通过助记词和密码口令生成钱包种子
    @ReactMethod
    public  void NewSeed(String mnemonic,String password,Promise promise){
        try {
            String seed = wallet.Wallet.newSeedForMobile(mnemonic,password);
            promise.resolve(seed);

        }catch (Exception e){
            promise.reject(e.getMessage(),e);
        }
    }


    // 通过钱包种子创建一个SDK钱包
    @ReactMethod
    public void NewWallet(String seed,Promise promise){
        try {
            w = wallet.Wallet.newWalletForMobile(seed);
            promise.resolve("ok");

        }catch (Exception e){
            promise.reject(e.getMessage(),e);
        }
    }

    // 获取钱包的节点URL
    @ReactMethod
    public void GetNodeUrl(String coin,Promise promise){
        try {
            String url = w.nodeUrl(coin);
            promise.resolve(url);

        }catch (Exception e){
            promise.reject(e.getMessage(),e);
        }
    }


    // 设置钱包的节点URL
    @ReactMethod
    public void SetNodeUrl(String coin, String url, Promise promise){
        try {
            w.setNodeUrl(coin,url);
            promise.resolve("ok");

        }catch (Exception e){
            promise.reject(e.getMessage(),e);
        }
    }

    // 钱包根据币种和编号推导出账户地址
    @ReactMethod
    public void DeriveAddress(String coin, int seq,Promise promise){
        try {
            long _seq = seq;
            String addr = w.deriveAddress(coin,_seq);
            promise.resolve(addr);

        }catch (Exception e){
            promise.reject(e.getMessage(),e);
        }
    }

    // 钱包导出账户私钥
    @ReactMethod
    public void ExportAddressPrivateKey(String coin, int seq,Promise promise){
        try {
            long _seq = seq;
            String privateKey = w.exportAddressPrivateKey(coin,_seq);
            promise.resolve(privateKey);

        }catch (Exception e){
            promise.reject(e.getMessage(),e);
        }
    }

    // 钱包签名交易
    @ReactMethod
    public void Sign(String coin, int seq,String tx,Promise promise){
        try {
            long _seq = seq;
            String signResult = w.signForMobile(coin,_seq,tx);
            promise.resolve(signResult);

        }catch (Exception e){
            promise.reject(e.getMessage(),e);
        }
    }

    // 钱包广播交易
    @ReactMethod
    public void Broadcast(String coin, String signResult,Promise promise){
        try {
            String txID = w.broadcastForMobile(coin,signResult);
            promise.resolve(txID);

        }catch (Exception e){
            promise.reject(e.getMessage(),e);
        }
    }

    // 设置密钥路径
    @ReactMethod
    public void SetHttpPublicKeysPath(String coin,String path,Promise promise){
        try {
            w.setHttpPublicKeysPath(coin,path);
            promise.resolve("ok");

        }catch (Exception e) {
            promise.reject(e.getMessage(),e);
        }
    }
}
