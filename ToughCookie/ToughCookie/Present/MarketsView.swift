//
//  MarketsView.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/15/24.
//

import UIKit

class MarketsView: BaseView {

    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    override func configureView() {
        
        let customWhite = UIColor.white.withAlphaComponent(0.6)
        
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.searchTextField.leftView?.tintColor = .white
        searchBar.searchTextField.textColor = .white
        searchBar.searchBarStyle = .minimal
        
        if let textfieldBackgroundView = searchBar.searchTextField.subviews.first {
            textfieldBackgroundView.isHidden = true
        }
        
        let placeHolder = "코인명/심볼 검색"
        searchBar.placeholder = placeHolder
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: placeHolder,
                                                                             attributes: [.foregroundColor : customWhite])
        
        
        flexView.flex.define { flex in
            
            flex.addItem(searchBar)
            flex.addItem().width(.infinity).height(3).grow(1).backgroundColor(customWhite)
            flex.addItem().width(.infinity).height(1000).grow(1).backgroundColor(.black)
        }
    }

}
