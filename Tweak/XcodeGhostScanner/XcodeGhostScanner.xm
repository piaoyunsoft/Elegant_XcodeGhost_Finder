#import <Foundation/Foundation.h>

#include <mach-o/getsect.h>
#include <mach-o/ldsyms.h>
%ctor{

    @autoreleasepool {
        NSError *e;
        unsigned long size;
        void *ptr = getsectiondata(&_mh_execute_header, "__TEXT",
                                   "__cstring", &size);
        NSData *Data = [NSData dataWithBytesNoCopy:ptr length:size
                                           freeWhenDone:NO];
        NSString* DataStr = [[[NSString alloc] initWithData:Data
                                               encoding:NSUTF8StringEncoding] autorelease];
        NSRange Range=[DataStr rangeOfString:@"icloud-analysis.com"];//Noobs.No Obfuscation
        
        if(Range.location!=NSNotFound){
            NSLog(@"%@ is Infected!!!",[[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleDisplayName"]);
            
            
        }
    
    
    
    
    }

exit(0);//Quit After Check

}
