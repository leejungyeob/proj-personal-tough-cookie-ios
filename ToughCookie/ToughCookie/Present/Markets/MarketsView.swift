//
//  MarketsView.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/15/24.
//

import UIKit

class MarketsView: BaseView {
    
    let tableView = UITableView()
    
    override func configureView() {
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .white
        tableView.separatorInset = .zero
        
        addSubview(tableView)
        
        flexView.flex.define { flex in
            
            flex.addItem().height(10)
            flex.addItem(tableView).grow(1)
        }
    }
}

