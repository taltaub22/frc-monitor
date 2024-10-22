//
//  TeamData.swift
//  testapp Watch App
//
//  Created by Tal Taub on 25/03/2024.
//

import Foundation

struct TeamDataDTO: Codable {
    var teamData: [TeamData]
    
    func encodeIt() -> Data{
        let data = try! PropertyListEncoder.init().encode(self)
            return data
    }
    
    static func decodeIt(_ data:Data) -> TeamDataDTO{
        let teamData = try! PropertyListDecoder.init().decode(TeamDataDTO.self, from: data)
        return teamData
    }
}
