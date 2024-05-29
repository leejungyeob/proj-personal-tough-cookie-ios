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
                                    .asDefaultText(fontSize: 13, textColor: .red)
                                    .padding(EdgeInsets(top: 3, leading: 0, bottom: 1, trailing: 3))
                                
                                Text(item.size.formatted())
                                    .asDefaultText(fontSize: 11, textColor: .black)
                                    .padding(EdgeInsets(top: 1, leading: 0, bottom: 3, trailing: 3))
                                
                                Divider()
                                    .foregroundStyle(Color.white)
                            } // LazyVStack
                            .frame(maxWidth: .infinity)
                            .border( isTradePrice(item: item) ? Color.black : Color.clear)
                        } // ForEach
                    }// askOrderBook VStack
                    .background(Color.blue.opacity(0.2))
                    
                    VStack(spacing: 0) {
                        ForEach(bidOrderBook, id: \.id) { item in
                            
                            LazyVStack(alignment: .trailing, spacing: 0) {
                                
                                Text(item.price.formatted())
                                    .asDefaultText(fontSize: 13, textColor: .blue)
                                    .padding(EdgeInsets(top: 3, leading: 0, bottom: 1, trailing: 3))
                                
                                Text(item.size.formatted())
                                    .asDefaultText(fontSize: 11, textColor: .black)
                                    .padding(EdgeInsets(top: 1, leading: 0, bottom: 3, trailing: 3))
                                
                                Divider()
                                    .background(Color.white)
                            } // LazyVStack
                            .frame(maxWidth: .infinity)
                            .border( isTradePrice(item: item) ? Color.black : Color.clear)
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
