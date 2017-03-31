//
//  NewsModel.swift
//  科技头条
//
//  Created by HM09 on 17/3/31.
//  Copyright © 2017年 itheima. All rights reserved.
//

import UIKit

class NewsModel: NSObject {
    /// 新闻的id
    var id: String?
    
    ///新闻的标题
    var title: String?
    
    ///新闻的图片
    var src_img: String?
    
    ///新闻的来源
    var sitename: String?
    
    ///新闻的发布时间的时间戳
    var addtime: String?
    
    ///kvc构造函数
    init (dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
