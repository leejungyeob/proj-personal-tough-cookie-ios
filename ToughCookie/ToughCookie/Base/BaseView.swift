//
//  BaseView.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/14/24.
//

import UIKit
import FlexLayout
import PinLayout

class BaseView: UIView {

    let contentView = UIScrollView()
    let flexView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        
        contentView.addSubview(flexView)
        
        addSubview(contentView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func layoutSubviews() {
        
        contentView.pin.all(pin.safeArea)
        flexView.pin.top().horizontally()
        
        flexView.flex.layout(mode: .adjustHeight)
        
        contentView.contentSize = flexView.frame.size
    }
    
    func configureView() { }
}
