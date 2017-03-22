//
//  CXSwiftTableViewCell.swift
//  CXTableView
//
//  Created by xiaoma on 17/3/22.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class CXSwiftTableViewCell: UITableViewCell {
    override func awakeFromNib() {
    }
    
    func loadData(){    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        for control in self.subviews {
            if control.isMember(of: NSClassFromString("UITableViewCellEditControl")!) {
                for view in control.subviews {
                    if view.isKind(of: UIImageView.self) {
                        let img = view as! UIImageView
                        
                        if self.isSelected == false {
                            img.image = UIImage(named: "select-off")
                        }
                    }
                }
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //遍历子视图，找出按钮
        for subView in self.subviews {
            if subView.isKind(of: NSClassFromString("UITableViewCellDeleteConfirmationView")!) {
                
                for view in subView.subviews {
                    if view.isKind(of: UIButton.self) {
                        let button = view as! UIButton
                        button.setTitle(nil, for: .normal)
                        if button.titleLabel?.text == "编辑"{
                            button.setImage(UIImage(named: "edit"), for: .normal)
                        } else {
                            button.setImage(UIImage(named: "delete"), for: .normal)
                        }
                    }
                }
            } else if subView.isKind(of: NSClassFromString("UITableViewCellEditControl")!) {
                for view in subView.subviews {
                    if view.isKind(of: UIImageView.self) {
                        let imageView = view as! UIImageView
                        
                        if self.isSelected == true {
                            imageView.image = UIImage(named: "select-on")
                        } else {
                            imageView.image = UIImage(named: "select-off")
                        }
                    }
                }
            }
        }
    }
}
