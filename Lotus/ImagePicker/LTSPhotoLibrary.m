//
//  LTSPhotoLibrary.m
//  NYUIFramework
//
//  Created by NiYao on 9/11/16.
//  Copyright © 2016 SuneBearNi. All rights reserved.
//

#import "LTSPhotoLibrary.h"
#import "LTSMacro.h"
#import <Photos/Photos.h>

static CGSize kLTSThumbImageSize;

@interface LTSPhotoLibrary ()

@property (nonatomic, copy  ) NSArray               *fetchedPhotos;

@end

@implementation LTSPhotoLibrary
#pragma mark - Pravite Method
- (instancetype)init {
    if (self = [super init]) {
        kLTSThumbImageSize = CGSizeMake(150, 150);
    }
    return self;
}

#pragma mark - Public Method
+ (instancetype)commonLibrary {
    static LTSPhotoLibrary *library = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        library = [[self alloc] init];
    });
    return library;
}

+ (dispatch_queue_t)photoQueue {
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create(kLTSPhotoQueueLabel, DISPATCH_QUEUE_CONCURRENT);
    });
    return queue;
}

+ (PHCachingImageManager *)imageManager {
    static PHCachingImageManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[PHCachingImageManager alloc] init];
    });
    return manager;
}

- (void)fetchAllPhotosCompletion:(LTSPhotoLibraryFetchAllPhotosCompletion)completion {
    __weak typeof(self) weakSelf = self;
    dispatch_async([LTSPhotoLibrary photoQueue], ^{
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        switch (status) {
            case PHAuthorizationStatusAuthorized:
            case PHAuthorizationStatusRestricted:
                [weakSelf fetchPhotosWhenAuthorized];
                break;
            case PHAuthorizationStatusDenied:
            case PHAuthorizationStatusNotDetermined:
                
                break;
            default:
                break;
        }
    });
}

- (void)fetchPhotosWhenAuthorized {
    PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init];
    allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *allPhotoResults = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
    LTSInfo(@"%@", allPhotoResults);
    NSMutableArray *images = [NSMutableArray array];
    [allPhotoResults enumerateObjectsUsingBlock:^(PHAsset *  _Nonnull asset, NSUInteger idx, BOOL * _Nonnull stop) {
        void (^requestManagerHandler)(UIImage * _Nullable result, NSDictionary * _Nullable info) = ^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            [images addObject:result];
        };
        [[LTSPhotoLibrary imageManager] requestImageForAsset:asset targetSize:kLTSThumbImageSize contentMode:PHImageContentModeAspectFill options:nil resultHandler:requestManagerHandler];
     }];
    LTSInfo(@"%@", images);
}

@end
