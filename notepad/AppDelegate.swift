//
//  AppDelegate.swift
//  notepad
//
//  Created by Bob John on 10/3/2016.
//  Copyright © 2016 Bob John. All rights reserved.
//

import UIKit
import LocalAuthentication

var pass = false;
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        pass=false;
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        if !pass {
            let sb = UIStoryboard(name: "Main", bundle:nil)
            let vc = sb.instantiateViewControllerWithIdentifier("mainBar")
            (vc as! UITabBarController).selectedIndex=0;
            loginWithTouchID()
        }
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when theapplication is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
    }
    
    func loginWithTouchID(){
        if((UIDevice.currentDevice().systemVersion as NSString).floatValue >= 8.0)
        {
            // Get the local authentication context.
            let context = LAContext()
            // Declare a NSError variable.
            var error: NSError?
            // Set the reason string that will appear on the authentication alert.
            let reasonString = "狠狠地戳莪！"
            // Check if the device can evaluate the policy.
            if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error)
            {
                context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success: Bool, evalPolicyError: NSError?) -> Void in
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in //放到主线程执行，这里特别重要
                        if success
                        {
                            pass = true
                            //调用成功后你想做的事情
                        }
                        else
                        {
                            // If authentication failed then show a message to the console with a short description.
                            // In case that the error is a user fallback, then show the password alert view.
                            print(evalPolicyError?.localizedDescription)
                            if evalPolicyError?.code == (LAError.UserCancel.rawValue) {
                                exit(0);
                            }
                        }
                    })
                })
            }
            else
            {
                // If the security policy cannot be evaluated then show a short message depending on the error.
                switch error!.code
                {
                case LAError.TouchIDNotEnrolled.rawValue:
                    print("您还没有保存TouchID指纹")
                case LAError.PasscodeNotSet.rawValue:
                    print("您还没有设置密码")
                default:
                    // The LAError.TouchIDNotAvailable case.
                    print("TouchID不可用")
                }
                // Optionally the error description can be displayed on the console.
                print(error?.localizedDescription)
                // Show the custom alert view to allow users to enter the password.
            }
        }
    }
    
}

