//
//  MarketsHeaderView.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/16/24.
//

import UIKit
import FlexLayout
import PinLayout

class MarketsHeaderView: UIView {
    
    let searchBar = UISearchBar()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        
        self.flex.define { flex in
            flex.addItem(searchBar)
        }
        
        addSubview(searchBar)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        searchBar.pin.all()
        self.flex.layout(mode: .adjustHeight)
    }
}
