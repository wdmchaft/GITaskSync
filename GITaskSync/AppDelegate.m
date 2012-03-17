//
//  AppDelegate.m
//  GITaskSync
//
//  Created by Tommy Sparber on 14.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "GTLUtilities.h"
#import "GTMHTTPFetcherLogging.h"

@implementation AppDelegate

@synthesize window = window_;
@synthesize taskListsFetchError = taskListsFetchError_;

//@synthesize  editTaskListTicket;

// Constants that ought to be defined by the API
NSString *const kTaskStatusCompleted = @"completed";
NSString *const kTaskStatusNeedsAction = @"needsAction";

//external, so that it is possiblie to not commit
//-> rename OAuthClientId.template.h to OAuthClientId.h and inset your id
#include "../OAuthClientId.h"

// Keychain item name for saving the user's authentication information
NSString *const kKeychainItemName = @"GITaskSync: Google Auth";

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  
  // Load the OAuth token from the keychain, if it was previously saved
  GTMOAuth2Authentication *auth;
  auth = [GTMOAuth2WindowController
          authForGoogleFromKeychainForName:kKeychainItemName clientID:clientID
          clientSecret:clientSecret];
  self.tasksService.authorizer = auth;
  
  [self updateUI];
}

// get a service object with the current username/password
//
// A "service" object handles networking tasks.  Service objects
// contain user authentication information as well as networking
// state information (such as cookies and the "last modified" date for
// fetched data.)

- (GTLServiceTasks *)tasksService
{
  static GTLServiceTasks *service = nil;
  
  if (!service)
  {
    service = [[GTLServiceTasks alloc] init];
    
    // Have the service object set tickets to fetch consecutive pages
    // of the feed so we do not need to manually fetch them
    service.shouldFetchNextPages = YES;
    
    // Have the service object set tickets to retry temporary error conditions
    // automatically
    service.retryEnabled = YES;
  }
  return service;
}

#pragma mark -

- (NSString *)signedInUsername
{
  // Get the email address of the signed-in user
  GTMOAuth2Authentication *auth = self.tasksService.authorizer;
  BOOL isSignedIn = auth.canAuthorize;
  if (isSignedIn)
  {
    return auth.userEmail;
  }
  else
  {
    return nil;
  }
}

- (BOOL)isSignedIn
{
  NSString *name = [self signedInUsername];
  return (name != nil);
}

#pragma mark Sign 

- (void)runSigninThenInvokeSelector:(SEL)signInDoneSel
{  
  // Show the OAuth 2 sign-in controller
  NSBundle *frameworkBundle = [NSBundle bundleForClass:[GTMOAuth2WindowController class]];
  GTMOAuth2WindowController *windowController;
  windowController = [GTMOAuth2WindowController controllerWithScope:kGTLAuthScopeTasks
                                                           clientID:clientID
                                                       clientSecret:clientSecret
                                                   keychainItemName:kKeychainItemName
                                                     resourceBundle:frameworkBundle];
  
  [windowController signInSheetModalForWindow:[self window]
                            completionHandler:^(GTMOAuth2Authentication *auth,
                                                NSError *error) {
                              // callback
                              if (error == nil) {
                                self.tasksService.authorizer = auth;
                                if (signInDoneSel) {
                                  [self performSelector:signInDoneSel];
                                }
                              } else {
                                self.taskListsFetchError = error;
                                [self updateUI];
                              }
                            }];
}

#pragma mark IBActions

- (IBAction)signInClicked:(id)sender
{
  
  if (![self isSignedIn]) {
    // Sign in
    [self runSigninThenInvokeSelector:@selector(updateUI)];
  } else {
    // Sign out
    GTLServiceTasks *service = self.tasksService;
    
    [GTMOAuth2WindowController removeAuthFromKeychainForName:kKeychainItemName];
    service.authorizer = nil;
    [self updateUI];
  }
}

#pragma mark UI

- (void)updateUI {
  BOOL isSignedIn = [self isSignedIn];
  NSString *username = [self signedInUsername];
  [signedInButton_ setTitle:(isSignedIn ? @"Sign Out" : @"Sign In")];
  [signedInField_ setStringValue:(isSignedIn ? username : @"No")];
  
  //
  // Task lists table
  //
  
//  if (self.taskListsTicket != nil || self.editTaskListTicket != nil) {
//    [taskListsProgressIndicator_ startAnimation:self];
//  } else {
//    [taskListsProgressIndicator_ stopAnimation:self];
//  }
  
  // Get the description of the selected item, or the feed fetch error
//  NSString *resultStr = @"";
  
//  if (self.taskListsFetchError) {
//    // Display the error
//    resultStr = [self.taskListsFetchError description];
//    
//    // Also display any server data present
//    NSData *errData = [[self.taskListsFetchError userInfo] objectForKey:kGTMHTTPFetcherStatusDataKey];
//    if (errData) {
//      NSString *dataStr = [[[NSString alloc] initWithData:errData
//                                                 encoding:NSUTF8StringEncoding] autorelease];
//      resultStr = [resultStr stringByAppendingFormat:@"\n%@", dataStr];
//    }
//  } else {
//    // Display the selected item
//    GTLTasksTaskList *item = [self selectedTaskList];
//    if (item) {
//      resultStr = [item description];
//    }
//  }
//  [taskListsResultTextView_ setString:resultStr];
  
  //
  // Tasks outline
  //
//  [tasksOutline_ reloadData];
  
//  if (self.tasksTicket != nil) {
//    [tasksProgressIndicator_ startAnimation:self];
//  } else {
//    [tasksProgressIndicator_ stopAnimation:self];
//  }
  
//  // Get the description of the selected item, or the feed fetch error
//  resultStr = @"";
//  if (self.tasksFetchError) {
//    resultStr = [self.tasksFetchError description];
//  } else {
//    GTLTasksTask *item = [self selectedTask];
//    if (item) {
//      resultStr = [item description];
//    }
//  }
//  [tasksResultTextView_ setString:resultStr];
  
//  // Enable task lists buttons
//  BOOL hasTaskLists = (self.taskLists != nil);
//  BOOL isTaskListSelected = ([self selectedTaskList] != nil);
//  BOOL hasTaskListTitle = ([[taskListNameField_ stringValue] length] > 0);
//  
//  [addTaskListButton_ setEnabled:(hasTaskListTitle && hasTaskLists)];
//  [renameTaskListButton_ setEnabled:(hasTaskListTitle && isTaskListSelected)];
//  [deleteTaskListButton_ setEnabled:(isTaskListSelected)];
//  
//  BOOL isFetchingTaskLists = (self.taskListsTicket != nil);
//  BOOL isEditingTaskList = (self.editTaskListTicket != nil);
//  [taskListsCancelButton_ setEnabled:(isFetchingTaskLists || isEditingTaskList)];
//  
//  // Enable tasks buttons
//  GTLTasksTask *selectedTask = [self selectedTask];
//  BOOL hasTasks = (self.tasks != nil);
//  BOOL isTaskSelected = (selectedTask != nil);
//  BOOL hasTaskTitle = ([[taskNameField_ stringValue] length] > 0);
//  
//  [addTaskButton_ setEnabled:(hasTaskTitle && hasTasks)];
//  [renameTaskButton_ setEnabled:(hasTaskTitle && isTaskSelected)];
//  [deleteTaskButton_ setEnabled:(isTaskSelected)];
//  
//  BOOL isCompleted = [selectedTask.status isEqual:kTaskStatusCompleted];
//  [completeTaskButton_ setEnabled:isTaskSelected];
//  [completeTaskButton_ setTitle:(isCompleted ? @"Uncomplete" : @"Complete")];
//  
//  NSArray *completedTasks = [self completedTasks];
//  NSUInteger numberOfCompletedTasks = [completedTasks count];
//  [clearTasksButton_ setEnabled:(numberOfCompletedTasks > 0)];
//  
//  NSUInteger numberOfTasks = [self.tasks.items count];
//  [deleteAllTasksButton_ setEnabled:(numberOfTasks > 0)];
//  
//  BOOL areAllTasksCompleted = (numberOfCompletedTasks == numberOfTasks);
//  [completeAllTasksButton_ setEnabled:(numberOfTasks > 0)];
//  [completeAllTasksButton_ setTitle:(areAllTasksCompleted ?
//                                     @"Uncomplete All" : @"Complete All")];
//  
//  BOOL isFetchingTasks = (self.tasksTicket != nil);
//  BOOL isEditingTask = (self.editTaskTicket != nil);
//  [tasksCancelButton_ setEnabled:(isFetchingTasks || isEditingTask)];
  
}

@end
