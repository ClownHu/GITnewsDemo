//
//  NewsCell.swift
//  科技头条
//
//  Created by HM09 on 17/3/31.
//  Copyright © 2017年 itheima. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    /// 新闻图片
    @IBOutlet weak var newsImageView: UIImageView! //已经默认帮我们将这个属性做了强制解包的操作
    
    /// 新闻的标题
    @IBOutlet weak var newsTitle: UILabel!
    
    /// 新闻的来源
    @IBOutlet weak var newsSource: UILabel!
    
    /// 新闻的发布时间
    @IBOutlet weak var newsTime: UILabel!
    
    var newsModel: NewsModel? {
        didSet {
            newsImageView.image = UIImage(named: "xzq")
            newsTitle.text = newsModel?.title
            newsSource.text = newsModel?.sitename
            let addTime = Double((newsModel?.addtime)!)
            newsTime.text = Date(timeIntervalSince1970: addTime!).description
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
