//
//  XCUITests.m
//  XCUITests
//
//  Created by yuanxuehu on 2018/5/30.
//  Copyright © 2018年 TigeHu. All rights reserved.
//



#import <XCTest/XCTest.h>
#include <sys/sysctl.h>
#include <sys/types.h>
#include <mach/mach.h>
#include <mach/processor_info.h>
#include <mach/mach_host.h>

#import <mach/task_info.h>

@interface XCUITests : XCTestCase
{
    processor_info_array_t cpuInfo, prevCpuInfo;
    mach_msg_type_number_t numCpuInfo, numPrevCpuInfo;
    unsigned numCPUs;
    NSTimer *updateTimer;
    NSLock *CPUUsageLock;
}

//@property (nonatomic, strong) XCUIApplication *app;
//@property (nonatomic, strong) XCUIElementQuery *tablesQuery;
//@property (nonatomic, strong) XCUIElementQuery *navigationBarsQuery;

@property (nonatomic, strong) NSArray *deviceNameArray;// 通用设备（可用）
@property (nonatomic, strong) NSArray *six_MutiChannelDeviceArray;// 多路设备 6个样式选择
@property (nonatomic, strong) NSArray *three_MutiChannelDeviceArray;// 多路设备 3个样式选择
@property (nonatomic, strong) NSArray *two_MutiChannelDeviceArray; // 多路设备 2个样式选择



@end

@implementation XCUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    
    NSLog(@"---------->setUp");
    
    
    // init
    //    self.app = [[XCUIApplication alloc] init];
    //    self.tablesQuery = self.app.tables;
    //    self.navigationBarsQuery = self.app.navigationBars;
    
    // array
    self.deviceNameArray = [NSArray arrayWithObjects:
                            @"我的设备15",
                            @"我的设备12",
                            @"我的设备8087",
                            @"我的设备8089",
                            @"我的设备26",
                            @"我的设备16",
                            @"对应ddns8087",
                            @"我的设备13",
                            @"密码错误",
                            @"我的设备9",
                            @"我的设备6",
                            @"我的设备2",
                            @"我的设备1",
                            nil];
    self.six_MutiChannelDeviceArray = [NSArray arrayWithObjects:
                                       @"我的设备15",
                                       @"我的设备12",
                                       @"我的设备8087",
                                       @"我的设备8089",
                                       @"对应ddns8087",
                                       nil];
    self.three_MutiChannelDeviceArray = [NSArray arrayWithObjects:
                                         @"我的设备31",
                                         @"我的设备16",
                                         nil];
    self.two_MutiChannelDeviceArray = [NSArray arrayWithObjects:
                                       @"我的设备13",
                                       @"我的设备2",
                                       @"我的设备1",
                                       nil];
    
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    NSLog(@"---------->tearDown");
    
}

// 测试用例仅仅只是一个以test为开头的方法
- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    NSLog(@"---------->testExample");
    
}

// 想要禁止一个测试用例，我们只需要在方法名字前加 DISABLED
- (void)DISABLED_testThatItDoesURLEncoding
{
    // test code
    
}


#pragma mark - 测试用例

// 设备进入预览出图—点击进入摄像机设置—退出摄像机设置—进入回放—回放录像拖动时间轴—点击返回预览界面--预览界面退出至设备列表--下拉刷新设备列表
- (void)testAction
{
    sleep(6);
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *navigationBarsQuery = app.navigationBars;
    XCUIElementQuery *tablesQuery = app.tables;
    
    
    for (int i=0; i<10; i++) {
        // 点击 cell
        XCUIElement *cellElement = tablesQuery.staticTexts[@"我的设备26"];
//        XCTAssert(cellElement.exists, @"Cound not found -------->cellElement");
        if (cellElement.exists) {
            [cellElement tap];
        }
        
        sleep(10);
        
        // 进入 “设置”
        XCUIElement *settingsElement = [navigationBarsQuery matchingIdentifier:@"我的设备26"].buttons[@"icon preview more"];
        if (settingsElement.exists) {
           [settingsElement tap];
        }
        
        // 返回 预览
        XCUIElement *backFromSettingsElement = [navigationBarsQuery matchingIdentifier:@"设备设置"].buttons[@"icon add arrow left"];
        if (backFromSettingsElement.exists) {
            [backFromSettingsElement tap];
        }
        
        sleep(5);
        
        // 进入 回放
        XCUIElement *staticTextElement = [[[[[[[[[[[[[[[[[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:3] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:2] childrenMatchingType:XCUIElementTypeStaticText] elementBoundByIndex:0];
        
        if (staticTextElement.exists) {
            if (!staticTextElement.isHittable) {
                [[staticTextElement coordinateWithNormalizedOffset:CGVectorMake(0.5, 0.5)] tap];

            } else {
                [staticTextElement tap];
            }
        }
//        XCTAssert(!staticTextElement.isHittable, @"Cound not found -------->staticTextElement");
        
        
        XCUIElement *swipeElement = [[[[[[[[[[[[[[[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0]  childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:3] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0];
        if (swipeElement.exists) {
            [swipeElement swipeRight];
            [swipeElement swipeLeft];
            [swipeElement swipeRight];
            
        }
        
        // 返回至 设备列表
        XCUIElement *backFromReviewElement = [navigationBarsQuery matchingIdentifier:@"我的设备26"].buttons[@"icon add arrow left"];
//        XCTAssert(backFromReviewElement.exists, @"Cound not found -------->backFromReviewElement");
        if (backFromSettingsElement.exists) {
            [backFromReviewElement tap];
        }
        
        // 下拉刷新设备列表
        [app swipeDown];
        
        sleep(3);
    }
}


#pragma mark - 暴力测试用例----------》预览

// 单设备，反复进入退出预览，未出图时，点击返回至设备列表
- (void)testSingleDeviceReloadVideoNotWait
{
    sleep(6);
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *navigationBarsQuery = app.navigationBars;
    XCUIElementQuery *tablesQuery = app.tables;
    
    NSUInteger indexCell = 5;
    
    for (int i=0; i<10; i++) {
        // 点击 cell
        XCUIElement *cellElement = tablesQuery.staticTexts[self.deviceNameArray[indexCell]];
        XCTAssert(cellElement.exists, @"Cound not found -------->cellElement");
        [cellElement tap];
        
        // 返回
        XCUIElement *backElement = [navigationBarsQuery matchingIdentifier:self.deviceNameArray[indexCell]].buttons[@"icon add arrow left"];
        XCTAssert(backElement.exists, @"Cound not found -------->backElement");
        [backElement tap];
    }
}

// 单设备，反复进入退出预览，出图后，点击返回至设备列表
- (void)testSingleDeviceReloadVideo
{
    sleep(6);
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *navigationBarsQuery = app.navigationBars;
    XCUIElementQuery *tablesQuery = app.tables;
    
    NSUInteger indexCell = 8;
    
    for (int i=0; i<10; i++) {
        // 点击 cell
        XCUIElement *cellElement = tablesQuery.staticTexts[self.deviceNameArray[indexCell]];
        XCTAssert(cellElement.exists, @"Cound not found -------->cellElement");
        [cellElement tap];
        
        sleep(15);
        
        // 返回
        XCUIElement *backElement = [navigationBarsQuery matchingIdentifier:self.deviceNameArray[indexCell]].buttons[@"icon add arrow left"];
        XCTAssert(backElement.exists, @"Cound not found -------->backElement");
        [backElement tap];
    }
}

// 多路设备，进入预览界面，视频未出图情况下，任意切换分屏模式（1-16），左右滑屏 仅多路设备
- (void)testMutiChannelDeviceReloadVideoNotWait_RandomTap_LeftOrRightSwipe
{
    sleep(6);
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *navigationBarsQuery = app.navigationBars;
    XCUIElementQuery *tablesQuery = app.tables;
    
    for (int i=0; i<10; i++) {
        NSUInteger cellCount = self.six_MutiChannelDeviceArray.count;
        NSUInteger indexCell = (int)(0 + (arc4random() % (cellCount)));
        NSUInteger randomTap = (int)(0 + (arc4random() % 6));
        
        // 点击 cell
        XCUIElement *cellElement = tablesQuery.staticTexts[self.six_MutiChannelDeviceArray[indexCell]];
        XCTAssert(cellElement.exists, @"Cound not found -------->cellElement");
        [cellElement tap];
        
        
        // 分屏样式
        XCUIElementQuery *SplitScreenQuery = [app descendantsMatchingType:XCUIElementTypeButton];
        XCUIElement *splitScreenElement = SplitScreenQuery.allElementsBoundByIndex[2];
        XCTAssert(splitScreenElement.exists, @"Cound not found -------->splitScreenElement");
        [splitScreenElement tap];
        
        // 分屏按键  1 4 6 8 9 16
        XCUIElementQuery *inSplitScreenQuery = [app descendantsMatchingType:XCUIElementTypeButton];
        XCUIElement *inSplitScreenElement = inSplitScreenQuery.allElementsBoundByIndex[randomTap];
        XCTAssert(inSplitScreenElement.exists, @"Cound not found -------->inSplitScreenElement");
        [inSplitScreenElement tap];
        
        // scrollView
        XCUIElementQuery *scrollViewQuery = [app descendantsMatchingType:XCUIElementTypeScrollView];
        XCUIElement *scrollViewElement = scrollViewQuery.allElementsBoundByIndex[0];
        XCTAssert(scrollViewElement.exists, @"Cound not found -------->scrollViewElement");
        [scrollViewElement swipeLeft];
        [scrollViewElement swipeRight];
        
        // 返回
        XCUIElement *backElement = [navigationBarsQuery matchingIdentifier:self.six_MutiChannelDeviceArray[indexCell]].buttons[@"icon add arrow left"];
        XCTAssert(backElement.exists, @"Cound not found -------->backElement");
        [backElement tap];
    }
}

// 多路设备，进入预览界面，出图后，任意切换分屏模式（1-16），左右滑屏 仅多路设备
- (void)testMutiChannelDeviceReloadVideo_RandomTap_LeftOrRightSwipe
{
    sleep(6);
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *navigationBarsQuery = app.navigationBars;
    XCUIElementQuery *tablesQuery = app.tables;
    
    for (int i=0; i<10; i++) {
        NSUInteger cellCount = self.six_MutiChannelDeviceArray.count;
        NSUInteger indexCell = (int)(0 + (arc4random() % (cellCount)));
        NSUInteger randomTap = (int)(0 + (arc4random() % 6));
        
        // 点击 cell
        XCUIElement *cellElement = tablesQuery.staticTexts[self.six_MutiChannelDeviceArray[indexCell]];
        XCTAssert(cellElement.exists, @"Cound not found -------->cellElement");
        [cellElement tap];
        
        sleep(10);
        
        // 分屏样式
        XCUIElementQuery *SplitScreenQuery = [app descendantsMatchingType:XCUIElementTypeButton];
        XCUIElement *splitScreenElement = SplitScreenQuery.allElementsBoundByIndex[2];
        XCTAssert(splitScreenElement.exists, @"Cound not found -------->splitScreenElement");
        [splitScreenElement tap];
        
        // 分屏按键  1 4 6 8 9 16
        XCUIElementQuery *inSplitScreenQuery = [app descendantsMatchingType:XCUIElementTypeButton];
        XCUIElement *inSplitScreenElement = inSplitScreenQuery.allElementsBoundByIndex[randomTap];
        XCTAssert(inSplitScreenElement.exists, @"Cound not found -------->inSplitScreenElement");
        [inSplitScreenElement tap];
        
        // scrollView
        XCUIElementQuery *scrollViewQuery = [app descendantsMatchingType:XCUIElementTypeScrollView];
        XCUIElement *scrollViewElement = scrollViewQuery.allElementsBoundByIndex[0];
        XCTAssert(scrollViewElement.exists, @"Cound not found -------->scrollViewElement");
        [scrollViewElement swipeLeft];
        [scrollViewElement swipeRight];
        
        // 返回
        XCUIElement *backElement = [navigationBarsQuery matchingIdentifier:self.six_MutiChannelDeviceArray[indexCell]].buttons[@"icon add arrow left"];
        XCTAssert(backElement.exists, @"Cound not found -------->backElement");
        [backElement tap];
    }
}


#pragma mark - 暴力测试用例----------》回放

// 进入预览，出图后，点击回放按钮，搜索出当天录像，退出至预览100次
- (void)testReplayDemo
{
    sleep(6);
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
        XCUIElementQuery *navigationBarsQuery = app.navigationBars;
    XCUIElementQuery *tablesQuery = app.tables;
    
    //    int sum = 0;
    //    int countTime = 0;
    
    
    for (int i=0; i<100; i++) {
        // 点击 cell
        XCUIElement *cellElement = tablesQuery.staticTexts[@"我的设备8087"];
        if (cellElement.exists) {
            [cellElement tap];
        }

        sleep(20);
    
        // 点击 远程回放
        XCUIElement *staticTextElement = [[[[[[[[[[[[[[[[[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:3] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:2] childrenMatchingType:XCUIElementTypeStaticText] elementBoundByIndex:0];
        if (staticTextElement.exists) {
            if (!staticTextElement.isHittable) {
                [[staticTextElement coordinateWithNormalizedOffset:CGVectorMake(0.5, 0.5)] tap];
            } else {
                [staticTextElement tap];
            }
        }
        
        sleep(5);
        
        // 点击 搜索
        XCUIElementQuery *buttonElement = [[app descendantsMatchingType:XCUIElementTypeButton] matchingType:XCUIElementTypeButton identifier:@"icon preview year"];
        XCUIElement *selectYearElement = buttonElement.element;
        if (selectYearElement.exists) {
            
            //            countTime++;
            //            sum = countTime;
            //            NSLog(@"成功出图次数sum=%@", [NSString stringWithFormat:@"%d", sum]);
            
            if (!selectYearElement.isHittable) {
                [[selectYearElement coordinateWithNormalizedOffset:CGVectorMake(0.5, 0.5)] tap];
            } else {
                [selectYearElement tap];
            }
        }
        
        
        sleep(5);
        
        // 确定
        XCUIElement *DoneButtonElement = [[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:1];
        if (DoneButtonElement.exists) {
            [DoneButtonElement tap];
        }
        
        sleep(1);
        
        // 返回
        XCUIElement *backElement = [navigationBarsQuery matchingIdentifier:@"我的设备8087"].buttons[@"icon add arrow left"];
        if (backElement.exists) {
            [backElement tap];
        }
        
    }
}

// 进入回放，检索出当天录像，视频出图，频繁操作拖动时间轴50次，同时点击播放视频出图
- (void)testReplayDemo1
{
    sleep(6);
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tablesQuery = app.tables;
    
    
    // 点击 cell
    XCUIElement *cellElement = tablesQuery.staticTexts[@"我的设备8087"];
    XCTAssert(cellElement.exists, @"Cound not found -------->cellElement");
    [cellElement tap];
    
    sleep(20);
    
    
    XCUIElement *staticTextElement = [[[[[[[[[[[[[[[[[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:3] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:2] childrenMatchingType:XCUIElementTypeStaticText] elementBoundByIndex:0];
    XCTAssert(!staticTextElement.isHittable, @"Cound not found -------->staticTextElement");
    [[staticTextElement coordinateWithNormalizedOffset:CGVectorMake(0.5, 0.5)] tap];
    
    
    sleep(8);
    
    // 频繁操作拖动时间轴50次，同时点击播放视频出图
    for (int i=0; i<50; i++) {
        XCUIElement *swipeElement = [[[[[[[[[[[[[[[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0]  childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:3] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0];
        XCTAssert(swipeElement.exists, @"Cound not found -------->swipeElement");
        [swipeElement swipeRight];
        //        [swipeElement swipeLeft];
        [swipeElement swipeRight];
        
        // play
        XCUIElement *playElement = [[[[[[[[[[[[[[[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0]  childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:2] childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:0];
        if (playElement.exists) {
            [playElement tap];
        }
        
        sleep(8);
    }
}

// 反复操作切换其他通道进行检索50次，视频出图，同时拖动时间轴播放3次，
- (void)testReplayDemo2
{
    sleep(6);
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tablesQuery = app.tables;
    
    
    // 点击 cell
    [tablesQuery.staticTexts[@"我的设备8087"] tap];
    
    sleep(18);
    
    // 点击 远程回放
    XCUIElement *staticTextElement = [[[[[[[[[[[[[[[[[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:3] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:2] childrenMatchingType:XCUIElementTypeStaticText] elementBoundByIndex:0];
    if (!staticTextElement.isHittable) {
        [[staticTextElement coordinateWithNormalizedOffset:CGVectorMake(0.5, 0.5)] tap];
    }
    
    sleep(10);
    
    for (int i=0; i<50; i++) {
        XCUIElement *channelElement = [[[[[[[[[[[[[[[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0];
        if (channelElement.exists) {
            if (channelElement.isHittable) {
                [[channelElement coordinateWithNormalizedOffset:CGVectorMake(0.5, 0.5)] tap];
            }
        } else {
            XCTAssert(NO, @"Could not found ----->channelElement");
        }
        
        
        
        NSUInteger randomIndex = arc4random() % 15;
        XCUIElement *channelSelectedElement = [[[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeScrollView] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:randomIndex];
        
        if (channelSelectedElement.exists) {
            [channelSelectedElement tap];
        }
        //                if (!channelSelectedElement.isHittable) {
        //                    [[channelSelectedElement coordinateWithNormalizedOffset:CGVectorMake(0.5, 0.5)] tap];
        //                } else {
        //                    [channelSelectedElement tap];
        //                }
        
        sleep(1);
        
        XCUIElement *DoneElement = [[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:0];
        if (DoneElement.exists) {
            [DoneElement tap];
        }
        
        sleep(5);
        
    }
    
    for (int i=0; i<3; i++) {
        XCUIElement *swipeElement = [[[[[[[[[[[[[[[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0]  childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:3] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0];
        if (swipeElement.exists) {
            
            [swipeElement swipeRight];
            sleep(1);
            [swipeElement swipeLeft];
            sleep(1);
            [swipeElement swipeRight];
        }
        
        sleep(3);
        
        XCUIElement *playElement = [[[[[[[[[[[[[[[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0]  childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:2] childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:0];
        if (playElement.exists) {
            if (playElement.isHittable) {
                [[playElement coordinateWithNormalizedOffset:CGVectorMake(0.5, 0.5)] tap];
            }
        }
        
        sleep(8);
        
    }
}

// 反复切换日期50次，视频出图，同时拖动时间轴播放3次
- (void)testReplayDemo3
{
    sleep(6);
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tablesQuery = app.tables;
    
    // 点击 cell
    [tablesQuery.staticTexts[@"我的设备8087"] tap];
    
    sleep(14);
    
    XCUIElement *staticTextElement = [[[[[[[[[[[[[[[[[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:3] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:2] childrenMatchingType:XCUIElementTypeStaticText] elementBoundByIndex:0];
    if (!staticTextElement.isHittable) {
        [[staticTextElement coordinateWithNormalizedOffset:CGVectorMake(0.5, 0.5)] tap];
    }
    
    sleep(8);
    
    for (int i=0; i<50; i++) {
        XCUIElementQuery *buttonElement = [[app descendantsMatchingType:XCUIElementTypeButton] matchingType:XCUIElementTypeButton identifier:@"icon preview year"];
        XCUIElement *selectYearElement = buttonElement.element;
        if (!selectYearElement.isHittable) {
            [[selectYearElement coordinateWithNormalizedOffset:CGVectorMake(0.5, 0.5)] tap];
        } else {
            [selectYearElement tap];
        }
        
        sleep(3);
        
        //        XCUIElement *yearElement = [[[[[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeDatePicker] elementBoundByIndex:0]childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypePickerWheel ]elementBoundByIndex:0];
        //            if (yearElement.exists) {
        //                [yearElement swipeDown];
        //                sleep(3);
        //                [yearElement swipeUp];
        //                sleep(3);
        //            }
        //        XCUIElement *monthElement = [[[[[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeDatePicker] elementBoundByIndex:0]childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypePickerWheel ]elementBoundByIndex:1];
        //            if (monthElement.exists) {
        //                [monthElement swipeDown];
        //                sleep(3);
        //                [monthElement swipeUp];
        //                sleep(3);
        //            }
        XCUIElement *dayElement = [[[[[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeDatePicker] elementBoundByIndex:0]childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypePickerWheel ]elementBoundByIndex:2];
        if (dayElement.exists) {
            [dayElement swipeDown];
            sleep(1);
            //            [dayElement swipeUp];
            //            sleep(1);
        }
        
        sleep(4);
        
        XCUIElement *DoneButtonElement = [[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:1];
        [DoneButtonElement tap];
        
        sleep(5);
        
    }
    
    
    for (int i=0; i<3; i++) {
        XCUIElement *swipeElement = [[[[[[[[[[[[[[[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0]  childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:3] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0];
        if (swipeElement.exists) {
            
            [swipeElement swipeRight];
            sleep(1);
            [swipeElement swipeLeft];
            sleep(1);
            [swipeElement swipeRight];
        }
        
        XCUIElement *playElement = [[[[[[[[[[[[[[[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0]  childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:2] childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:0];
        if (playElement.exists) {
            if (playElement.isHittable) {
                [[playElement coordinateWithNormalizedOffset:CGVectorMake(0.5, 0.5)] tap];
            }
        }
        
        sleep(8);
        
    }
}


#pragma mark - 暴力测试用例----------》设置

// 从预览界面进入设备设置，不修改设置界面，点击返回至设备预览界面，再点击返回至设备列表界面100次
- (void)testSettingsDemo
{
    sleep(6);
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *navigationBarsQuery = app.navigationBars;
    XCUIElementQuery *tablesQuery = app.tables;
    
    for (int i=0; i<100; i++) {
        
        // 点击 cell
        XCUIElement *cellElement = tablesQuery.staticTexts[@"我的设备26"];
        XCTAssert(cellElement.exists, @"Cound not found -------->cellElement");
        [cellElement tap];
        
        
        // 进入 “设置”
        XCUIElement *settingsElement = [navigationBarsQuery matchingIdentifier:@"我的设备26"].buttons[@"icon preview more"];
        XCTAssert(settingsElement.exists, @"Cound not found -------->settingsElement");
        [settingsElement tap];
        
        
        // 返回 预览
        XCUIElement *backFromSettingsElement = [navigationBarsQuery matchingIdentifier:@"设备设置"].buttons[@"icon add arrow left"];
        XCTAssert(backFromSettingsElement.exists, @"Cound not found -------->backFromSettingsElement");
        [backFromSettingsElement tap];
        
        
        // 返回至 设备列表
        XCUIElement *backFromReviewElement = [navigationBarsQuery matchingIdentifier:@"我的设备26"].buttons[@"icon add arrow left"];
        XCTAssert(backFromReviewElement.exists, @"Cound not found -------->backFromReviewElement");
        [backFromReviewElement tap];
    }
}

// 从预览界面进入设备设置，点击保存，点击返回至设备预览界面，再点击返回至设备列表界面
- (void)testSettingsDemo1
{
    sleep(6);
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *navigationBarsQuery = app.navigationBars;
    XCUIElementQuery *tablesQuery = app.tables;
    
    for (int i=0; i<10; i++) {
        
        // 点击 cell
        XCUIElement *cellElement = tablesQuery.staticTexts[@"我的设备26"];
        XCTAssert(cellElement.exists, @"Cound not found -------->cellElement");
        [cellElement tap];
        
        
        // 进入 “设置”
        XCUIElement *settingsElement = [navigationBarsQuery matchingIdentifier:@"我的设备26"].buttons[@"icon preview more"];
        XCTAssert(settingsElement.exists, @"Cound not found -------->settingsElement");
        [settingsElement tap];
        
        // Done
        XCUIElement *DoneFromSettingsElement = [navigationBarsQuery matchingIdentifier:@"设备设置"].buttons[@"icon setting right"];
        XCTAssert(DoneFromSettingsElement.exists, @"Cound not found -------->DoneFromSettingsElement");
        [DoneFromSettingsElement tap];
        
        
        // 返回至 设备列表
        XCUIElement *backFromSettingsElement = [navigationBarsQuery matchingIdentifier:@"我的设备26"].buttons[@"icon add arrow left"];
        XCTAssert(backFromSettingsElement.exists, @"Cound not found -------->backFromSettingsElement");
        [backFromSettingsElement tap];
    }
}

// 从设备列表界面，点击进入设备设置，再返回设备列表界面
- (void)testSettingsDemo2
{
    sleep(6);
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *navigationBarsQuery = app.navigationBars;
    
    XCUIElement *buttonMoreElement = [[[[[[[[[[[[[[[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeTable] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:5] childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:0];
    if (buttonMoreElement.exists) {
        [buttonMoreElement tap];
    }
    
    sleep(1);
    
    XCUIElement *settingsElement = [[[[[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeTable] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:1];
    if (settingsElement.exists) {
        [settingsElement tap];
    }
    
    sleep(1);
    
    // Done
    XCUIElement *DoneFromSettingsElement = [navigationBarsQuery matchingIdentifier:@"设备设置"].buttons[@"icon add arrow left"];
    XCTAssert(DoneFromSettingsElement.exists, @"Cound not found -------->DoneFromSettingsElement");
    [DoneFromSettingsElement tap];
}

// 从设备列表界面，点击进入设备设置，点击保存，再返回设备列表界面
- (void)testSettingsDemo3
{
    sleep(6);
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *navigationBarsQuery = app.navigationBars;
    
    XCUIElement *buttonMoreElement = [[[[[[[[[[[[[[[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeTable] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:5] childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:0];
    if (buttonMoreElement.exists) {
        [buttonMoreElement tap];
    }
    
    sleep(1);
    
    XCUIElement *settingsElement = [[[[[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeTable] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:1];
    if (settingsElement.exists) {
        [settingsElement tap];
    }
    
    sleep(1);
    
    // Done
    XCUIElement *DoneFromSettingsElement = [navigationBarsQuery matchingIdentifier:@"设备设置"].buttons[@"icon setting right"];
    XCTAssert(DoneFromSettingsElement.exists, @"Cound not found -------->DoneFromSettingsElement");
    [DoneFromSettingsElement tap];
}


#pragma mark - 暴力测试用例----------》刷新设备列表

// 下拉刷新设备列表，刷新状态停止后，再次执行下拉刷新动作，重复操作
- (void)testRefreshDeviceListDemo
{
    sleep(6);
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    
    for (int i=0; i<100; i++) {
        [app swipeDown];
        
        sleep(2);
    }
}

// 下拉刷新设备列表，刷新状态还在执行中，没有停止，继续执行下拉刷新动作，重复操作
- (void)testRefreshDeviceListDemo1
{
    sleep(6);
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    
    for (int i=0; i<100; i++) {
        [app swipeDown];
    }
    
}

// 在添加有X台设备的账号设备列表界面，点击其中一台在线设备，进入预览出图后，点击退出，刷新列表，重复操作
- (void)testRefreshDeviceListDemo2
{
    sleep(6);
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *navigationBarsQuery = app.navigationBars;
    XCUIElementQuery *tablesQuery = app.tables;
    
    for (int i=0; i<10; i++) {
        NSUInteger cellCount = self.deviceNameArray.count;
        NSUInteger indexCell = (int)(0 + (arc4random() % (cellCount)));
        
        // 点击 cell
        XCUIElement *tableElement = tablesQuery.staticTexts[self.deviceNameArray[indexCell]];
        if (tableElement.exists) {
            [tableElement tap];
        }
        
        sleep(10);
        
        // 返回
        XCUIElement *backElement = [navigationBarsQuery matchingIdentifier:self.deviceNameArray[indexCell]].buttons[@"icon add arrow left"];
        if (backElement.exists) {
            [backElement tap];
        }
    
        [app swipeDown];
        
    }
}

#pragma mark - 出图测试用例--------------》非预连接设备

// 进入预览出图时间2-5秒
- (void)testLoadVideoDemo
{
    sleep(6);
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *navigationBarsQuery = app.navigationBars;
    XCUIElementQuery *tablesQuery = app.tables;
    
    for (int i=0; i<10; i++) {
        NSUInteger cellCount = self.deviceNameArray.count;
        NSUInteger indexCell = (int)(0 + (arc4random() % (cellCount)));
        
        // 点击 cell
        XCUIElement *tableElement = tablesQuery.staticTexts[self.deviceNameArray[indexCell]];
        if (tableElement.exists) {
            [tableElement tap];
        }
        
        
        sleep(5);
        
        // 返回
        XCUIElement *backElement = [navigationBarsQuery matchingIdentifier:self.deviceNameArray[indexCell]].buttons[@"icon add arrow left"];
        if (backElement.exists) {
            [backElement tap];
        }
    }
}

// 进入预览出图时间5-20秒
- (void)testLoadVideoDemo1
{
    sleep(6);
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *navigationBarsQuery = app.navigationBars;
    XCUIElementQuery *tablesQuery = app.tables;
    
    for (int i=0; i<10; i++) {
        NSUInteger cellCount = self.deviceNameArray.count;
        NSUInteger indexCell = (int)(0 + (arc4random() % (cellCount)));
        
        // 点击 cell
        XCUIElement *cellElement = tablesQuery.staticTexts[self.deviceNameArray[indexCell]];
        if (cellElement.isEnabled) {
            [cellElement tap];
        }
        
        sleep(20);
        
        // 返回
        XCUIElement *backElement = [navigationBarsQuery matchingIdentifier:self.deviceNameArray[indexCell]].buttons[@"icon add arrow left"];
        if (backElement.exists) {
            [backElement tap];
        }
        
    }
}



# pragma mark - 手机性能测试---------------》获取CPU Usage

- (void)testQueryforCPUUsage
{
    int mib[2U] = { CTL_HW, HW_NCPU };
    size_t sizeOfNumCPUs = sizeof(self->numCPUs);
    int status = sysctl(mib, 2U, &self->numCPUs, &sizeOfNumCPUs, NULL, 0U);
    if(status) self->numCPUs = 1;
    
    self->CPUUsageLock = [[NSLock alloc] init];
    
    self->updateTimer = [NSTimer scheduledTimerWithTimeInterval:3
                                                         target:self
                                                       selector:@selector(updateInfo:)
                                                       userInfo:nil
                                                        repeats:YES];
}


- (void)updateInfo:(NSTimer *)timer
{
    natural_t numCPUsU = 0U;
    kern_return_t err = host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &numCPUsU, &cpuInfo, &numCpuInfo);
    if(err == KERN_SUCCESS) {
        [CPUUsageLock lock];
        
        for(unsigned i = 0U; i < numCPUs; ++i) {
            float inUse, total;
            if(prevCpuInfo) {
                inUse = (
                         (cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER]   - prevCpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER])
                         + (cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] - prevCpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM])
                         + (cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE]   - prevCpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE])
                         );
                total = inUse + (cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE] - prevCpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE]);
            } else {
                inUse = cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER] + cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] + cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE];
                total = inUse + cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE];
            }
            
            NSLog(@"Core: %u Usage: %f",i,inUse / total);
        }
        [CPUUsageLock unlock];
        
        if(prevCpuInfo) {
            size_t prevCpuInfoSize = sizeof(integer_t) * numPrevCpuInfo;
            vm_deallocate(mach_task_self(), (vm_address_t)prevCpuInfo, prevCpuInfoSize);
        }
        
        prevCpuInfo = cpuInfo;
        numPrevCpuInfo = numCpuInfo;
        
        cpuInfo = NULL;
        numCpuInfo = 0U;
    } else {
        NSLog(@"Error!");
        
    }
}


- (void)testCPUUsage
{
    kern_return_t            kr = { 0 };
    task_info_data_t        tinfo = { 0 };
    mach_msg_type_number_t    task_info_count = TASK_INFO_MAX;
    
    kr = task_info( mach_task_self(), TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count );
    if ( KERN_SUCCESS != kr )
        NSLog(@"get CPUUsage error");
    
    task_basic_info_t        basic_info = { 0 };
    thread_array_t            thread_list = { 0 };
    mach_msg_type_number_t    thread_count = { 0 };
    
    thread_info_data_t        thinfo = { 0 };
    thread_basic_info_t        basic_info_th = { 0 };
    
    basic_info = (task_basic_info_t)tinfo;    // get threads in the task
    kr = task_threads( mach_task_self(), &thread_list, &thread_count );
    if ( KERN_SUCCESS != kr )
        NSLog(@"get CPUUsage error");
    long    tot_sec = 0;
    long    tot_usec = 0;
    float    tot_cpu = 0;
    for ( int i = 0; i < thread_count; i++ )
    {
        mach_msg_type_number_t thread_info_count = THREAD_INFO_MAX;
        
        kr = thread_info( thread_list[i], THREAD_BASIC_INFO, (thread_info_t)thinfo, &thread_info_count );
        if ( KERN_SUCCESS != kr )
            NSLog(@"get CPUUsage error");
        
        basic_info_th = (thread_basic_info_t)thinfo;
        if ( 0 == (basic_info_th->flags & TH_FLAGS_IDLE) )
        {
            tot_sec = tot_sec + basic_info_th->user_time.seconds + basic_info_th->system_time.seconds;
            tot_usec = tot_usec + basic_info_th->system_time.microseconds + basic_info_th->system_time.microseconds;
            tot_cpu = tot_cpu + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE;
        }
    }
    
    kr = vm_deallocate( mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t) );
    if ( KERN_SUCCESS != kr )
        NSLog(@"get CPUUsage error");
    
     // CPU 占用百分比
    
    while (1) {
        NSLog(@"获取CPU使用率=%f", tot_cpu * 100.);
    }
    
    
}



# pragma mark - 手机性能测试---------------》获取Memory Usage

- (void)testQueryforMemoryUsage
{
//    UIDevice.currentDevice.batteryMonitoringEnabled = true;
//    NSLog(@"电量：%f%%", [UIDevice currentDevice].batteryLevel * 100);
    
    
    // 内存
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&info, &size);
    if (kr != KERN_SUCCESS) {
        NSLog(@"error:获取内存占用量失败");
    }
    unsigned long memorySize = info.resident_size >> 20;//10-KB   20-MB
    
    NSLog(@"内存占用量：%luMB", memorySize);
    
    
}

@end

