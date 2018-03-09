//
//  PaymentManager.swift
//  lz
//
//  Created by 张涛 on 2018/1/15.
//  Copyright © 2018年 AngleKeen. All rights reserved.
//

import UIKit

public enum PaymentType: NSInteger {
    case none = 0
    case wechat = 1
    case zhifubao = 2
}

class PaymentManager: NSObject {
    
    typealias payFinishBlock = (_ succeed:Bool, _ response:Int32?)-> ()
    
    var finishPay:payFinishBlock?
    
    static let shareManager = PaymentManager()
    
    class func registerWeChat() {
        WXApi.registerApp("")
    }
    
    class func isWXAppInstalled()-> Bool {
        return WXApi.isWXAppInstalled()
    }
    
    func jumpToBizPay(payType: PaymentType,payInfo:Dictionary<String, Any>) {
        switch payType {
        case .wechat:
            let request = PayReq()
            request.partnerId = payInfo["partnerid"] as! String
            request.prepayId = payInfo["prepayid"] as! String
            request.package = "Sign=WXPay"
            request.nonceStr = payInfo["noncestr"] as! String
            request.timeStamp = UInt32(payInfo["timestamp"] as! String)!
            request.sign = payInfo["sign"] as! String
            let register = WXApi.send(request)
            print(register)
        case .zhifubao:
            print("zhifubao")
            AlipaySDK.defaultService().payOrder("jjj", fromScheme: "lz", callback: { (resultDic) in
                print("***************************")
                print(resultDic ?? "")
                print("***************************")
                let result = resultDic as! Dictionary<String, Any>
                let code: String = result["resultStatus"] as! String

                if code == "9000" {

                }else{

                }
            })
            
        default:
            break
        }
    }
    
}

// WX delegate
extension PaymentManager: WXApiDelegate {
    
    func onResp(_ resp: BaseResp) {
        if resp.isKind(of: PayResp.self) {
            switch resp.errCode{
            case 0:
                print("成功啦......")
                if finishPay != nil{
                    finishPay!(true, resp.errCode)
                }
            default:
                print("失败了")
                print(resp.errCode)
                if finishPay != nil{
                    finishPay!(false,resp.errCode)
                }
                break
            }
        }
    }
}

class PaymentModel: NSObject {
    
    var paymentTitle:String!
    var paymentDesc:String!
    var paymentPrice:Double!
    var paymentId:String!
    var paymentPrj:String!
    var orderId:String!
}
