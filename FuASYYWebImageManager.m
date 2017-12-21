//
//  FuASYYWebImageManager.m
//  MiaoMiaoZheApp
//
//  Created by 付海龙 on 2017/12/11.
//  Copyright © 2017年 付海龙. All rights reserved.
//

#import "FuASYYWebImageManager.h"

@implementation YYWebImageManager (ASNetworkImageNode)

- (id)downloadImageWithURL:(NSURL *)URL callbackQueue:(dispatch_queue_t)callbackQueue downloadProgress:(ASImageDownloaderProgress)downloadProgress completion:(ASImageDownloaderCompletion)completion
{
    YYWebImageManager *manager = [YYWebImageManager sharedManager];
    __weak YYWebImageOperation *operation = nil;
    operation = [manager requestImageWithURL:URL
                                     options:YYWebImageOptionSetImageWithFadeAnimation
                                    progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                        dispatch_async(callbackQueue, ^{
                                            CGFloat received = receivedSize;
                                            CGFloat expected = expectedSize;
                                            CGFloat progress = (expectedSize == 0) ? 0 : (received / expected);
                                            downloadProgress(progress);
                                        });
                                    }
                                   transform:nil
                                  completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                                      completion(image, error, operation);
                                  }];
    return operation;
}

- (void)cancelImageDownloadForIdentifier:(id)downloadIdentifier
{
    if ([downloadIdentifier isKindOfClass:[YYWebImageOperation class]]) {
        YYWebImageOperation *operation = (YYWebImageOperation *)downloadIdentifier;
        [operation cancel];
    }
}

- (void)cachedImageWithURL:(NSURL *)URL callbackQueue:(dispatch_queue_t)callbackQueue completion:(ASImageCacherCompletion)completion
{
    UIImage *image = [[YYImageCache sharedCache] getImageForKey:URL.absoluteString];
    if (image) {
        dispatch_async(callbackQueue, ^{
            completion(image);
        });
    }else {
        dispatch_async(callbackQueue, ^{
            [self downloadImageWithURL:URL
                         callbackQueue:callbackQueue
                      downloadProgress:^(CGFloat progress) {
                          
                      }
                            completion:^(id<ASImageContainerProtocol>  _Nullable image, NSError * _Nullable error, id  _Nullable downloadIdentifier) {
                                if (image) {
                                    completion(image);
                                }
                            }];
        });
    }
}

@end
