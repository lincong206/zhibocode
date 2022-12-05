//
//  HomeViewController.swift
//  zhiboTV
//
//  Created by 林聪 on 2022/12/5.
//  Copyright © 2022 Lynn. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {

lazy var tableView: UITableView = UITableView()

static let cellID = "homeCell"
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        setUpUI()
    }
    
    func setUpUI() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: HomeViewController.self.cellID)
        
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: HomeViewController.self.cellID)
        }
        
        cell?.textLabel?.text = "this is rows"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
