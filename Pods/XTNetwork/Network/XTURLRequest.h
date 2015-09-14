//
//  LZAURLRequest.h
//  XiaoTu
//
//  Created by 何振东 on 15/6/30.
//  Copyright © 2015年 LeZhiAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

//定义上传文件类型
typedef NS_ENUM(NSUInteger, OFileType) {
    OFileTypeMP4   = 0,
    OFileTypePNG   = 1,
    OFileTypeJPG   = 2,
    OFileTypeGIF   = 3,
    OFileTypeJPEG  = 4,
    OFileTypeOther = 10
};


@interface XTURLRequest : NSObject <NSURLSessionDownloadDelegate>

/// 设置超时时间
//@property (assign, nonatomic) NSTimeInterval timeout;

/// 设置缓存策略
//@property (assign, nonatomic) NSURLRequestCachePolicy cachePolicy;

/// 设置请求方式
//@property (strong, nonatomic) NSString *httpMethod;

/// 类方法返回实例
+ (instancetype)request;

+ (void)get:(NSString *)urlPath params:(NSDictionary *)params completionHandler:(void (^) (id data, NSError *error))completionHandler;

/**
 *  POST请求
 *
 *  @param urlPath           请求地址
 *  @param params            请求参数
 *  @param tag               该请求标志位
 *  @param completionHandler 请求返回代理
 */
+ (void)post:(NSString *)urlPath params:(NSDictionary *)params completionHandler:(void (^)(id data, NSError *error))completionHandler;
+ (void)post:(NSString *)urlPath params:(NSDictionary *)params tag:(NSUInteger)tag completionHandler:(void (^)(id data, NSError *error, NSInteger tag))completionHandler;

/**
 *  同步请求
 *
 *  @param urlPath           请求地址
 *  @param params            请求参数
 *  @param completionHandler 返回代理
 */
+ (void)synchronousRequest:(NSString *)urlPath params:(NSDictionary *)params completionHandler:(void (^)(id data, NSError *error))completionHandler;

/**
 *  下载文件接口
 *
 *  @param fileUrl           要下载的文件链接地址
 *  @param toPath              将下载文件要存放的路径，包含文件包
 *  @param completionHandler 下载结束后的代理处理，若成功，则返回存储在本地的路径，失败返回错误处理
 */
+ (void)downloadFile:(NSString *)fileUrl toPath:(NSString *)toPath completionHandler:(void (^)(NSString *aFilePath, NSError *error))completionHandler;
- (void)downloadFile:(NSString *)fileUrl toPath:(NSString *)toPath completionHandler:(void (^)(NSString *aFilePath, NSError *error))completionHandler progress:(void (^)(CGFloat per))progress;


/**
 *  上传文件
 *
 *  @param fileData          要上传的文件
 *  @param filename          要上传文件的文件名，包含后缀名
 *  @param params            附带的参数列表
 *  @param toPath            上传文件的目标链接地址
 *  @param completionHandler 上传结束后的代理处理函数
 */
+ (void)uploadFile:(NSData *)fileData filename:(NSString *)filename fileType:(OFileType)fileType params:(NSDictionary *)params toPath:(NSString *)toPath completionHandler:(void (^)(id data, NSError *error))completionHandler;
- (void)uploadFile:(NSData *)fileData filename:(NSString *)filename fileType:(OFileType)fileType params:(NSDictionary *)params toPath:(NSString *)toPath completionHandler:(void (^)(id data, NSError *error))completionHandler progress:(void (^)(CGFloat per))progress;


@end
