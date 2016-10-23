//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Chau Vo on 10/17/16.
//  Copyright © 2016 CoderSchool. All rights reserved.
//

import UIKit
import MBProgressHUD

class BusinessesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noticeLabel: UILabel!
  
    var businesses: [Business]!
    var searchBar: UISearchBar!
    var loadingView:UIActivityIndicatorView!
    var tableViewFooter: UIView!
    
    var totalResult: Int = 0
    var isMoreDataLoading = false
    var filters = [String : AnyObject]()
    let meterConst: Float = 1609.344
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initControls()
        
        doSearch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadingView.isHidden = true
        loadingView.stopAnimating()
        isMoreDataLoading = false
    }
    
    func  initControls() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        tableView.separatorColor = UIColor(red: 230/255, green: 170/255, blue: 170/255, alpha: 1)
        
        noticeLabel.isHidden = true
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        searchBar = UISearchBar()
        searchBar.delegate = self;
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        tableViewFooter = UIView(frame: CGRect(x: 0, y: 0, width: tableView.superview!.frame.width, height: 50))
        loadingView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        loadingView.isHidden = true
        loadingView.stopAnimating()
        loadingView.center = tableViewFooter.center
        
        tableViewFooter.addSubview(loadingView)
        tableView.tableFooterView = tableViewFooter
    }

    func doSearch() {
        self.noticeLabel.isHidden = true
        var term: String! = ""
        if !searchBar.text!.isEmpty {
            term = searchBar.text
        }
        var sort: YelpSortMode! = YelpSortMode.bestMatched
        if self.filters["sort"] != nil {
            sort = self.getModSortBy(value: self.filters["sort"] as! Int)
        }
        let categories = self.filters["categories"] as? [String]
        let deal = self.filters["deal"] as? Bool
        var radius = self.filters["radius"] as! Float?
        if radius != nil {
            radius = radius! * meterConst
        }
        var offset = 0
        if businesses != nil {
            offset = businesses.count
        } else {
            self.businesses = [Business]()
        }
        print("call search API")
        Business.search(with: term!, sort: sort, categories: categories, deals: deal,radius: radius, offset: offset) { (result: SearchResult?, error: Error?) -> Void in
            if result != nil {
                self.totalResult = (result?.total!)!
                self.isMoreDataLoading = self.totalResult == 0
                if offset < (result?.total!)! {
                    for b in (result?.businesses)! {
                        self.businesses.append(b)
                    }
                }
                self.tableView.reloadData()
                self.loadingView.isHidden = true
                self.loadingView.stopAnimating()
                if self.totalResult == 0 {
                    self.noticeLabel.isHidden = false
                }
            } else {
                self.tableView.reloadData()
                self.totalResult = 0
                self.businesses = [Business]()
                self.isMoreDataLoading = true
            }
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func getModSortBy(value: Int) -> YelpSortMode {
        switch value {
        case 0:
            return YelpSortMode.bestMatched
        case 1:
            return YelpSortMode.distance
        case 2:
            return YelpSortMode.highestRated
        default:
            return YelpSortMode.bestMatched
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        
        if navigationController.topViewController is FiltersViewController {
            let filtersViewController = navigationController.topViewController as! FiltersViewController
            filtersViewController.delegate = self
        }
    }
}

extension BusinessesViewController: UISearchBarDelegate {
  
  func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
    searchBar.setShowsCancelButton(true, animated: true)
    return true
  }
  
  func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
    searchBar.setShowsCancelButton(false, animated: true)
    return true
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.text = ""
    searchBar.resignFirstResponder()
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    businesses.removeAll(keepingCapacity: false)
    tableView.reloadData()
    doSearch()
  }
}

extension BusinessesViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return businesses?.count ?? 0
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell") as! BusinessCell
    if self.businesses[indexPath.row] != nil {
        cell.business = self.businesses[indexPath.row]
    }
    
    //separator fullwidth
    cell.layoutMargins = UIEdgeInsets.zero
    cell.preservesSuperviewLayoutMargins = false
    cell.separatorInset = UIEdgeInsets.zero
    return cell;
  }
    
}

extension BusinessesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !isMoreDataLoading {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                isMoreDataLoading = true
                loadingView.startAnimating()
                doSearch()
            }
        }
    }
}

extension BusinessesViewController: FiltersViewControllerDelegate {
    func filtersViewController(filtersViewController: FiltersViewController, didChangeValue filters: [String : AnyObject]) {
        print("filter did changed: \(filters)")
        
        self.businesses = [Business]()
        
        let deal = filters["deal"] as? Bool
        var sortValue = filters["sort"] as? Int
        if sortValue == nil {
            sortValue = 1
        }
        
        let categories = filters["categories"] as? [String]
        let radius = filters["radius"] as! Float?
        
        // Set filters in this view controller
        self.filters["deal"] = deal as AnyObject?
        self.filters["sort"] = sortValue! as AnyObject?
        self.filters["categories"] = categories as AnyObject?
        self.filters["radius"] = radius as AnyObject?
        
        doSearch()
    }
}
