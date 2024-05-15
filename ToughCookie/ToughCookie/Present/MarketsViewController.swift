//
//  MarketsViewController.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/15/24.
//

import UIKit

class MarketsViewController: BaseViewController<MarketsView> {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "거래소"
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}
