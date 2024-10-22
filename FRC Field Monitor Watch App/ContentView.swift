//
//  ContentView.swift
//  testapp Watch App
//
//  Created by Tal Taub on 23/03/2024.
//

import SwiftUI
import WatchConnectivity

struct ContentView: View {
    @ObservedObject private var connectivityManager = WatchConnectivityManager.shared
    
    var body: some View {
        VStack(spacing:6){
            
            if(connectivityManager.matchData != nil) {
                ZStack {
                    // Field status color
                    Rectangle()
                        .fill(stateToColor(state: connectivityManager.matchData.matchInfo.MatchState))
                        .frame(width: 240, height: 40)
                    
                        // Current Match
                        Text("M: \(connectivityManager.matchData.matchInfo.MatchNumber)")
                            .frame(width: 170, height: 45, alignment: .leading)
                            .font(.caption)
                }
                
                // Match Status
                Text(stateToText(state: connectivityManager.matchData.matchInfo.MatchState))
                    .bold()
                    .font(.body)
                
            }
            
            if(connectivityManager.teamData != nil){
                // Teams
                // TODO: test ds & robot statuses
                HStack{
                    // Red
                    VStack{
                        // Blue 3
                        let BLUE3 = 0
                        getTeamViewByStation(station: BLUE3, teamData: connectivityManager.teamData)
                        
                        // Blue 2
                        let BLUE2 = 1
                        getTeamViewByStation(station: BLUE2, teamData: connectivityManager.teamData)
                        
                        // Blue 1
                        let BLUE1 = 2
                        getTeamViewByStation(station: BLUE1, teamData: connectivityManager.teamData)
                    }
                    
                    //Blue
                    VStack{
                        let RED3 = 5
                        getTeamViewByStation(station: RED3, teamData: connectivityManager.teamData)
                        
                        let RED2 = 4
                        getTeamViewByStation(station: RED2, teamData: connectivityManager.teamData)
                        
                        let RED1 = 3
                        getTeamViewByStation(station: RED1, teamData: connectivityManager.teamData)
                    }
                }
            }
            
            if(connectivityManager.ahedBehind != nil){
                // Timing text
                Text(connectivityManager.ahedBehind)
                    .bold()
                    .font(.caption2)
            } else {
                Text("No Data")
                    .bold()
                    .font(.caption2)
            }
            
        }
            .onAppear(){
                WatchConnectivityManager.shared
                HttpService.getMatchNumberAndPlay { data in
                    connectivityManager.matchData = MatchInfo(matchInfo: MatchAndPlay(MatchState: "WaitingForPrestart", MatchNumber: data[0]))
                }
            }
    }
    
    func getTeamViewByStation(station: Int, teamData:[TeamData]) -> some View{
        return TeamView(teamNumber: teamData[station].TeamNumber,
                        alliance: teamData[station].Alliance == "Red" ? Alliance.RED: Alliance.BLUE,
                 dsStatus: getDSStatus(status: teamData[station].StationStatus),
                 radioStatus: teamData[station].RadioLink ? RadioStatus.CONNECTED : RadioStatus.DISCONNECTED,
                 rioStatus: getRioStatus(isConnected: teamData[station].RIOLink, isLinkActive: teamData[station].LinkActive),
                 enableStatus: getRobotEnableStatus(isBypassed: teamData[station].IsBypassed, isEnabled: teamData[station].IsEnabled, isEstopped: teamData[station].IsEStopped, isAstopped: teamData[station].IsAStopped, isAuto: teamData[station].IsAuto))
    }
    
    private func getDSStatus(status: String) -> DSStatus{
        switch status{
        case "0":
            return DSStatus.CONNECTED
        case "1":
            return DSStatus.COMPUTER_CONNECTED_NO_SOFTWARE
        case "2":
            return DSStatus.COMPUTER_CONNECTED_NO_SOFTWARE
        case "3":
            return DSStatus.COMPUTER_CONNECTED_NO_SOFTWARE
        default:
            return DSStatus.DISCONNECTED
            
        }
    }
    
    private func getRioStatus(isConnected: Bool, isLinkActive:Bool) -> RioStatus{
        if(isConnected){
            if(!isLinkActive){
                return RioStatus.NO_CODE
            }else {
                return RioStatus.CONNECTED
            }
        } else{
            return RioStatus.DISCONNECTED
        }
    }
    
    private func getRobotEnableStatus(isBypassed: Bool, isEnabled: Bool, isEstopped: Bool, isAstopped: Bool, isAuto: Bool) -> EnableStatus{
        if(isBypassed){
            return EnableStatus.BYPASSED
        }
        
        if(isEstopped){
            return EnableStatus.ESTOP
        }
        
        if(isAstopped){
            return EnableStatus.ASTOP
        }
        
        if(isEnabled){
            if(isAuto){
                return EnableStatus.ENABLED_AUTO
            } else{
                return EnableStatus.ENABLED_TELEOP
            }
        } else{
            return EnableStatus.DISABLED_AUTO
        }
    }
    
    private func stateToText(state: String) -> String{
        switch state{
        case "Prestarting":
            return "Prestarting"
        case "WaitingForMatchPreview":
            return "Waiting For Field"
        case "WaitingForSetAudience":
            return "Waiting For Field"
        case "WaitingForMatchReady":
            return "Waiting For Field"
        case "WaitingForMatchStart":
            return "Waiting to start"
        case "GameSpecificData":
            return ""
        case "MatchAuto":
            return  "Playing (Auto)"
        case "MatchTransition":
            return "Transitioning"
        case "MatchTeleop":
            return "Playing (Teleop)"
        case "WaitingForCommit":
            return "Waiting Refs"
        case "WaitingForPostResults":
            return "Waiting MCs"
        case "WaitingForPrestart":
            return "Ready to Prestart"
        default:
            return "Unknown"
        }
    }
    
    private func stateToColor(state: String) -> Color{
        switch state{
        case "Prestarting":
            return .yellow
        case "WaitingForMatchPreview":
            return .red
        case "WaitingForSetAudience":
            return .red
        case "WaitingForMatchReady":
            return .red
        case "WaitingForMatchStart":
            return .green
        case "GameSpecificData":
            return .gray
        case "MatchAuto":
            return  .green
        case "MatchTransition":
            return .yellow
        case "MatchTeleop":
            return .green
        case "WaitingForCommit":
            return .orange
        case "WaitingForPostResults":
            return .orange
        case "WaitingForPrestart":
            return .red
        default:
            return .gray
        }
    }
}

//#Preview {
    //ContentView().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).navigationBarHidden(true)
//}
