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
    
    let flexView = UIView()
    let searchBar = UISearchBar()
    let lineLine = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        flexView.backgroundColor = .clear
        lineLine.backgroundColor = .mainBlue
        
        let customWhite = UIColor.white.withAlphaComponent(0.6)
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.searchTextField.leftView?.tintColor = .mainBlue
        searchBar.searchTextField.font = .systemFont(ofSize: 15, weight: .light)
        searchBar.searchTextField.textColor = .mainBlue
        searchBar.searchBarStyle = .minimal
        
        if let textfieldBackgroundView = searchBar.searchTextField.subviews.first {
            textfieldBackgroundView.isHidden = true
        }
        
        let placeHolder = "코인명/심볼 검색"
        searchBar.placeholder = placeHolder
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: placeHolder,
                                                                             attributes: [.foregroundColor : UIColor.mainBlue])
        
        addSubview(flexView)
        flexView.addSubview(searchBar)
        flexView.addSubview(lineLine)
        
        flexView.flex.direction(.column).define { flex in
            
            flex.addItem(searchBar)
            
            flex.addItem(lineLine)
                // .width(100%)
                .height(1)
                .backgroundColor(.mainBlue)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        flexView.pin.all()
        flexView.flex.layout()
    }
}
