//
//  AppDelegate.h
//  GITaskSync
//
//  Created by Tommy Sparber on 14.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "GTLTasks.h"
#import "GTMOAuth2WindowController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
  @private
//    GTLTasksTaskLists *tasksLists_;
//    GTLServiceTicket *taskListsTicket_;
    NSError *taskListsFetchError_;

 //   GTLServiceTicket *editTaskListTicket_;

 //   GTLTasksTasks *tasks_;
 //   GTLServiceTicket *tasksTicket_;
 //   NSError *tasksFetchError_;

  //  GTLServiceTicket *editTaskTicket_;
  
  IBOutlet NSTextField *signedInField_;
  IBOutlet NSButton *signedInButton_;
}

@property (assign) IBOutlet NSWindow *window;

//@property (readonly) GTLServiceTasks *tasksService;
//@property (retain) GTLTasksTaskLists *taskLists;
//@property (retain) GTLServiceTicket *taskListsTicket;
@property (retain) NSError *taskListsFetchError;
//
//@property (retain) GTLServiceTicket *editTaskListTicket;
//
//@property (retain) GTLTasksTasks *tasks;
//@property (retain) GTLServiceTicket *tasksTicket;
//@property (retain) NSError *tasksFetchError;
//
//@property (retain) GTLServiceTicket *editTaskTicket;


- (IBAction)signInClicked:(id)sender;
- (void)runSigninThenInvokeSelector:(SEL)signInDoneSel;
- (void)updateUI;

@end
