//
//  LaunchView.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/18/24.
//

import UIKit
import PinLayout
import FlexLayout

class LaunchView: BaseView {
    
    let logoImageView = UIImageView()
    let indicator = UIActivityIndicatorView(style: .medium)
    
    override func configureView() {
        
        backgroundColor = .mainBlue
        flexView.backgroundColor = .mainBlue
        
        addSubview(logoImageView)
        addSubview(indicator)
        
        logoImageView.image = UIImage.icon
        indicator.color = .white
        
        flexView.flex.justifyContent(.center).define { flex in
            
            flex.addItem().size(indicator.bounds.size).marginBottom(10)
            
            flex.addItem(logoImageView)
                .marginHorizontal(70)
                .aspectRatio(of: logoImageView)
            
            flex.addItem(indicator).marginTop(10)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        flexView.pin.all()
        flexView.flex.layout()
    }
}
