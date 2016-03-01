//
//  DZRecommendTagsViewController.swift
//  baisi
//
//  Created by Other on 16/2/15.
//  Copyright © 2016年 wangyue. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class DZRecommendTagsViewController: UITableViewController {

    lazy var tags: NSArray? = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupTableView()
        logtags()
    }

    let DZTagsID = "tag"
    
    func logtags() {
        SVProgressHUD.showWithMaskType(.Black)
        let param = [
            "a" : "tag_recommend",
            "action" : "sub",
            "c" : "topic"
        ]
        
        Alamofire.request(.GET, "http://api.budejie.com/api/api_open.php", parameters: param, encoding: .URL, headers: nil).responseJSON { (Response) -> Void in
            
            switch Response.result {
            case .Success(let json):
                SVProgressHUD.dismiss()
                
                self.tags = DZRecommendTag.mj_objectArrayWithKeyValuesArray(json)
                self.tableView.reloadData()
                
            case .Failure( _):
                SVProgressHUD.showErrorWithStatus("加载信息失败")
            }
        }
    }
    
    func setupTableView() {
        title = "推荐标签"
        tableView.registerNib(UINib(nibName: "DZRecommendTagCell", bundle: nil), forCellReuseIdentifier: DZTagsID)
        tableView.rowHeight = 70
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.globalColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (tags?.count)!
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(DZTagsID) as! DZRecommendTagCell
       
        cell.recommendTag = tags![indexPath.row] as? DZRecommendTag

        return cell
    }
}
