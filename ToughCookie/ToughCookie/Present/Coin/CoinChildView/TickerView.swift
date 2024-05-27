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
    
    var body: some View {
         
        HStack {
            ScrollView(.vertical) {
                
                VStack(spacing: 0) {
                    
                    VStack(spacing: 0) {
                        ForEach(askOrderBook, id: \.id) { item in
                            
                            LazyVStack(alignment: .trailing) {
                                
                                Text(item.price.formatted())
                                    .asDefaultText(fontSize: 13, textColor: .white)
                                
                                Text(item.size.formatted())
                                    .asDefaultText(fontSize: 13, textColor: .white)
                                
                                Divider()
                                    .background(.white)
                            } // LazyVStack
                            .frame(maxWidth: .infinity)
                        } // ForEach
                    }// askOrderBook VStack
                    .background(Color.blue.opacity(0.2))
                    
                    VStack(spacing: 0) {
                        ForEach(bidOrderBook, id: \.id) { item in
                            
                            LazyVStack(alignment: .trailing) {
                                Text(item.price.formatted())
                                    .asDefaultText(fontSize: 13, textColor: .white)
                                
                                Text(item.size.formatted())
                                    .asDefaultText(fontSize: 13, textColor: .white)
                                
                                Divider()
                                    .background(.white)
                            } // LazyVStack
                            .frame(maxWidth: .infinity)
                        } // ForEach
                    } // bidOrderBook VStack
                    .background(Color.red.opacity(0.2))
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.4, alignment: .leading)
            
            Spacer()
        }
    }
}
