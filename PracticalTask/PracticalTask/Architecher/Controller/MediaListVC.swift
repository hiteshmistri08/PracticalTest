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
    
    lazy var searchBar = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        theCurrentView.setupLayout()
        theCurrentView.setupTableView(delegate: self)
        
        searchBar.searchBar.delegate = self
        searchBar.searchBar.placeholder = "Search"
        searchBar.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true
        searchBar.searchBar.tintColor = UIColor.init(hexString: "#84487A")
        self.navigationItem.searchController = searchBar
        
        let segment: UISegmentedControl = UISegmentedControl(items: ["All", "Movie","Music","Music Video","tvShow"])
        segment.sizeToFit()
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(segmentSelected(_:)), for: .valueChanged)
        self.navigationItem.titleView = segment
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)


    }
    
    @objc func segmentSelected(_ segment:UISegmentedControl) {
        print("segment",segment.selectedSegmentIndex)
        switch segment.selectedSegmentIndex {
        case 1:
           mediaType = .movie
            break
        case 2:
            mediaType = .music
            break
        case 3:
            mediaType = .musicVideo
        case 4:
            mediaType = .tvShow
        default:
            mediaType = .all
            break
        }
        getMediaListWebService(strSeachText: searchBar.searchBar.text ?? "")
    }

}
//MARK:- UISearchControllerDelegate
extension MediaListVC:UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.dismiss(animated: true, completion: nil)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            getMediaListWebService(strSeachText: searchText)
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchText = searchBar.text
        searchBar.resignFirstResponder()
        self.searchBar.dismiss(animated: true, completion: nil)
        
        
        if searchText != nil,!searchText!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            getMediaListWebService(strSeachText: searchText!)
        }
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
        WebService().stopAllSessions()
        theModelData.removeAll()
        theCurrentView.tableView.reloadData()
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
            self?.theCurrentView.setMsg(strMsg: error, isHidden: false)
        })
    }
}
