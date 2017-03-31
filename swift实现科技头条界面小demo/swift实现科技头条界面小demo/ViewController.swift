//
//  ViewController.swift
//  科技头条
//
//  Created by HM09 on 17/3/31.
//  Copyright © 2017年 itheima. All rights reserved.
//

import UIKit

let identifier = "itnewsCell"

class ViewController: UIViewController {
    
    /// 数据源数组
    var dataSourceArr: [NewsModel] = []
    
    /// tableView的懒加载属性
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.dataSource = self
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        
        //注册cell
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: identifier)
        
        //设置tableview自适应高度
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        
        //加载数据
        loadData()
    }
    
    func loadData() {
        //获取数据
        //创建一个url, url是一个可选值
        let url = URL(string: "http://news.coolban.com/Api/Index/news_list/app/2/cat/0/limit/20/time/0/type/0")
        
        //调用URLSession创建dataTask, 并resume
        //url参数是必选的, 意味着传入的url必须强制解包
        //responseData: 是服务器给我们返回的二进制数据, 另外两个参数不需要用, 可以用 _ 忽略掉
        URLSession.shared.dataTask(with: url!) { (responseData, _, _) in
            //responseData是一个可选值, 使用前, 先要可选绑定
            if let responseData = responseData {
                //对responseData做反序列化(json解析), 参数是必选的
                //jsonObject方法, 会抛出异常, 所以需要做异常处理
                //异常处理: try? 如果try后面的方法执行不成功, 返回一个nil; try!如果后面的方法执行不成功, 会直接崩溃; try?返回的是一个可选值, try! 返回的是一个必选值
                let object = try? JSONSerialization.jsonObject(with: responseData, options: [])
                
                //object是Any类型, 不能遍历使用, 需要将其先转换成字典数组类型
                //as? 弱转换, 生成可选值  as!强转换, 返回一个必选值, 如果转换失败会崩溃
                let dics = object as! [[String: Any]]
                
                //dics是一个可选的字典数组
                
                    //字典转模型
                    var newsModelArr: [NewsModel] = []
                    for dic in dics {
                        let model = NewsModel(dict: dic)
                        newsModelArr.append(model)
                    }
                    
                    self.dataSourceArr = newsModelArr
                    
                    //去主线程更新UI
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                
            }
        }.resume()
    }
    
    func loadData2() {
        //获取数据
        //创建一个url, url是一个可选值
        let url = URL(string: "http://news.coolban.com/Api/Index/news_list/app/2/cat/0/limit/20/time/0/type/0")
        
        //调用URLSession创建dataTask, 并resume
        //url参数是必选的, 意味着传入的url必须强制解包
        //responseData: 是服务器给我们返回的二进制数据, 另外两个参数不需要用, 可以用 _ 忽略掉
        URLSession.shared.dataTask(with: url!) { (responseData, _, _) in
            //responseData是一个可选值, 使用前, 先要可选绑定
            if let responseData = responseData,
                let dicArr = (try? JSONSerialization.jsonObject(with: responseData, options: [])) as? [[String: Any]] {
                //字典转模型
                var newsModelArr: [NewsModel] = []
                for dic in dicArr {
                    let model = NewsModel(dict: dic)
                    newsModelArr.append(model)
                }
                
                self.dataSourceArr = newsModelArr
                
                //去主线程更新UI
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }.resume()
    }
}



// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! NewsCell
        let model = dataSourceArr[indexPath.row]
        cell.newsModel = model
        return cell
    }
}

