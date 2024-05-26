//
//  CoinViewController.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/26/24.
//

import UIKit
import SwiftUI

class CoinViewController: UIHostingController<CoinView> {
    
    let viewModel: CoinViewModel
    
    init(rootView: CoinView, viewModel: CoinViewModel) {
        self.viewModel = viewModel
        
        super.init(rootView: rootView)
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
