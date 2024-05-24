//
//  BaseViewController.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/14/24.
//

import UIKit
import RxSwift

class BaseViewController<LayoutView: UIView>: UIViewController {
    
    let disposeBag = DisposeBag()

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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.layoutView.endEditing(true)
    }
    
    func configureView() { }
    
    func configureTableView() { }
    
    func configureCollectionView() { }
    
    func bind() { }
}
