//
//  WatchConnectibityManager.swift
//  FRC Field Monitor
//
//  Created by Tal Taub on 26/03/2024.
//

import Foundation
import WatchConnectivity

final class WatchConnectivityManager: NSObject, ObservableObject {
    static let shared = WatchConnectivityManager()
    
    @Published var teamData: [TeamData]!
    @Published var matchData: MatchInfo!
    @Published var ahedBehind: String!
    
    private override init() {
        super.init()
        
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    func send(_ message: [String: Any]) {
            guard WCSession.default.activationState == .activated else {
              return
            }
            #if os(iOS)
            guard WCSession.default.isWatchAppInstalled else {
                return
            }
            #else
            guard WCSession.default.isCompanionAppInstalled else {
                return
            }
            #endif
            
            WCSession.default.sendMessage(message, replyHandler: nil) { error in
                print("Cannot send message: \(String(describing: error))")
            }
        }
}

extension WatchConnectivityManager: WCSessionDelegate {
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let teamData = message["teamData"] as? Data {
            DispatchQueue.main.async { [weak self] in
                self?.teamData = TeamDataDTO.decodeIt(teamData).teamData
            }
        }

        if let matchData = message["matchData"] as? Data {
            DispatchQueue.main.async { [weak self] in
                self?.matchData = MatchInfo(matchInfo: MatchAndPlayDTO.decodeIt(matchData).matchAndPlay)
            }
        }
        
        if let ahedBehind = message["ahedBehind"] as? String {
            DispatchQueue.main.async { [weak self] in
                self?.ahedBehind = ahedBehind
            }
        }
    }
    
    func session(_ session: WCSession,
                 activationDidCompleteWith activationState: WCSessionActivationState,
                 error: Error?) {}
    
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {}
    func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
    #endif
}
