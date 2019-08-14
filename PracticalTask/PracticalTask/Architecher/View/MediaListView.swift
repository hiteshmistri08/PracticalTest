//
//  MediaListView.swift
//  PracticalTask
//
//  Created by Hitesh Mistri on 8/14/19.
//  Copyright © 2019 Taykun. All rights reserved.
//

import UIKit

class MediaListView: UIView {

    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    func setupLayout()  {
        setMsg(strMsg: "Please, enter a search term", isHidden: false)
    }
    
    func setupTableView(delegate:MediaListVC) {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(UINib.init(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: "ListCell")
        tableView.delegate = delegate
        tableView.dataSource = delegate
    }

    func setActivity(isStart:Bool) {
        if isStart {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func setMsg(strMsg:String,isHidden:Bool) {
        lblMsg.text = strMsg
        lblMsg.isHidden = isHidden
    }
}
