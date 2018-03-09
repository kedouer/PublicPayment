//
//  PublicPayViewController.swift
//  lz
//
//  Created by 张涛 on 2018/1/12.
//  Copyright © 2018年 AngleKeen. All rights reserved.
//

import UIKit

class PublicPayViewController: UIViewController {
    var navigationH:CGFloat = 64.0
    //MARK - 属性
    var showNavigation:Bool = false {
        didSet{
            if showNavigation {
                self.settingNavigationView()
            }
        }
    }
    var registerTitleView:UIImageView = UIImageView()
    var registerTitle:String = String(){
        didSet{
            titleLabel.text = registerTitle
        }
    }
    var leftButton:UIButton = UIButton()
    var titleLabel:UILabel = UILabel()
    var navigationLine:UIView = UIView()
    
    let OrderClass = "Match"
    //预付款信息
    var payInfo:PaymentModel!
    //付款类别
    var payType = PaymentType.none
    //TODO: 付款信息
//    var payment:Payment?
    //UI相关
    var timeImage:UIImageView!
    var timeTitle:UILabel!
    var timeLine:UIView!
    
    var priceTitle:UILabel!
    var priceValue:UILabel!
    var priceLine:UIView!
    
    var wxImage:UIImageView!
    var wxTitle:UILabel!
    var wxSelect:UIImageView!
    var wxActionButton:UIButton!
    
    var aliImage:UIImageView!
    var aliTitle:UILabel!
    var aliSelect:UIImageView!
    var aliActionButton:UIButton!
    
    var payBtn:UIButton!
    
    var timer:Timer!
    var second = 900
    var orderAvailable = true

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        showNavigation = true
        registerTitle = "支付订单"
        
        if UI_IS_IPHONEX {
            navigationH = 88.0
        }else{
            navigationH = 64.0
        }
        self.view.clipsToBounds = true
        
        timeImage = UIImageView()
        timeImage.image = UIImage.init(named: "time")
        view.addSubview(timeImage)
        
        timeTitle = UILabel()
        timeTitle.font = UIFont.systemFont(ofSize: 16)
        timeTitle.textColor = UIColor.red
        timeTitle.text = "支付剩余时间 14:59"
        timeTitle.textAlignment = .center
        view.addSubview(timeTitle)
        
        timeLine = UIView()
        timeLine.backgroundColor = UIColor.init(white: 238/255.0, alpha: 1)
        view.addSubview(timeLine)
        
        priceTitle = UILabel()
        priceTitle.font = UIFont.systemFont(ofSize: 18)
        priceTitle.textColor = UIColor.black
        priceTitle.text = "需支付"
        view.addSubview(priceTitle)
        
        priceValue = UILabel()
        priceValue.font = UIFont.systemFont(ofSize: 18)
        priceValue.textColor = UIColor.red
        priceValue.textAlignment = .right
        // TODO: 显示价格
//        priceValue.text = "￥\(self.payInfo.paymentPrice ?? 0)"
        view.addSubview(priceValue)
        
        priceLine = UIView()
        priceLine.backgroundColor = UIColor.init(white: 238/255.0, alpha: 1)
        view.addSubview(priceLine)
        
        wxImage = UIImageView()
        wxImage.image = UIImage.init(named: "wechat")
        view.addSubview(wxImage)
        
        wxTitle = UILabel()
        wxTitle.font = UIFont.systemFont(ofSize: 16)
        wxTitle.textColor = UIColor.black
        wxTitle.text = "微信支付"
        wxTitle.textAlignment = .center
        view.addSubview(wxTitle)
        
        wxSelect = UIImageView()
        wxSelect.image = UIImage.init(named: "unAgree")
        view.addSubview(wxSelect)
        
        wxActionButton = UIButton()
        wxActionButton.addTarget(self, action: #selector(PublicPayViewController.wxSelected), for: .touchUpInside)
        view.addSubview(wxActionButton)
        
        aliImage = UIImageView()
        aliImage.image = UIImage.init(named: "zhifubao")
        view.addSubview(aliImage)
        
        aliTitle = UILabel()
        aliTitle.font = UIFont.systemFont(ofSize: 16)
        aliTitle.textColor = UIColor.black
        aliTitle.text = "支付宝支付"
        aliTitle.textAlignment = .center
        view.addSubview(aliTitle)
        
        aliSelect = UIImageView()
        aliSelect.image = UIImage.init(named: "unAgree")
        view.addSubview(aliSelect)
        
        aliActionButton = UIButton()
        aliActionButton.addTarget(self, action: #selector(PublicPayViewController.aliSelected), for: .touchUpInside)
        view.addSubview(aliActionButton)
        
        payBtn = UIButton()
        payBtn.backgroundColor = UIColor.red
        payBtn.setTitle("确认支付", for: .normal)
        payBtn.addTarget(self, action: #selector(PublicPayViewController.payAction), for: .touchUpInside)
        view.addSubview(payBtn)
        
        self.wxSelected()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(PublicPayViewController.timerAction), userInfo: nil, repeats: true)
        
        self.layoutSubviews()
    }
    
    func layoutSubviews() {
        if self.showNavigation {
            
            if UI_IS_IPHONEX {
                self.registerTitleView.snp.makeConstraints({ (make) in
                    make.top.equalTo(0)
                    make.left.right.equalTo(self.view)
                    make.height.equalTo(88)
                })
            }else {
                self.registerTitleView.snp.makeConstraints({ (make) in
                    make.top.equalTo(0)
                    make.left.right.equalTo(self.view)
                    make.height.equalTo(64)
                })
            }
            
            self.leftButton.snp.makeConstraints({ (make) in
                make.leftMargin.equalTo(12)
                make.bottom.equalTo(self.registerTitleView).offset(-14)
            })
            
            self.titleLabel.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.registerTitleView).offset(-14)
                make.centerX.equalTo(self.registerTitleView.snp.centerX)
            })
            
            self.navigationLine.snp.makeConstraints({ (make) in
                make.left.right.equalTo(self.registerTitleView)
                make.top.equalTo(self.registerTitleView.snp.bottom).offset(-0.5)
                make.height.equalTo(0.5)
            })
        }
        
        timeTitle.snp.makeConstraints { (make) in
            make.top.equalTo(self.registerTitleView.snp.bottom).offset(10)
            make.centerX.equalTo(self.view)
        }
        
        timeImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(timeTitle)
            make.right.equalTo(self.timeTitle.snp.left).offset(-6)
            make.size.equalTo(CGSize(width: 18, height: 18))
        }
        
        timeLine.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.timeTitle.snp.bottom).offset(10)
            make.height.equalTo(0.5)
        }
        
        priceTitle.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(12)
            make.top.equalTo(timeLine.snp.bottom).offset(10)
            make.width.equalTo((view.frame.size.width - 24) / 2.0)
        }
        
        priceValue.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.centerX)
            make.top.equalTo(timeLine.snp.bottom).offset(10)
            make.width.equalTo((view.frame.size.width - 24) / 2.0)
        }
        
        priceLine.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(priceTitle.snp.bottom).offset(10)
            make.height.equalTo(0.5)
        }
        
        wxImage.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(12)
            make.top.equalTo(self.priceLine).offset(15)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        wxTitle.snp.makeConstraints { (make) in
            make.left.equalTo(wxImage.snp.right).offset(12)
            make.centerY.equalTo(wxImage)
        }
        wxSelect.snp.makeConstraints { (make) in
            make.right.equalTo(self.view).offset(-15)
            make.centerY.equalTo(wxImage)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        wxActionButton.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(wxImage).offset(-15)
            make.bottom.equalTo(wxImage).offset(15)
        }
        
        aliImage.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(12)
            make.top.equalTo(self.wxImage.snp.bottom).offset(30)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        aliTitle.snp.makeConstraints { (make) in
            make.left.equalTo(aliImage.snp.right).offset(12)
            make.centerY.equalTo(aliImage)
        }
        aliSelect.snp.makeConstraints { (make) in
            make.right.equalTo(self.view).offset(-15)
            make.centerY.equalTo(aliImage)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        aliActionButton.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(aliImage).offset(-15)
            make.bottom.equalTo(aliImage).offset(15)
        }
        
        payBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(12)
            make.right.bottom.equalTo(self.view).offset(-12)
            make.height.equalTo(50)
        }
    }
    
    //MARK: - 按钮点击
    @objc func leftButtonSelected() {
        let alert = UIAlertController(title: "确认取消支付？", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (action) in
            
        }
        let sure = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) { (action) in
            // TODO: 取消订单
//            let dict = ["objectId":self.payInfo.orderId as Any, "opcode":"cancelbeforepay" as Any]
//            LeanCloudManager.callCloudFunc(name: "joy_match_op", parameter: dict, finishBlock: { (succeed, result) in
//                // 返回页面
//                self.navigationController?.popViewController(animated: true)
//            })
        }
        alert.addAction(sure)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func wxSelected() {
        if !wxActionButton.isSelected {
            wxActionButton.isSelected = true
            wxSelect.image = UIImage.init(named: "Agree")
            
            aliActionButton.isSelected = false
            aliSelect.image = UIImage.init(named: "unAgree")
            
            self.payType = .wechat
        }
    }
    
    @objc func aliSelected() {
        if !aliActionButton.isSelected {
            aliActionButton.isSelected = true
            aliSelect.image = UIImage.init(named: "Agree")
            
            wxActionButton.isSelected = false
            wxSelect.image = UIImage.init(named: "unAgree")
            
            self.payType = .zhifubao
        }
    }
    
    @objc func timerAction() {
        let currentMin = second / 60
        let currentSeconde = second - currentMin * 60
        let text = String.init(format: "支付剩余时间 %02d:%02d", currentMin,currentSeconde)
        self.timeTitle.text = text
        self.second = self.second - 1
        if self.second == 0 {
            timer.invalidate()
            self.timeTitle.text = "订单已过期"
            self.orderAvailable = false
        }
    }
    
    @objc func payAction() {
        if !self.orderAvailable {
            let alert = UIAlertController(title: "订单已过期，是否取消订单？", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (action) in
                
            }
            let sure = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) { (action) in
                // TODO: 取消订单
//                let dict = ["objectId":self.payInfo.orderId as Any, "opcode":"cancelbeforepay" as Any]
//                LeanCloudManager.callCloudFunc(name: "joy_match_op", parameter: dict, finishBlock: { (succeed, result) in
//                    // 返回页面
//                    self.navigationController?.popViewController(animated: true)
//                })
            }
            alert.addAction(sure)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }else{
            if payType == .wechat {
                // TODO: 获取支付信息
//                if self.payment == nil {
//                    Payment.getPayment(objectId: payInfo.paymentId) { (succeed, response) in
//                        if let payModel = response as? Payment {
//                            self.payment = payModel
//                            self.wxUnifiedOrder()
//                        }
//                    }
//                }else{
//                    self.wxUnifiedOrder()
//                }
            }else if payType == .zhifubao {
                
            }
        }
    }
    // TODO: 验证订单支付状态
    func wxUnifiedOrder() {
        
//        if self.payment == nil {
//            JoyToast.toastWithTitle(title: "下单失败，请重试！", onView: self.view)
//        }
        
//        var parameter = [String:Any]()
//        parameter["body"] = "lztogether"
//        parameter["bookingNo"] = self.payment?.orderno
//        parameter["totalFee"] = Int(self.payInfo.paymentPrice * 100)
//        parameter["paymentId"] = self.payment?.objectId
//        parameter["projectName"] = self.payInfo.paymentPrj
//        parameter["payType"] = "app"
//
//        AKNetWork.AKGet(url: "http://etogether.leanapp.cn/wx_unified_order", parameters: parameter, finishBlock: { (succeed, response) in
//            if !succeed {
//                AKLog(response)
//                return
//            }
//            if let dict = response as? Dictionary<String,Any>{
//                PaymentManager.shareManager.finishPay = {(succeed, errorCode) in
//                    AKLog(errorCode)
//                    if errorCode == 0 {
//                        let succeedPay = PublicPaySucceedController()
//                        succeedPay.matchId = self.payInfo.orderId
//                        self.navigationController?.pushViewController(succeedPay, animated: true)
//                    }else if errorCode == -2 {
//                        JoyToast.toastWithTitle(title: "用户点击取消并返回", onView: self.view)
//                    }else{
//                        JoyToast.toastWithTitle(title: "支付失败！", onView: self.view)
//                    }
//                }
//                PaymentManager.shareManager.jumpToBizPay(payType: PaymentType.wechat, payInfo: dict)
//            }
//        })
    }
    
    
}

extension PublicPayViewController {
    //MARK: - 设置UI
    /// 设置导航栏
    func settingNavigationView() {
        //头背景
        self.registerTitleView = UIImageView()
        self.registerTitleView.isUserInteractionEnabled = true
        self.registerTitleView.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(self.registerTitleView)
        
        //左边按钮
        self.leftButton = UIButton(type: .custom)
        self.leftButton.adjustsImageWhenHighlighted = false
        self.leftButton.setImage(UIImage.init(named: "fanhui"), for: .normal)
        self.leftButton.addTarget(self, action: #selector(self.leftButtonSelected), for: .touchUpInside)
        self.registerTitleView.addSubview(self.leftButton)
        
        //标题
        self.titleLabel = UILabel()
        self.titleLabel.backgroundColor = UIColor.clear
        self.titleLabel.textAlignment = .center
        self.titleLabel.textColor = UIColor.init(red: 74/256.0, green: 76/256.0, blue: 89/256.0, alpha: 1)
        self.titleLabel.font = UIFont.systemFont(ofSize: 16)
        self.titleLabel.text = self.registerTitle
        self.registerTitleView.addSubview(self.titleLabel)
        
        self.navigationLine = UIView()
        self.navigationLine.backgroundColor = UIColor.init(red: 235/256.0, green: 235/256.0, blue: 235/256.0, alpha: 1)
        self.registerTitleView.addSubview(self.navigationLine)
    }
}
