//
//  CoinView.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/26/24.
//

import SwiftUI

struct CoinView: View {
    
    @StateObject
    var viewModel: CoinViewModel
    
    var body: some View {
        
        HStack {
            ScrollView {
                ForEach(viewModel.askOrderBook, id: \.id) { item in
                    HStack {
                        Text(item.price.formatted())
                            .font(.system(size: 13))
                            .foregroundStyle(Color.white)
                        
                        Text(item.size.formatted())
                            .font(.system(size: 13))
                            .foregroundStyle(Color.white)
                    }
                }
                .background(Color.blue.opacity(0.2))
                
                ForEach(viewModel.bidOrderBook, id: \.id) { item in
                    HStack {
                        Text(item.price.formatted())
                            .font(.system(size: 13))
                            .foregroundStyle(Color.white)
                        
                        Text(item.size.formatted())
                            .font(.system(size: 13))
                            .foregroundStyle(Color.white)
                    }
                }
                .background(Color.red.opacity(0.2))
            }
            .background(Color.subBlue)
            .frame(width: UIScreen.main.bounds.width * 0.4, alignment: .leading)
            
            Spacer()
        }
        .onAppear {
            viewModel.connect()
        }
    }
}
