//
//  DZRecommendViewController.swift
//  baisi
//
//  Created by Other on 16/2/11.
//  Copyright © 2016年 wangyue. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import MJRefresh

class DZRecommendViewController: UIViewController {
    // 左侧分类数据
    @IBOutlet weak var categoryTableView: UITableView!
    // 右侧用户数据
    @IBOutlet weak var userTableView: UITableView!
    
    // 懒加载
    // 左侧分类数据
    lazy var categories: NSMutableArray = NSMutableArray()
    // 右侧用户数据
    lazy var users: NSMutableArray = NSMutableArray()
    
    let DZCategoryID = "category"
    let DZUserID = "user"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 控件初始化
        setupTableView()
        // 初始化刷新控件
        setupRefresh()
        // 加载左侧类别数据
        loadCategories()
        
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 20))
        view.backgroundColor = UIColor.redColor()
        userTableView.tableHeaderView = view
        
    }
    
    func loadCategories() {
        SVProgressHUD.showWithMaskType(.Black)
        let param = [
            "a" : "category",
            "c" : "subscribe"
        ]
        
        Alamofire.request(.GET, "http://api.budejie.com/api/api_open.php", parameters: param, encoding: .URL, headers: nil).responseJSON { (Response) -> Void in
            
            switch Response.result {
            case .Success(let json):
                SVProgressHUD.dismiss()
                self.categories = DZRecommendCategory.mj_objectArrayWithKeyValuesArray(json["list"])
                self.categoryTableView.reloadData() // 刷新数据
                
                // 手动选中第0行
                self.categoryTableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: false, scrollPosition: .Top)
                
                 // 刷新
                self.userTableView.mj_header.beginRefreshing()
                
            case .Failure( _):
                SVProgressHUD.showErrorWithStatus("加载信息失败")
            }
        }
    }
    
    func selectedRow() -> Int? {
        return categoryTableView.indexPathForSelectedRow?.row
    }
}

// MARK: - tableView代理方法
extension DZRecommendViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == categoryTableView {
            return categories.count
        } else {
            checkFooterState()
            if let row = selectedRow() {
                let rcate = (categories[row] as? DZRecommendCategory)
                return (rcate?.users?.count)!
            } else {
                return 0
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == categoryTableView {
            let cell = tableView.dequeueReusableCellWithIdentifier(DZCategoryID) as! DZRecommendCategoryCell
            cell.category = categories[indexPath.row] as? DZRecommendCategory
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(DZUserID) as! DZRecommendUserCell
            cell.user = categories[selectedRow()!].users[indexPath.row] as? DZRecommendUser
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        // 先结束之前的刷新状态
        userTableView.mj_header.endRefreshing()
        userTableView.mj_footer.endRefreshing()
        
        let cate: DZRecommendCategory = categories[indexPath.row] as! DZRecommendCategory
        if cate.users?.count == 0 {
            // 显示之前的数据
            userTableView.reloadData()
        } else {
            // 加载新的数据
            userTableView.mj_header.beginRefreshing()
        }
    }
}

// MARK: - 初始化
extension DZRecommendViewController {
    func setupTableView() {
        // 注册
        categoryTableView.registerNib(UINib(nibName: "DZRecommendCategoryCell", bundle: nil), forCellReuseIdentifier: DZCategoryID)
        userTableView.registerNib(UINib(nibName: "DZRecommendUserCell", bundle: nil), forCellReuseIdentifier: DZUserID)
        
        automaticallyAdjustsScrollViewInsets = false
        categoryTableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        userTableView.contentInset = categoryTableView.contentInset
        
        title = "推荐关注"
        view.backgroundColor = UIColor.globalColor()
    }
    
    func setupRefresh() {
        // 下拉加载新数据
        userTableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "loadNewUsers")
        // 上拉加载更多数据
        userTableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: "loadMoreUsers")
        userTableView.tableFooterView?.hidden = true
    }
}

// MARK: - 数据
extension DZRecommendViewController {
    // 加载新用户
    func loadNewUsers() {
        let rcate: DZRecommendCategory = categories[selectedRow()!] as! DZRecommendCategory
        rcate.currentPage = 1
        
        let param = [
            "a" : "list",
            "c" : "subscribe",
            "category_id" : rcate.id!,
            "page" : rcate.currentPage!
        ]
        
        Alamofire.request(.GET, "http://api.budejie.com/api/api_open.php", parameters: param, encoding: .URL, headers: nil).responseJSON { (Response) -> Void in
            
            switch Response.result {
            case .Success(let json):
                SVProgressHUD.dismiss()
                debugPrint(json)
                let array = DZRecommendUser.mj_objectArrayWithKeyValuesArray(json["list"])
                rcate.users?.removeAllObjects()
                rcate.users?.addObjectsFromArray(array as [AnyObject])
                
                // 保存总数
                rcate.total = json["total"] as? NSNumber
                
                self.userTableView.reloadData() // 刷新数据
                self.userTableView.mj_header.endRefreshing() // 结束刷新
                self.checkFooterState()
            case .Failure( _):
                SVProgressHUD.showErrorWithStatus("加载信息失败")
                self.userTableView.mj_header.endRefreshing() // 结束刷新
            }
        }
    }
    
    // 加载更多数据
    func loadMoreUsers() {
        let cate: DZRecommendCategory = categories[selectedRow()!] as! DZRecommendCategory
        cate.currentPage = Int(cate.currentPage!) + 1
        let param = [
            "a" : "list",
            "c" : "subscribe",
            "category_id" : cate.id!,
            "page" : cate.currentPage!
        ]
    
        Alamofire.request(.GET, "http://api.budejie.com/api/api_open.php", parameters: param, encoding: .URL, headers: nil).responseJSON { (Response) -> Void in
            
            switch Response.result {
            case .Success(let json):
                SVProgressHUD.dismiss()
                let array = DZRecommendUser.mj_objectArrayWithKeyValuesArray(json["list"])
                cate.users?.addObjectsFromArray(array as [AnyObject])
                
                self.userTableView.reloadData() // 刷新数据
                self.checkFooterState()
            case .Failure( _):
                SVProgressHUD.showErrorWithStatus("加载信息失败")
                self.userTableView.mj_footer.endRefreshing() // 结束刷新
            }
        }
    }
}


extension DZRecommendViewController {
    
    /**
     监听footer的状态
     */
    func checkFooterState() {
        if let row = (categoryTableView.indexPathForSelectedRow?.row) { // 使用可选绑定，开始时没有选择行
            let rcate = (categories[row] as? DZRecommendCategory)
            userTableView.mj_footer.hidden = (rcate!.users?.count == 0) ? true : false
            
            if rcate!.count == rcate!.total { // 全部加载完毕
                userTableView.mj_footer.endRefreshingWithNoMoreData()
            } else {
                userTableView.mj_footer.endRefreshing()
            }
        }
    }
}