//
//  MediaListVC.swift
//  PracticalTask
//
//  Created by Hitesh Mistri on 8/14/19.
//  Copyright © 2019 Taykun. All rights reserved.
//

import UIKit

class MediaListVC: UIViewController {
    
    internal lazy var theCurrentView : MediaListView = { [unowned self] in
       return self.view as! MediaListView
    }()

    var theModelData:[MediaList] = []
    var mediaType = MediaType.all
    
    lazy var searchBar = UISearchBar(frame: CGRect.zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        theCurrentView.setupLayout()
        theCurrentView.setupTableView(delegate: self)
        getMediaListWebService(strSeachText: "justin")
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
    }


}
//MARK:- UISearchBarDelegate
extension MediaListVC:UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.view.endEditing(true)

    }
}

//MARK:- UITableViewDataSource
extension MediaListVC:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theModelData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! ListCell
        cell.configure(theModel: theModelData[indexPath.row], mediaType: mediaType)
        return cell
    }
}

//MARK:- UITableViewDataSource
extension MediaListVC:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//MARK:- Api Call
extension MediaListVC {
    func getMediaListWebService(strSeachText:String) {
        theCurrentView.setActivity(isStart: true)
        theCurrentView.setMsg(strMsg: "Currently searching,\n please wait", isHidden: false)
        ListWebService.shared.getListofMediaService(endURL: "term=\(strSeachText)&media=\(mediaType.rawValue)", success: { [weak self] (list) in
            self?.theModelData = list
            self?.theCurrentView.setActivity(isStart: false)
            self?.theCurrentView.setMsg(strMsg: "", isHidden: true)
            self?.theCurrentView.tableView.reloadData()
        }, failed: { [weak self] (error) in
            self?.theModelData = []
            self?.theCurrentView.tableView.reloadData()
            self?.theCurrentView.setActivity(isStart: false)
            self?.theCurrentView.setMsg(strMsg: error, isHidden: true)
        })
    }
}
