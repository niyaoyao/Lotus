//
//  LTSPhotoLibrary.h
//  NYUIFramework
//
//  Created by NiYao on 9/11/16.
//  Copyright © 2016 SuneBearNi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PHCachingImageManager;
NS_ASSUME_NONNULL_BEGIN

static const char * kLTSPhotoQueueLabel = "com.sunebear.nycode.photo.queue";

typedef NS_ENUM(NSInteger, LTSPhotoLibraryType) {
    LTSPhotoLibraryAuthorizationStatusNotDetermined,
    LTSPhotoLibraryAuthorizationStatusAuthorized,
};

typedef void (^LTSPhotoLibraryFetchAllPhotosCompletion)(LTSPhotoLibraryType type, NSArray * _Nullable images, NSError * _Nullable error);

@interface LTSPhotoLibrary : NSObject

+ (instancetype)commonLibrary;
+ (PHCachingImageManager *)imageManager;
- (void)fetchAllPhotosCompletion:(LTSPhotoLibraryFetchAllPhotosCompletion)completion;

@end
NS_ASSUME_NONNULL_END
