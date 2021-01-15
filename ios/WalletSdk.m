#import "WalletSdk.h"
#import "Wallet/Wallet.h"

@implementation WalletSdk

WalletWallet *wallet = nil;

RCT_EXPORT_MODULE()


// 通过1228-256字节的熵值创建返回一个随机生成的BIP-39助记词
RCT_EXPORT_METHOD(NewMnemonic:(int) bits resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    NSError *error = nil;
    NSString *mnemonic = WalletNewMnemonic(bits,&error);
    
    if(error){
        NSString *msg = [[NSString alloc]initWithFormat:@"%@",error.localizedDescription];
        reject(@"Error", msg,  error);
    }else{
        resolve(mnemonic);
    }
}

// 通过助记词和密码口令生成钱包种子
RCT_EXPORT_METHOD(NewSeed:(NSString *) mnemonic password:(NSString *)password resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    NSError *error = nil;
    NSString *seed = WalletNewSeedForMobile(mnemonic,password,&error);
    if(error){
        NSString *msg = [[NSString alloc]initWithFormat:@"%@",error.localizedDescription];
        reject(@"Error", msg,  error);
    }else{
        resolve(seed);
    }
}


// 通过钱包种子创建一个SDK钱包
RCT_EXPORT_METHOD(NewWallet:(NSString *) seed resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    NSError *error = nil;
    wallet = WalletNewWalletForMobile(seed,&error);
    if(error){
        NSString *msg = [[NSString alloc]initWithFormat:@"%@",error.localizedDescription];
        reject(@"Error", msg,  error);
    }else{
        resolve(@"ok");
    }
}


// 获取钱包的节点URL
RCT_EXPORT_METHOD(GetNodeUrl:(NSString *) coin resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    NSError *err = nil;
    NSString *url = [wallet nodeUrl:coin error:&err];
    if(err){
        NSString *msg = [[NSString alloc]initWithFormat:@"%@",err.localizedDescription];
        reject(@"Error", msg,  err);
    }else{
        resolve(url);
    }
}

// 设置钱包的节点URL
RCT_EXPORT_METHOD(SetNodeUrl:(NSString *) coin url:(NSString *)url resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    NSError *err = nil;
    [wallet setNodeUrl:coin url:url error:&err];
    if(err){
        NSString *msg = [[NSString alloc]initWithFormat:@"%@",err.localizedDescription];
        reject(@"Error", msg,  err);
    }else{
        resolve(@"ok");
    }
}

// 钱包根据币种和编号推导出账户地址
RCT_EXPORT_METHOD(DeriveAddress:(NSString *) coin seq:(int64_t)seq resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    NSError *err = nil;
    NSString *addr = [wallet deriveAddress:coin seq:seq error:&err];
    if(err){
        NSString *msg = [[NSString alloc]initWithFormat:@"%@",err.localizedDescription];
        reject(@"Error", msg,  err);
    }else{
        resolve(addr);
    }
}

// 钱包导出账户私钥
RCT_EXPORT_METHOD(ExportAddressPrivateKey:(NSString *) coin seq:(int64_t)seq resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    NSError *err = nil;
    NSString *privateKey = [wallet exportAddressPrivateKey:coin seq:seq error:&err];
    if(err){
        NSString *msg = [[NSString alloc]initWithFormat:@"%@",err.localizedDescription];
        reject(@"Error", msg,  err);
    }else{
        resolve(privateKey);
    }
}

// 钱包签名交易
RCT_EXPORT_METHOD(Sign:(NSString *) coin seq:(int64_t)seq tx:(NSString *)tx resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    NSError *err = nil;
    NSString *signResult = [wallet signForMobile:coin seq:seq tx:tx error:&err];
    if(err){
        NSString *msg = [[NSString alloc]initWithFormat:@"%@",err.localizedDescription];
        reject(@"Error", msg,  err);
    }else{
        resolve(signResult);
    }
}


// 钱包广播交易
RCT_EXPORT_METHOD(Broadcast:(NSString *) coin signedResult:(NSString *)signedResult resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    NSError *err = nil;
    NSString *txID = [wallet broadcastForMobile:coin signedResult:signedResult error:&err];
    if(err){
        NSString *msg = [[NSString alloc]initWithFormat:@"%@",err.localizedDescription];
        reject(@"Error", msg,  err);
    }else{
        resolve(txID);
    }
}


// 设置密钥路径
RCT_EXPORT_METHOD(SetHttpPublicKeysPath:(NSString *) coin path:(NSString *)path resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    NSError *err = nil;
    [wallet setHttpPublicKeysPath:coin path:path error:&err];
    if(err){
        NSString *msg = [[NSString alloc]initWithFormat:@"%@",err.localizedDescription];
        reject(@"Error", msg,  err);
    }else{
        resolve(@"ok");
    }
}
@end
