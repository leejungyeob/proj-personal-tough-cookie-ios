//
//  MarketsTableViewCell.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/16/24.
//

import UIKit
import FlexLayout
import PinLayout

class MarketsTableViewCell: UITableViewCell {
    
    let testLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        testLabel.textColor = .white
        
        contentView.addSubview(testLabel)
        
        contentView.flex.direction(.column).define { flex in
            flex.addItem(testLabel).grow(1).padding(10)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        testLabel.text = ""
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.pin.all(contentView.pin.safeArea)
        contentView.flex.layout(mode: .adjustHeight)
    }
}
