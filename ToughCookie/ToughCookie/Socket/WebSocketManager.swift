//
//  WebSocketManager.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/20/24.
//

import Foundation
import Starscream

class WebSocketManager {
    
    static let shared = WebSocketManager()
    
    private let websocket: WebSocket
    
    private init() {
        
        let baseURL: URL = URL(string: "wss://api.upbit.com/websocket/v1")!
        let request = URLRequest(url: baseURL)
        
        websocket = WebSocket(request: request)
        websocket.delegate = self
    }
}

extension WebSocketManager {
    
    func connect() -> WebSocket {
        websocket.connect()
        return websocket
    }
    
    func disconnect() {
        websocket.disconnect()
    }
    
    func send(_ jsonStr: String) {
        
        if let data = jsonStr.data(using: .utf8) {
            websocket.write(data: data)
        }
    }
}

extension WebSocketManager: WebSocketDelegate {
    
    func didReceive(event: Starscream.WebSocketEvent, client: any Starscream.WebSocketClient) {
        
        switch event {
        case .connected(let headers):
            print("websocket is connected: \(headers)")
            
        case .disconnected(let reason, let code):
            print("websocket is disconnected: \(reason) with code: \(code)")
            
        default: return
        }
    }
}
