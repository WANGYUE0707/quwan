//
//  DZCommentViewController.swift
//  baisi
//
//  Created by 朱颖宇 on 16/2/27.
//  Copyright © 2016年 wangyue. All rights reserved.
//

import UIKit
import MJRefresh
import Alamofire
import SVProgressHUD
import MJExtension

class DZCommentViewController: UIViewController {

    var topic: DZTopic?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomSpace: NSLayoutConstraint!
    // 热门评论
    lazy var hotComments: [AnyObject]? = [AnyObject]()
    // 最新评论
    lazy var lastestComments: [AnyObject]? = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBase()
        setupHeader()
        setupRefresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension DZCommentViewController {
    
    func setupBase() {
        title = "评论"
        navigationItem.rightBarButtonItem = UIBarButtonItem.item(nil, target: nil, imageName: "comment_nav_item_share_icon_click", highlightedImageName: "comment_nav_item_share_icon_click")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        tableView.backgroundColor = UIColor.globalColor()
        
        // FIXME: 为什么会这样??? 已解决....这是第一个????
        // 与添加的顺序有关,在xib中将tableview的添加顺序改成最上面也能解决这个问题
//        automaticallyAdjustsScrollViewInsets = false
//        tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
    }
    
    func setupHeader() {
        let header = UIView()
        let cell = DZTopicCell.cellFromNib()
        cell.topic = topic
        cell.size = CGSize(width: UIScreen.width, height: topic!.cellHeight!)
        header.height = CGFloat((topic?.cellHeight)!) + DZTopicCellMargin
        header.addSubview(cell)
        tableView.tableHeaderView = header
    }
    
    func setupRefresh() {
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "loadNewComments")
        tableView.mj_header.beginRefreshing()
    }
    
    func loadNewComments() {
        let params = [
            "a" : "dataList",
            "c" : "comment",
            "data_id" : (topic?.id)!,
            "hot" : "1"
        ]
        
        Alamofire.request(.GET, "http://api.budejie.com/api/api_open.php", parameters: params, encoding: .URL, headers: nil).responseJSON { (Response) -> Void in
            
            switch Response.result {
            case .Success(let json):
                
                debugPrint(json)
                
                self.hotComments = DZComment.mj_objectArrayWithKeyValuesArray(json["hot"]) as [AnyObject]
                self.lastestComments = DZComment.mj_objectArrayWithKeyValuesArray(json["data"]) as [AnyObject]
                
                self.tableView.reloadData()
                self.tableView.mj_header.endRefreshing()
                
            case .Failure( _):
                self.tableView.mj_header.endRefreshing()
            }
        }
    }
    
    // 监听键盘,改变底部状态栏
    func keyboardWillChangeFrame(noto: NSNotification) {
        let frame = noto.userInfo![UIKeyboardFrameEndUserInfoKey]?.CGRectValue
        // 修改约束
        bottomSpace.constant = UIScreen.height - (frame?.origin.y)!
        
        let duration = noto.userInfo![UIKeyboardAnimationDurationUserInfoKey]?.doubleValue
        UIView.animateWithDuration(duration!) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
}

extension DZCommentViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let hotCount = hotComments?.count
        let lastestCount = lastestComments?.count
        
        if hotCount != 0 {
            return 2
        }
        if lastestCount != 0 {
            return 1
        }
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let hotCount = hotComments?.count
        let lastestCount = lastestComments?.count
        
        if section == 0 {
            return (hotCount != 0 ? hotCount : lastestCount)!
        }
        
        return lastestCount!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let id = "comment"
        var cell = tableView.dequeueReusableCellWithIdentifier(id)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: id)
        }
        let comment = commentInIndexPath(indexPath)
        cell?.textLabel?.text = comment.content
        cell?.selectionStyle = .None
        return cell!
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let hotCount = hotComments?.count
        if section == 0 {
            return hotCount != 0 ? "最热评论" : "最新评论"
        }
        return "最新评论"
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
}

// 数据处理
extension DZCommentViewController {
    // 返回section的数据
    func commentsInSection(section: Int) -> [AnyObject]? {
        if section == 0 {
            return (hotComments?.count) != 0 ? hotComments : lastestComments
        }
        return lastestComments
    }
    
    func commentInIndexPath(indexPath: NSIndexPath) -> DZComment {
        return commentsInSection(indexPath.section)![indexPath.row] as! DZComment
    }
}