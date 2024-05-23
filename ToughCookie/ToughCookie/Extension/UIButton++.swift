//
//  UIButton++.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/23/24.
//

import UIKit

extension UIButton {
    
    func sectionTitleButtion(title: String, image: UIImage?) {
        
        var buttonConfiguration = UIButton.Configuration.plain()
        
        buttonConfiguration.image = image?.withTintColor(.white, renderingMode: .alwaysOriginal)
        buttonConfiguration.imagePadding = 3
        buttonConfiguration.title = title
        buttonConfiguration.baseForegroundColor = .white
        buttonConfiguration.imagePlacement = .trailing
        buttonConfiguration.titleAlignment = .leading
        buttonConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        var titleAttribute = AttributeContainer()
        titleAttribute.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        buttonConfiguration.attributedTitle = AttributedString(title, attributes: titleAttribute)
        
        self.configuration = buttonConfiguration
    }
}
