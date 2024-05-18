//
//  MarketsViewController.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/15/24.
//

import UIKit

class MarketsViewController: BaseViewController<MarketsView> {
    
    var total: [Int] = [1,2,3,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]
    var a = 3
    
    override func configureView() {
        
        layoutView.tableView.dataSource = self
        layoutView.tableView.delegate = self
        layoutView.tableView.register(MarketsTableViewCell.self, forCellReuseIdentifier: "cell")
        
        let header = MarketsHeaderView()
        header.backgroundColor = .clear
        
        layoutView.tableView.tableHeaderView = header
    }
}


extension MarketsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return total.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MarketsTableViewCell else { return UITableViewCell() }
        
        cell.testLabel.text = "\(total[indexPath.row])"
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
             
        return UITableView.automaticDimension
    }
}
