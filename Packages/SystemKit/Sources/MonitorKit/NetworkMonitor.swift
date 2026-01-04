//
//  NewtorkMonitor.swift
//  SystemKit
//
//  Created by Adam Cseke on 2026. 01. 04..
//

import Foundation
import Network

public protocol NetworkMonitorProtocol {
    func startMonitoring()
    func stopMonitoring()
    var isConnected: Bool { get }
    var connectionType: NetworkMonitor.ConnectionType { get }
}

@Observable
public final class NetworkMonitor: NetworkMonitorProtocol, @unchecked Sendable {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    public private(set) var isConnected = true
    public private(set) var connectionType: ConnectionType = .unknown
    
    public enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    public init() {
        startMonitoring()
    }
    
    public func startMonitoring() {
        let currentPath = monitor.currentPath
        Task { @MainActor in
            self.isConnected = currentPath.status == .satisfied
            self.updateConnectionType(currentPath)
        }
        
        monitor.pathUpdateHandler = { [weak self] path in
            Task { @MainActor in
                guard let self = self else { return }
                self.isConnected = path.status == .satisfied
                self.updateConnectionType(path)
            }
        }
        monitor.start(queue: queue)
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
    
    private func updateConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        } else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        } else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
        } else {
            connectionType = .unknown
        }
    }
}
