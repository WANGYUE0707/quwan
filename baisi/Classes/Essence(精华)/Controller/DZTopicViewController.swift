//
//  DZTopicViewController.swift
//  baisi
//
//  Created by 朱颖宇 on 16/2/18.
//  Copyright © 2016年 wangyue. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh

class DZTopicViewController: UITableViewController {

    lazy var topics: NSMutableArray? = NSMutableArray()
    var maxtime: String?
    var page: Int?
    var topicType: DZTopicType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRefresh()
        setupTableView()
    }
    
    let DZTopicCellID = "topic"
    
    func setupTableView() {
        let bottom = tabBarController?.tabBar.height
        let top = DZTitlesViewY + DZTitlesViewH
        tableView.contentInset = UIEdgeInsets(top: top, left: 0, bottom: bottom!, right: 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
        tableView.backgroundColor = UIColor.clearColor()
        tableView.separatorStyle = .None
        tableView.registerNib(UINib(nibName: "DZTopicCell", bundle: nil), forCellReuseIdentifier: DZTopicCellID)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (topics?.count)!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //        let ID = "cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(DZTopicCellID) as! DZTopicCell
        // 取消cell选中模式
        cell.selectionStyle = .None
        //        if cell == nil {
        //            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: ID)
        //        }
        
        let topic = topics![indexPath.row] as! DZTopic
        cell.topic = topic
        
        return cell
    }
    // TODO: 优化行高的问题需要解决??????使用懒加载 一个cellHeight的属性
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        let topic = topics![indexPath.row] as? DZTopic
        if  (topic != nil) {
//            topic!.cellHeight = 0
            return topic!.cellHeight!
        }
        return 44
        
//        let topic = topics![indexPath.row] as? DZTopic
//        let maxSize = CGSize(width: UIScreen.mainScreen().bounds.size.width - 4.0 * DZTopicCellMargin, height: CGFloat(MAXFLOAT))
//        
//        let textH = (topic!.text! as NSString).boundingRectWithSize(maxSize, options: .UsesLineFragmentOrigin, attributes: [
//            NSFontAttributeName : UIFont.systemFontOfSize(14)
//            ], context: nil).height
//        
//        return DZTopicCellTextY + textH + DZTopicCellBottomBarH + 2 * DZTopicCellMargin
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let vc = DZCommentViewController()
        vc.topic = topics![indexPath.row] as? DZTopic
        navigationController?.pushViewController(vc, animated: true)
        debugPrint(self.navigationController)
//        self.hidesBottomBarWhenPushed = true
    }
}

extension DZTopicViewController {
    
    func setupRefresh() {
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "loadNewTopics")
        tableView.mj_header.automaticallyChangeAlpha = true
        tableView.mj_header.beginRefreshing()
        
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: "loadMoreTopics")
    }
    
    func loadNewTopics() {
        tableView.mj_footer.endRefreshing()
//        debugPrint("============\(topicType?.rawValue)")
//        if let ty = type {
        
        let param = [
            "a" : "list",
            "c" : "data",
            "type" : "\((topicType?.rawValue)!)"
        ]
        
        Alamofire.request(.GET, "http://api.budejie.com/api/api_open.php", parameters: param, encoding: .URL, headers: nil).responseJSON { (Response) -> Void in
            
            switch Response.result {
            case .Success(let json):
                self.maxtime = json["info"]!!["maxtime"] as? String
                debugPrint(json["list"])
                self.topics = DZTopic.mj_objectArrayWithKeyValuesArray(json["list"])
                for topic in self.topics! {
                    if let cmt = (topic as! DZTopic).top_cmt {
                    debugPrint(cmt)
                    }
                }
                
                self.tableView.reloadData()
                
                self.tableView.mj_header.endRefreshing()
                
                // 清空页码
                self.page = 0
                
            case .Failure( _):
                self.tableView.mj_header.endRefreshing()
                debugPrint("错误")
            }
        }
//    }
    }
    
    func loadMoreTopics() {
        tableView.mj_header.endRefreshing()
        page!++
        
        let param = [
            "a" : "list",
            "c" : "data",
            "type" : "\((topicType?.rawValue)!)",
            "page" : NSValue(nonretainedObject: page),
            "maxtime" : maxtime!
        ]
        
        Alamofire.request(.GET, "http://api.budejie.com/api/api_open.php", parameters: param, encoding: .URL, headers: nil).responseJSON { (Response) -> Void in
            
            switch Response.result {
            case .Success(let json):
                self.maxtime = json["info"]!!["maxtime"] as? String
                
                let newTopics = DZTopic.mj_objectArrayWithKeyValuesArray(json["list"])
                self.topics?.addObjectsFromArray(newTopics as [AnyObject])
                
                self.tableView.reloadData()
                
                self.tableView.mj_header.endRefreshing()
                
                // 恢复页码
                self.page!--
                
            case .Failure( _):
                self.tableView.mj_header.endRefreshing()
                debugPrint("错误")
            }
        }
    }

}
