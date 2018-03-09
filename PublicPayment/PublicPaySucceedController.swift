//
//  PublicPaySucceedController.swift
//  joy
//
//  Created by Angle on 2018/2/7.
//  Copyright © 2018年 AngleKeen. All rights reserved.
//

import UIKit
import SnapKit

let UI_IS_IPHONE = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
let UI_IS_IPHONEX = UI_IS_IPHONE && UIScreen.main.bounds.size.height == 812

class PublicPaySucceedController: UIViewController {
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

    var topView = UIView()
    var topLabel = UILabel()
    var topImage = UIImageView()
    var backHome = UIButton()
    var chatServicer = UIButton()
    var checkOrder = UIButton()
    var matchId:String? = "5a7bf6a49f54540070d41622"
    // TODO: 订单信息
//    var match:MatchData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showNavigation = true
        self.registerTitle = "支付成功"
        self.leftButton.isHidden = true
        
        if UI_IS_IPHONEX {
            navigationH = 88.0
        }else{
            navigationH = 64.0
        }
        self.view.clipsToBounds = true
        self.view.backgroundColor = UIColor(white: 240/256.0, alpha: 1)

        
        topView.backgroundColor = UIColor.white
        topView.layer.cornerRadius = 5
        topView.layer.masksToBounds = true
        self.view.addSubview(topView)
        
        topLabel.text = "支付成功"
        topLabel.font = UIFont.systemFont(ofSize: 20)
        topLabel.textAlignment = .center
        topView.addSubview(topLabel)
        
        topImage.image = UIImage.init(named: "paySucceed")
        topView.addSubview(topImage)
        
        backHome.setTitle("返回首页", for: .normal)
        backHome.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        backHome.layer.cornerRadius = 3
        backHome.layer.masksToBounds = true
        backHome.setTitleColor(UIColor.black, for: .normal)
        backHome.backgroundColor = UIColor.white
        backHome.addTarget(self, action: #selector(self.backHomeAction), for: .touchUpInside)
        self.view.addSubview(backHome)
        
        chatServicer.setTitle("联系服务者", for: .normal)
        chatServicer.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        chatServicer.layer.cornerRadius = 3
        chatServicer.layer.masksToBounds = true
        chatServicer.setTitleColor(UIColor.black, for: .normal)
        chatServicer.backgroundColor = UIColor.white
        chatServicer.addTarget(self, action: #selector(self.chatServicerAction), for: .touchUpInside)
        self.view.addSubview(chatServicer)
        
        checkOrder.setTitle("查看订单", for: .normal)
        checkOrder.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        checkOrder.layer.cornerRadius = 3
        checkOrder.layer.masksToBounds = true
        checkOrder.setTitleColor(UIColor.black, for: .normal)
        checkOrder.backgroundColor = UIColor.white
        checkOrder.addTarget(self, action: #selector(self.checkOrderAction), for: .touchUpInside)
        self.view.addSubview(checkOrder)
        
        self.layoutSubviews()
        
        // TODO: 获取订单信息
//        MatchListModel.fetchMatct(objcet: self.matchId ?? "") { (succeed, response) in
//            if succeed{
//                self.match = response as? MatchData
//                AKLog(self.match?.user_service_name)
//                AKLog(self.match?.user_service_id)
//            }
//        }
    }
    
    
    
    @objc func backHomeAction() {
        let firstVc = self.navigationController?.viewControllers[0]
        self.navigationController?.setViewControllers([firstVc!], animated: true)
    }
    
    @objc func chatServicerAction() {
        // TODO: 跳转到一级页面并根据订单中的用户信息跳到IM中
        let firstVc = self.navigationController?.viewControllers[0]
        self.navigationController?.setViewControllers([firstVc!], animated: false)
//        let par = ["user_id":self.match?.user_service_id ?? (Any).self, "user_name":self.match?.user_service_id ?? (Any).self] as Dictionary<AnyHashable,Any>?
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ChatFromPay"), object: nil, userInfo: par)
    }
    
    @objc func checkOrderAction() {
        let firstVc = self.navigationController?.viewControllers[0]
        self.navigationController?.setViewControllers([firstVc!], animated: false)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CheckOrderFormPay"), object: nil, userInfo: nil)
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
        
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(self.registerTitleView.snp.bottom).offset(30)
            make.left.equalTo(self.view).offset(25)
            make.right.equalTo(self.view).offset(-25)
            make.height.equalTo(150)
        }
        topLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topView).offset(40)
            make.centerX.equalTo(topView)
        }
        topImage.snp.makeConstraints { (make) in
            make.top.equalTo(topLabel.snp.bottom).offset(10)
            make.centerX.equalTo(topView)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        backHome.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom).offset(20)
            make.left.equalTo(self.view).offset(25)
            make.size.equalTo(CGSize(width: (self.view.frame.size.width - 100) / 3, height: 35))
        }
        chatServicer.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom).offset(20)
            make.left.equalTo(backHome.snp.right).offset(25)
            make.size.equalTo(CGSize(width: (self.view.frame.size.width - 100) / 3, height: 35))
        }
        checkOrder.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom).offset(20)
            make.left.equalTo(chatServicer.snp.right).offset(25)
            make.size.equalTo(CGSize(width: (self.view.frame.size.width - 100) / 3, height: 35))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension PublicPaySucceedController {
    //MARK: - 设置UI
    /// 设置导航栏
    func settingNavigationView() {
        //头背景
        self.registerTitleView = UIImageView()
        self.registerTitleView.isUserInteractionEnabled = true
        self.registerTitleView.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(self.registerTitleView)
        
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
