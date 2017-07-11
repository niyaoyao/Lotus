//
//  LTSMacro.h
//  NYUIFramework
//
//  Created by NiYao on 9/11/16.
//  Copyright © 2016 SuneBearNi. All rights reserved.
//

#ifdef DEBUG
#define LTSLog(...) NSLog(@"%s \n%@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__]);

#else
#define LTSLog(...) ;

#endif

