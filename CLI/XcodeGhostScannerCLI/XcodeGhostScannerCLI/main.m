//
//  main.m
//  XcodeGhostScannerCLI
//
//  Created by Zhang Naville on 15/9/21.
//  Copyright (c) 2015年 __MyCompanyName__. All rights reserved.
//
@interface LSApplicationProxy : NSObject
{
    unsigned int _flags;
    unsigned int _bundleFlags;
    NSArray *_privateDocumentIconNames;
    LSApplicationProxy *_privateDocumentTypeOwner;
    NSArray *_directionsModes;
    NSArray *_UIBackgroundModes;
    NSArray *_audioComponents;
    BOOL _profileValidated;
    BOOL _isPlaceholder;
    BOOL _isAppUpdate;
    BOOL _isNewsstandApp;
    BOOL _isRestricted;
    BOOL _foundBackingBundle;
    NSString *_applicationType;
    NSString *_signerIdentity;
    NSDictionary *_entitlements;
    NSDictionary *_environmentVariables;
    NSArray *_machOUUIDs;
    NSString *_vendorID;
    NSString *_vendorName;
    NSString *_bundleVersion;
    NSString *_shortVersionString;
    NSURL *_bundleURL;
    unsigned int _installType;
}
@end
#import <Foundation/Foundation.h>
#include <stdio.h>
#import <dlfcn.h>
#import <objc/runtime.h>
int main (int argc, const char * argv[])
{
    void *IOKit = dlopen("/System/Library/Frameworks/MobileCoreServices.framework/MobileCoreServices",RTLD_NOW);//Make Sure We Have What We Need.Gotta Check That
    Class LSApplicationWorkspace = objc_getClass("LSApplicationWorkspace");
    id WorkSpace=[LSApplicationWorkspace performSelector:@selector(defaultWorkspace)];
    NSArray* ListOfApps=[WorkSpace performSelector:@selector(allApplications)];
    NSLog(@"%@",ListOfApps);
    for(int i=0;i<=ListOfApps.count;i++){
        LSApplicationProxy* object=[ListOfApps objectAtIndex:i];
         Ivar ivar = class_getInstanceVariable( objc_getClass("LSApplicationWorkspace"), "_bundleURL");
        NSURL* url=object_getIvar(object,ivar);
        NSString* URLSTR=[url absoluteString];
        NSDictionary* InfoDict=[NSDictionary dictionaryWithContentsOfFile:[URLSTR stringByAppendingString:@"/Info.plist"]];
        NSString* BashCommand=[NSString stringWithFormat:@"DYLD_INSERT_LIBRARIES=/usr/lib/XcodeGhostScanner.dylib %@/%@",URLSTR,[InfoDict objectForKey:@"CFBundleExecutable"]];
        system([BashCommand UTF8String]);
        
        
    }
    
    dlclose(IOKit);
    
    
}

