//
//  ViewController.m
//  JavascriptCore
//
//  Created by Gavin on 16/2/16.
//  Copyright © 2016年 Gavin. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    JSContext *context = [[JSContext alloc] init];
    JSValue *jsVal = [context evaluateScript:@"21+7"];
    int iVal = [jsVal toInt32];
    NSLog(@"JSValue: %@, int: %d", jsVal, iVal);


    [context evaluateScript:@"var arr = [21, 7 , 'iderzheng.com'];"];
    JSValue *jsArr = context[@"arr"]; // Get array from JSContext
    jsArr[1] = @"blog"; // Use JSValue as array
    jsArr[7] = @7;
    
    
    [context evaluateScript:@"var arr = [21, 7, 'baidu.com'];"];
    JSValue *jsArr1 = [context objectForKeyedSubscript:@"arr"];
    NSLog(@"JS Array: %@; Length: %@", jsArr1, jsArr[@"length"]);
    jsArr[1] = @"blog";
    jsArr[7] = @7;
    NSLog(@"JS Array: %@; Length: %d", jsArr, [jsArr[@"length"] toInt32]);       NSArray *nsArr = [jsArr toArray];
    NSLog(@"NSArray: %@", nsArr);

    
    context[@"log"] = ^() {
        NSArray *args = [JSContext currentArguments];
        for (JSValue *jsVal in args) {
            NSLog(@"%@", jsVal);
        }
        
        JSValue *this = [JSContext currentThis];
    };
    
    [context evaluateScript:@"log('ider', [7, 21], { hello:'world', js:100 });"];

    context[@"log"] = ^(){
        NSLog(@"+++++++Begin Log+++++++");
        NSArray *args = [JSContext currentArguments];
        for (JSValue *jsVal in args) {
            NSLog(@"%@",jsVal);
        }
        JSValue *this = [JSContext currentThis];
        NSLog(@"this: %@",this);
        
        NSLog(@"-------End Log-------");
    };
    [context evaluateScript:@"log('ider',[7,21],{hello:'world',js:100});"];
    
    [context evaluateScript:@"function add(a, b) { return a + b; }"];
    JSValue *add = context[@"add"];
    NSLog(@"Func: %@", add);
    JSValue *sum = [add callWithArguments:@[@(7), @(21)]];
    NSLog(@"Sum: %d",[sum toInt32]);
    
    context.exceptionHandler = ^(JSContext *con, JSValue *exception) {
        NSLog(@"%@", exception);
        con.exception = exception;
    };
    [context evaluateScript:@"ider.zheng = 21"];

    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
