//
//  ViewController.swift
//  SJTouchIDDemo
//
//  Created by SoulJa on 2017/7/27.
//  Copyright © 2017年 com.shengpay.mpos.shengshua. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //本地验证上下文
        let context = LAContext()
        //错误信息
        var error:NSError?
        
        var alertView = UIAlertView();
        
        //开启了指纹识别
        if (context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "TouchID", reply: { (isSuccess, error) in
                //认证成功
                if (isSuccess) {
                    alertView = UIAlertView(title: "警告", message: "认证成功", delegate: nil, cancelButtonTitle: "确定")
                    alertView.show()
                }
                //如果存在错误
                if ((error) != nil) {
                    let errorTemp = error! as NSError
                    //错误信息
                    var errorMsg = String()
                    
                    switch Int32(errorTemp.code) {
                    //用户验证没有通过，比如提供了错误的手指的指纹
                    case kLAErrorAuthenticationFailed:
                        errorMsg = "用户验证没有通过，比如提供了错误的手指的指纹"
                        break
                    // 用户取消了Touch ID验证
                    case kLAErrorUserCancel:
                        errorMsg = "用户取消了Touch ID验证"
                        break
                    //用户不想进行Touch ID验证，想进行输入密码操作
                    case kLAErrorUserFallback:
                        errorMsg = "用户不想进行Touch ID验证，想进行输入密码操作"
                        break
                    //系统终止了验证
                    case kLAErrorSystemCancel:
                        errorMsg = "系统终止了验证"
                        break
                    //用户没有在设备Settings中设定密码
                    case kLAErrorPasscodeNotSet:
                        errorMsg = "用户没有在设备Settings中设定密码"
                        break
                    // 设备不支持Touch ID
                    case kLAErrorTouchIDNotAvailable:
                        errorMsg = "设备不支持Touch ID"
                        break
                    // 设备没有进行Touch ID 指纹注册
                    case kLAErrorTouchIDNotEnrolled:
                        errorMsg = "设备没有进行Touch ID 指纹注册"
                        break
                    default:
                        break
                    }
                }
                
            })
        }
        //未开启指纹识别
        else {
            alertView = UIAlertView(title: "警告", message: "设备不支持TouID", delegate: nil, cancelButtonTitle: "确定")
            alertView.show()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

