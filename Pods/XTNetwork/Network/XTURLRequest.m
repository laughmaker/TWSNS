//
//  LZAURLRequest.m
//  XiaoTu
//
//  Created by 何振东 on 15/6/30.
//  Copyright © 2015年 LeZhiAn. All rights reserved.
//

#import "XTURLRequest.h"

// block self
#define XT_WeakSelf  __weak typeof (self)weakSelf = self;
#define XT_StrongSelf typeof(weakSelf) __strong strongSelf = weakSelf;

@interface XTURLRequest ()<NSURLSessionDataDelegate, NSURLSessionTaskDelegate>
/// 下载成功后代理
@property (copy, nonatomic) void (^downloadComptionHandler) (NSString *aFilePath, NSError *error);

/// 上传下载进度
@property (copy, nonatomic) void (^progress) (CGFloat per);

/// 下载目标路径
@property (copy, nonatomic) NSString *downloadDestinationPath;

@end


@implementation XTURLRequest

+ (instancetype)request
{
    return [[XTURLRequest alloc] init];
}

+ (void)get:(NSString *)urlPath params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler
{
    NSMutableString *paramsString = @"?".mutableCopy;
    for (NSString *key in params.allKeys) {
        [paramsString appendFormat:@"%@=%@&", key, params[key]];
    }
    NSString *url = [NSString stringWithFormat:@"%@%@", urlPath, paramsString];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod = @"GET";

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

        id responseObject = nil;
        NSError *err = nil;
        if (data) {
            responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
        }

        if (completionHandler) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(responseObject, error);
            });
        }
    }];
    [task resume];
}

+ (void)post:(NSString *)urlPath params:(NSDictionary *)params completionHandler:(void (^)(id data, NSError *error))completionHandler
{
    [[self class] post:urlPath params:params tag:-1 completionHandler:^(id data, NSError *error, NSInteger tag) {
        if (completionHandler) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(data, error);
            });
        }
    }];
}

+ (void)post:(NSString *)urlPath params:(NSDictionary *)params tag:(NSUInteger)tag completionHandler:(void (^)(id data, NSError *error, NSInteger tag))completionHandler
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    NSURLRequest *request = [[self class] requestForPath:urlPath withParams:params isGet:NO];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

        id responseObject = nil;
        NSError *err = nil;
        if (data) {
            responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
        }
        
        if (completionHandler) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(responseObject, error, tag);
            });
        }
    }];
    [task resume];
}

+ (void)downloadFile:(NSString *)fileUrl toPath:(NSString *)toPath completionHandler:(void (^)(NSString *aFilePath, NSError *error))completionHandler
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    NSURL *url = [NSURL URLWithString:fileUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:600];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error)
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

        NSData *data = [NSData dataWithContentsOfURL:location];
        [[self class] saveData:data atPath:toPath];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (location) {
                if (completionHandler) {
                    completionHandler(toPath, error);
                }
            }
            else {
                if (completionHandler) {
                    completionHandler(nil, error);
                }
            }
        });
    }];
    [task resume];
}


- (void)downloadFile:(NSString *)fileUrl toPath:(NSString *)toPath completionHandler:(void (^)(NSString *aFilePath, NSError *error))completionHandler progress:(void (^)(CGFloat per))progress
{
    self.downloadComptionHandler = completionHandler;
    self.progress = progress;
    self.downloadDestinationPath = toPath;
    
    NSURL *url = [NSURL URLWithString:fileUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:600];
    NSURLSessionConfiguration *configure = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configure delegate:self delegateQueue:nil];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request];
    [task resume];
}

+ (void)uploadFile:(NSData *)fileData filename:(NSString *)filename fileType:(OFileType)fileType params:(NSDictionary *)params toPath:(NSString *)toPath completionHandler:(void (^)(id data, NSError *error))completionHandler;
{
    XT_WeakSelf;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    NSURLRequest *request = [[self class] uploadRequestForPath:toPath withPath:params fileType:fileType filename:filename fileData:fileData];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

        [[weakSelf class] handleUploadWithData:data error:error compleTionHanlder:completionHandler];
    }];
    [dataTask resume];
}

- (void)uploadFile:(NSData *)fileData filename:(NSString *)filename fileType:(OFileType)fileType params:(NSDictionary *)params toPath:(NSString *)toPath completionHandler:(void (^)(id data, NSError *error))completionHandler progress:(void (^)(CGFloat per))progress;
{
    XT_WeakSelf;
    
    self.progress = progress;
    
    NSURLRequest *request = [[self class] uploadRequestForPath:toPath withPath:params fileType:fileType filename:filename fileData:fileData];
    NSURLSessionConfiguration *configure = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configure delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        [[weakSelf class] handleUploadWithData:data error:error compleTionHanlder:completionHandler];
    }];
    [task resume];
}

+ (void)handleUploadWithData:(NSData *)data error:(NSError *)error compleTionHanlder:(void (^)(id data, NSError *error))completionHandler
{
    if (completionHandler) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                completionHandler(nil, error);
            }
            else {
                NSError *err = nil;
                id responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
                if (err) {
                    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    completionHandler(str, err);
                }
                else {
                    completionHandler(responseObject, err);
                }
            }
        });
    }
}

+ (NSURLRequest *)uploadRequestForPath:(NSString *)toPath  withPath:(NSDictionary *)params fileType:(OFileType)fileType filename:(NSString *)filename fileData:(NSData *)fileData
{
    NSString *bounary = @"AaB03x";
    NSString *endBounary = [[NSString alloc]initWithFormat:@"\r\n--%@--", bounary];
    
    NSMutableString *bodyStr = [[NSMutableString alloc] init];
    
    for (NSString *key in params.allKeys) {
        [bodyStr appendFormat:@"--%@\r\n", bounary];
        [bodyStr appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key];
        [bodyStr appendFormat:@"%@\r\n", params[key]];
    }
    
    [bodyStr appendFormat:@"--%@\r\n", bounary];
    [bodyStr appendFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n", filename];
    [bodyStr appendFormat:@"Content-Type: %@\r\n\r\n", [[self class] fileType:fileType]];
    
    NSMutableData *bodyData = [NSMutableData data];
    [bodyData appendData:[bodyStr dataUsingEncoding:NSUTF8StringEncoding]];
    [bodyData appendData:fileData];
    [bodyData appendData:[endBounary dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *contentType=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@", bounary];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:toPath]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:600];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%zd", [bodyData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:bodyData];
    [request setHTTPMethod:@"GET"];
    
    return request;
}

+ (void)synchronousRequest:(NSString *)urlPath params:(NSDictionary *)params completionHandler:(void (^)(id data, NSError *error))completionHandler
{
    NSURLRequest *request = [[self class] requestForPath:urlPath withParams:params isGet:NO];
    
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    id responseObject = nil;
    if (data) {
        responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    
    if (completionHandler) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(responseObject, error);
        });
    }
}

+ (NSURLRequest *)requestForPath:(NSString *)urlPath withParams:(NSDictionary *)params isGet:(BOOL)isGet
{
    NSString *bounary = @"AaB03x";
    NSMutableString *bodyStr = [NSMutableString string];
    
    for (NSString *key in params.allKeys) {
        [bodyStr appendFormat:@"--%@\r\n", bounary];
        [bodyStr appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key];
        [bodyStr appendFormat:@"%@\r\n", params[key]];
    }
    [bodyStr appendFormat:@"--%@\r\n", bounary];
    
    NSData *bodyData = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlPath];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSString *contentType=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@", bounary];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%zd", [bodyData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:bodyData];
    [request setHTTPMethod:@"POST"];
    
    return request;
}

+ (NSString *)fileType:(OFileType)type
{
    NSString *fileType = @"image/png";
    switch (type) {
        case OFileTypeMP4:
            fileType = @"video/mpeg4";
            break;
        case OFileTypePNG:
            fileType = @"image/png";
            break;
        case OFileTypeJPG:
            fileType = @"image/jpg";
            break;
        case OFileTypeGIF:
            fileType = @"image/gif";
            break;
        case OFileTypeJPEG:
            fileType = @"image/jpeg";
            break;
        case OFileTypeOther:
            fileType = @"file/other";
            break;
    }
    return fileType;
}

+ (BOOL)saveData:(NSData *)data atPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *pathFolder = [path stringByDeletingLastPathComponent];
    BOOL exist = [fileManager fileExistsAtPath:pathFolder];
    if (!exist) {
        [fileManager createDirectoryAtURL:[NSURL fileURLWithPath:pathFolder] withIntermediateDirectories:YES attributes:nil error:nil];
    }

    NSError *error = nil;
    BOOL result = [data writeToFile:path options:NSDataWritingAtomic error:&error];
    return result;
}



#pragma mark - dowonload delegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    if (self.progress) {
        XT_WeakSelf;
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.progress((float)totalBytesWritten/totalBytesExpectedToWrite);
        });
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSData *data = [NSData dataWithContentsOfURL:location];
    [[self class] saveData:data atPath:self.downloadDestinationPath];
}


#pragma mark - upload delegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    if (self.progress) {
        XT_WeakSelf;
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.progress((float)totalBytesSent/totalBytesExpectedToSend);
        });
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (self.downloadComptionHandler) {
        XT_WeakSelf;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (weakSelf.downloadComptionHandler) {
                weakSelf.downloadComptionHandler(self.downloadDestinationPath, error);
            }
        });
    }
}

@end
