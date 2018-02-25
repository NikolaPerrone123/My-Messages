//
//  ContactsViewController.swift
//  My Message
//
//  Created by Nikola Popovic on 2/23/18.
//  Copyright © 2018 Nikola Popovic. All rights reserved.
//

import UIKit
import SVProgressHUD

class ContactsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var users = [UserModel]()
    fileprivate let refreshControl = UIRefreshControl()
    fileprivate let cellIdentifier = "contacntsCellIdentifier"
    fileprivate let contactCellIdentifier = "contactCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getUserFromDB()
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
        self.refreshControl.addTarget(self, action: #selector(ContactsViewController.getUserFromDB), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
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
        let user = users[indexPath.row]
        cell.userImage.image = user.isUserHasImage ? user.image : #imageLiteral(resourceName: "user-128")
        cell.name.text = user.name
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
        let vc = storyboard?.instantiateViewController(withIdentifier: contactInfoVC) as! ContactInfoViewController
        let user = users[indexPath.row]
        vc.user = user
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK - API
    @objc func getUserFromDB(){
        removeArray()
        SVProgressHUD.show()
        FireBaseHelper.sharedInstance.getUsers { (error, users) in
            if error == nil {
                SVProgressHUD.dismiss()
                self.refreshControl.endRefreshing()
                for user in users! {
                    if user.isUserHasImage {
                        SVProgressHUD.show()
                        FireBaseHelper.sharedInstance.downloadImage(imageId: user.email, CompletionHandler: { (image, error) in
                            if error == nil {
                                SVProgressHUD.dismiss()
                                user.image = image!
                                self.users.append(user)
                                self.tableView.reloadData()
                            } else {
                                SVProgressHUD.dismiss()
                                print(error!.localizedDescription)
                            }
                        })
                    } else {
                        self.users.append(user)
                    }
                }
                self.tableView.reloadData()
            } else {
                SVProgressHUD.dismiss()
                self.refreshControl.endRefreshing()
                Utilites.errorAlert(title: "Error", message: error!.localizedDescription, controller: self)
            }
        }
    }
    
    // MARK - Methods
    func removeArray(){
        users.removeAll()
    }
}
