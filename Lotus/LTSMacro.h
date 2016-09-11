//
//  LTSMacro.h
//  NYUIFramework
//
//  Created by NiYao on 9/11/16.
//  Copyright © 2016 SuneBearNi. All rights reserved.
//

#ifndef LTSMacro_h
#define LTSMacro_h

#ifdef DEBUG
#define LTSInfo(...) NSLog(@"%s \n%@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__]);

#else
#define LTSInfo(...) ;

#endif

#endif /* LTSMacro_h */
