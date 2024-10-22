//
//  TeamData.swift
//  testapp Watch App
//
//  Created by Tal Taub on 25/03/2024.
//

import Foundation

struct TeamData: Codable {
    var Alliance: String
    var AverageTripTime: Int
    var BWUtilization: String
    var Battery: Float
    var Brownout: Bool
    var Connection: Bool
    var DSLinkActive: Bool
    var DataRateFromRobot: Int
    var DataRateToRobot: Int
    var DataRateTotal: Int
    var DriverStationIsOfficial: Bool
    var EStopSource: String
    var Inactivity: Int
    var IsAStopPressed: Bool
    var IsAStopped: Bool
    var IsAuto: Bool
    var IsBypassed: Bool
    var IsEStopPressed: Bool
    var IsEStopped: Bool
    var IsEnabled: Bool
    var LinkActive: Bool
    var LostPackets: Int
    var MonitorStatus: String
    var MoveToStation: String?
    var Noise: Int
    var RIOLink: Bool
    var RadioLink: Bool
    var RxMCS: Float
    var RxMCSBandWidth: Float
    var RxPackets: Int
    var RxRate: Int
    var Station: String
    var StationStatus: String
    var TeamNumber: Int
    var WPAKeyStatus: String
    
    init(){
        self.Alliance = "Red"
        self.AverageTripTime = 0
        self.BWUtilization = "Low"
        self.Battery = 0.0
        self.Brownout = false
        self.Connection = false
        self.DSLinkActive = false
        self.DataRateFromRobot = 0
        self.DataRateToRobot = 0
        self.DataRateTotal = 0
        self.DriverStationIsOfficial = false
        self.EStopSource = "D"
        self.Inactivity = 0
        self.IsAStopPressed = false
        self.IsAStopped = false
        self.IsAuto = false
        self.IsBypassed = false
        self.IsEStopPressed = false
        self.IsEStopped = false
        self.IsEnabled = false
        self.LinkActive = false
        self.LostPackets = 0
        self.MonitorStatus = "Unknown"
        self.MoveToStation = nil
        self.Noise = 0
        self.RIOLink = false
        self.RadioLink = false
        self.RxMCS = 0.0
        self.RxMCSBandWidth = 0.0
        self.RxPackets = 0
        self.RxRate = 0
        self.Station = "Station3"
        self.StationStatus = "Unknown" // DS Status 0 - good, 1 - wrong station, 2- wrong match, 3 - no software
        self.TeamNumber = 6
        self.WPAKeyStatus = "NotTested"
    }
    
    func encodeIt() -> Data{
        let data = try! PropertyListEncoder.init().encode(self)
            return data
    }
    
    static func devodeIt(_ data:Data) -> TeamData{
        let teamData = try! PropertyListDecoder.init().decode(TeamData.self, from: data)
        return teamData
    }
}
