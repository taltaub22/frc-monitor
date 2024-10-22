//
//  TeamView.swift
//  testapp Watch App
//
//  Created by Tal Taub on 24/03/2024.
//

import SwiftUI

let ESTOP_TEXT = "E Stop"
let ASTOP_TEXT = "A Stop"
let BYPASSED_TEXT = "Bypassed"

struct TeamView: View {

    var teamNumber: Int
    var alliance: Alliance
    var dsStatus: DSStatus
    var radioStatus: RadioStatus
    var rioStatus: RioStatus
    var enableStatus: EnableStatus
    
    
    var body: some View {
        ZStack{
            // Background
            RoundedRectangle(cornerRadius: 6).fill(.white).frame(width: 90, height: 40)
            VStack{
                
                
                if(enableStatus == EnableStatus.ASTOP || enableStatus == EnableStatus.ESTOP || enableStatus == EnableStatus.BYPASSED){
                    ZStack{
                        RoundedRectangle(cornerRadius: 4)
                            .fill(enableStatus != EnableStatus.BYPASSED ? .yellow : .brown)
                            .frame(width: 80, height: 15)
                        
                        let text = enableStatus == EnableStatus.ASTOP ? ASTOP_TEXT : enableStatus == EnableStatus.ESTOP ? ESTOP_TEXT : BYPASSED_TEXT
                        
                        Text(text)
                            .bold()
                            .font(.caption2)
                            .foregroundColor(.black)
                            
                    }
                    
                } else {
                    // Team Status
                    HStack{
                        // DS
                        ZStack{
                            RoundedRectangle(cornerRadius: 4)
                                .fill(dsStatus != DSStatus.DISCONNECTED ? .green : .red)
                                .frame(width: 15, height: 15)
                            
                            if(dsStatus == DSStatus.COMPUTER_CONNECTED_NO_SOFTWARE){
                                Image(systemName: "xmark").foregroundColor(.black)
                            }
                        }
                        
                        // Radio
                        RoundedRectangle(cornerRadius: 4)
                            .fill(radioStatus == RadioStatus.CONNECTED ? .green : .red)
                            .frame(width: 15, height: 15)
                        
                        // Rio
                        ZStack{
                            RoundedRectangle(cornerRadius: 4)
                                .fill(rioStatus != RioStatus.DISCONNECTED ? .green : .red)
                                .frame(width: 15, height: 15)
                            
                            if(rioStatus == RioStatus.NO_CODE){
                                Image(systemName: "xmark").foregroundColor(.black)
                            }
                        }
                        
                        // Enable
                        ZStack{
                            RoundedRectangle(cornerRadius: 4)
                                .fill(isEnabled(robotStatus: enableStatus) ? .green : .red)
                                .frame(width: 15, height: 15)
                            
                            
                            
                            (isTeleop(robotStatus: enableStatus) ? Text("T") : Text("A")).foregroundColor(.black)
                        }
                    }
                }
                // Team Number
                Text(String(teamNumber))
                    .foregroundColor(alliance == Alliance.RED ? .red : .blue)
                    .font(.footnote)
            }
        }
    }
}

func isEnabled(robotStatus: EnableStatus) -> Bool{
    return (robotStatus == EnableStatus.ENABLED_AUTO || robotStatus == EnableStatus.ENABLED_TELEOP)
}

func isTeleop(robotStatus: EnableStatus) -> Bool {
    return (robotStatus == EnableStatus.ENABLED_TELEOP || robotStatus == EnableStatus.DISABLED_TELEOP)
}

#Preview {
    TeamView(teamNumber: 9999, alliance: Alliance.BLUE, 
             dsStatus: DSStatus.COMPUTER_CONNECTED_NO_SOFTWARE,
             radioStatus: RadioStatus.DISCONNECTED,
             rioStatus: RioStatus.NO_CODE,
             enableStatus: EnableStatus.ESTOP)
}
