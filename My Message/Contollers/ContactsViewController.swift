//
//  ContactsViewController.swift
//  My Message
//
//  Created by Nikola Popovic on 2/23/18.
//  Copyright © 2018 Nikola Popovic. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var users = [UserModel]()
    fileprivate let cellIdentifier = "contacntsCellIdentifier"
    fileprivate let contactCellIdentifier = "contactCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        for user in 0 ... 10 {
            users.append(UserModel(name: "Pera", surname: "Peric", userName: "<#T##String#>", email: "<#T##String#>"))
        }
        setViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK - SetViews
    func setViews(){
        setTable()
    }
    
    func setTable(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 100
        self.tableView.estimatedSectionHeaderHeight = 100
        self.tableView.register(UINib.init(nibName: "ContactsTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.tableView.register(UINib.init(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: contactCellIdentifier)
        self.tableView.separatorColor = UIColor.black
    }
    
    // MARK - TableView Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ContactsTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: contactCellIdentifier) as! ContactTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // MARK - TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: contactInfoVC)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
