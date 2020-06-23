//
//  AppDelegate.m
//  HardwareStats
//
//  Created by Futaba Dev on 27.05.2020.
//  Copyright © 2020 Futaba Dev. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    [NSTimer scheduledTimerWithTimeInterval:1.0
    target:self
                                   selector:@selector(UpdateStats)
    userInfo:nil
    repeats:YES];
    
    

}

-(void)UpdateStats
{
    NSString* tempString = [self runScript:@"getstats.sh"];
//    NSLog (@"script returned:\n%@", tempString);
    [self.MyLabel setStringValue:tempString];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

//------------------------------------------------------
-(NSString*) runScript:(NSString*)scriptName
{
    NSTask *task;
    task = [[NSTask alloc] init];
    [task setLaunchPath: @"/bin/sh"];

    NSArray *arguments;
    NSString* newpath = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath], scriptName];
//    NSLog(@"shell script path: %@",newpath);
    arguments = [NSArray arrayWithObjects:newpath, nil];
    [task setArguments: arguments];

    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];

    NSFileHandle *file;
    file = [pipe fileHandleForReading];

    [task launch];

    NSData *data;
    data = [file readDataToEndOfFile];

    NSString *string;
    string = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];

    return string;
}
//------------------------------------------------------

@end
