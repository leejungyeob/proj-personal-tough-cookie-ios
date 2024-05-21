//
//  TickerSection.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/21/24.
//

import Foundation
import RxDataSources

struct TickerSection {
    
    var items: [Item]
}

extension TickerSection: SectionModelType {
    
    typealias Item = TickerData
    
    init(original: TickerSection, items: [Item]) {
        self = original
        self.items = items
    }
}
