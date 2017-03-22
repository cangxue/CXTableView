//
//  CXSwiftTableViewController.swift
//  CXTableView
//
//  Created by xiaoma on 17/3/22.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class CXSwiftTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //表格视图
    
    var mainTableView = UITableView()
    
    //数据源
    var showArrays = NSMutableArray()
    
    //删除数组
    var deleteArrays = NSMutableArray()
    
    
    //编辑按钮
    var editItem = UIBarButtonItem()
    
    //全选按钮
    var selectItem = UIBarButtonItem()
    
    //是否点击了全选
    var selectFlag = false
    
    //是否点击了编辑／删除
    var editFlag = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Swift-CXTableView"
        
        self.setupShowArraysData()
        self.setupTableView()
        self.setupBarButtonItems()
    }
    
    // MARK: -UITableViewDataSource/Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showArrays.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID") as! CXSwiftTableViewCell
        
        cell.textLabel?.text = showArrays[indexPath.row] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75;
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "编辑") { (action, indexPatch) in
            tableView.isEditing = false
        }
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "删除") { (action, indexPatch) in
            self.showArrays.removeObject(at: indexPath.row)
            tableView.reloadData()
        }
        
        return [editAction, deleteAction]
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        deleteArrays.add(showArrays[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let showStr = showArrays[indexPath.row]
        
        deleteArrays.remove(showStr)
        
        print();
    }
    
    // MARK: -button Action
    func editItemAction() {

        editFlag = !editFlag
        
        if editFlag {
            self.mainTableView.allowsMultipleSelectionDuringEditing = true
            
            self.mainTableView.isEditing = true
            
            editItem.title = "删除"
            
            self.navigationItem.rightBarButtonItems = [editItem, selectItem]
        } else {
            self.mainTableView.isEditing = false
            
            editItem.title = "编辑"

            self.navigationItem.rightBarButtonItems = [editItem]
            
            for deleteStr in deleteArrays {
                showArrays.remove(deleteStr)
            }
            
            deleteArrays.removeAllObjects()
            
            mainTableView.reloadData()
        }
    }
    
    
    func selectItemAction() {
        
        selectFlag = !selectFlag
        
        if selectFlag {
            selectItem.title = "全不选"
            
            for i in 0...showArrays.count {
                let indexPatch = NSIndexPath(item: i, section: 0)
                
                self.mainTableView.selectRow(at: indexPatch as IndexPath, animated: true, scrollPosition: .none)
                
            }
            
            deleteArrays = showArrays.mutableCopy() as! NSMutableArray
            
        } else {
            selectItem.title = "全选"
            
            self.mainTableView.selectRow(at: nil, animated: true, scrollPosition: .none)
            
            deleteArrays.removeAllObjects()
        }
        
        self.navigationItem.rightBarButtonItems = [editItem, selectItem]
        
    }
    
    // MARK:-setup
    func setupTableView() {
        mainTableView = UITableView(frame: self.view.bounds, style: .plain)
        self.view.insertSubview(mainTableView, at: 0)
        
        mainTableView.delegate = self;
        mainTableView.dataSource = self;
        
        mainTableView.register(CXSwiftTableViewCell.self, forCellReuseIdentifier: "CellID")
        
    }
    
    func setupShowArraysData() {
        for i in 0...40 {
            showArrays.add("这是第\(i)行数据")
        }
    }
    
    func setupBarButtonItems() {
        editItem = UIBarButtonItem(title: "编辑", style: .plain, target: self, action: #selector(editItemAction))
        selectItem = UIBarButtonItem(title: "全选", style: .plain, target: self, action: #selector(selectItemAction))
        
        self.navigationItem.rightBarButtonItems = [editItem]
    }
}
