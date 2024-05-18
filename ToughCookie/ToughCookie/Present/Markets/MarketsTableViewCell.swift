//
//  MarketsTableViewCell.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/16/24.
//

import UIKit

class MarketsTableViewCell: UITableViewCell {
    
    let testLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(testLabel)
        
        contentView.flex.direction(.column).define { flex in
            flex.addItem(testLabel).grow(1).padding(10)
        }
        
        testLabel.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    fileprivate func layout() {
        contentView.flex.layout(mode: .adjustHeight)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        
        contentView.pin.width(size.width)
        contentView.flex.layout(mode: .adjustHeight)
        
        layout()
        
        return contentView.frame.size
    }
}
