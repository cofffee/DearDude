//
//  EntryViewController.swift
//  DearDude
//
//  Created by Kevin Remigio on 7/24/17.
//  Copyright © 2017 Kevin Remigio. All rights reserved.
//

import Foundation
import UIKit

class EntryViewController: UIViewController {
    
    var entryDictionary:Dictionary = [String: String]()
    
    var entryTable: UITableView? = nil
    var bgView: UIImageView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red.withAlphaComponent(0.2)
        let bgFrame:CGRect = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        bgView = UIImageView(frame: bgFrame)
        bgView?.image = UIImage(named: "b")
        bgView?.contentMode = .scaleAspectFill
        view.addSubview(bgView!)
        
        createTable()

    }
    func handleSwipe(gestureRecognizer: UIPanGestureRecognizer) {
        print("hello dude")
        self.dismissDetail()
        
    }
    func createTable() {
        let tableFrame = CGRect(x: 20, y: 40, width: view.frame.width - 40 , height: view.frame.height - 80)
        entryTable = UITableView(frame: tableFrame)
        entryTable?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        entryTable?.delegate = self as? UITableViewDelegate
        entryTable?.dataSource = self as? UITableViewDataSource
        view.addSubview(entryTable!)
        
        entryTable?.backgroundColor = UIColor.clear
        entryTable?.layer.cornerRadius = 5
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe(gestureRecognizer:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        entryTable?.addGestureRecognizer(swipeLeft)
    
    }
}
extension EntryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //# OF ROWS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 30
        
    }
    
    //CELLS!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UITableViewCell {
//            return cell
//        }
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "EEEE, MMMM d, yyyy" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = "\(strDate)"
        cell.textLabel?.font = UIFont(name: "Helvetica", size: 16)
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.8)
//        cell.layer.cornerRadius = 5
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    //CELL HEIGHT!
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    //HMM SECTIONS!
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        
//        return view.frame.height
//    }
//    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
//        return view.frame.height
//    }
    //HEADER
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//        let topViewFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
//        return UIView()
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("do something")
        
    }

    
    //footer!!
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let aViewFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: 0.0)
        let footerView = UIView(frame: aViewFrame)
        footerView.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        return footerView
    }
    
}
