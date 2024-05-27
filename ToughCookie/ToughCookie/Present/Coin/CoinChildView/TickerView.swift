//
//  TickerView.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/27/24.
//

import SwiftUI

struct TickerView: View {
    
    var askOrderBook: [OrderBookItem]
    var bidOrderBook: [OrderBookItem]
    var updateMarketData: TickerPresentData
    
    @State var isTradePrice: Bool = false
    
    var body: some View {
        
        HStack {
            ScrollView(.vertical) {
                
                VStack(spacing: 0) {
                    
                    VStack(spacing: 0) {
                        
                        ForEach(askOrderBook, id: \.id) { item in
                            
                            LazyVStack(alignment: .trailing, spacing: 0) {
                                
                                Text(item.price.formatted())
                                    .asDefaultText(fontSize: 13, textColor: .white)
                                
                                Text(item.size.formatted())
                                    .asDefaultText(fontSize: 11, textColor: .white)
                                
                                Divider()
                                    .background(.black)
                            } // LazyVStack
                            .frame(maxWidth: .infinity)
                            .border( isTradePrice(item: item) ? Color.white : Color.clear)
                        } // ForEach
                    }// askOrderBook VStack
                    .background(Color.blue.opacity(0.2))
                    
                    VStack(spacing: 0) {
                        ForEach(bidOrderBook, id: \.id) { item in
                            
                            LazyVStack(alignment: .trailing) {
                                Text(item.price.formatted())
                                    .asDefaultText(fontSize: 13, textColor: .white)
                                
                                Text(item.size.formatted())
                                    .asDefaultText(fontSize: 11, textColor: .white)
                                
                                Divider()
                                    .background(.black)
                            } // LazyVStack
                            .frame(maxWidth: .infinity)
                            .border( isTradePrice(item: item) ? Color.white : Color.clear)
                        } // ForEach
                    } // bidOrderBook VStack
                    .background(Color.red.opacity(0.2))
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.4, alignment: .leading)
            
            Spacer()
        }
    }
    
    func isTradePrice(item: OrderBookItem) -> Bool {
        return item.price == updateMarketData.tradePrice
    }
}
