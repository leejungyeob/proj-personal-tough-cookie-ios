//
//  BaseViewController.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/14/24.
//

import UIKit

class BaseViewController<LayoutView: UIView>: UIViewController {

    var layoutView: LayoutView {
        return view as! LayoutView
    }
    
    override func loadView() {
        self.view = LayoutView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureTableView()
        configureCollectionView()
        bind()
    }
    
    func configureView() { }
    
    func configureTableView() { }
    
    func configureCollectionView() { }
    
    func bind() { }
}
