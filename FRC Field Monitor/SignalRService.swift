//
//  SignalRService.swift
//  testapp Watch App
//
//  Created by Tal Taub on 25/03/2024.
//

import Foundation
import SwiftUI
import SwiftSignalRClient
import WatchConnectivity
import BackgroundTasks


public class SignalRService {
    private var connection: HubConnection!
    
    init() {
            let connectionURL = URL(string: "http://\(K.connection.BASE_URL)/fieldMonitorHub")!
            self.connection = HubConnectionBuilder(url: connectionURL).withAutoReconnect().withLogging(minLogLevel: .error).build()
            
            self.connection.on(method: "FieldMonitorDataChanged", callback: { (payload: ArgumentExtractor) in
                do{
                    print("data is here")
                    let data = try payload.getArgument(type: [TeamData].self)
                    self.onTeamDataUpdate(message: data)
                } catch {
                    print(error)
                }
            })
            
            self.connection.on(method: "MatchStatusInfoChanged", callback: { (status: MatchAndPlay) in
                self.onMatchInfoChanged(message: status)
            })
            
            self.connection.on(method: "ScheduleAheadBehindChanged", callback: { (status: String) in
                self.onMatchScheduleChange(message: status)
            })
            
            self.connection.start()    
    }
    
    func update(){
        
    }
    
    private func onTeamDataUpdate(message: [TeamData]) {
        WatchConnectivityManager.shared.send(["teamData": TeamDataDTO(teamData: message).encodeIt()])
    }
    
    private func onMatchInfoChanged(message: MatchAndPlay){
        WatchConnectivityManager.shared.send(["matchData": MatchAndPlayDTO(matchAndPlay: message).encodeIt()])
    }
    
    private func onMatchScheduleChange(message: String){
        WatchConnectivityManager.shared.send(["ahedBehind": message])
    }
    
    
}
