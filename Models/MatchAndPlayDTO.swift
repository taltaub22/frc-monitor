//
//  MatchAndPlayDTO.swift
//  FRC Field Monitor
//
//  Created by Tal Taub on 26/03/2024.
//

import Foundation

struct MatchAndPlayDTO: Codable{
    var matchAndPlay: MatchAndPlay
    
    func encodeIt() -> Data{
        let data = try! PropertyListEncoder.init().encode(self)
            return data
    }
    
    static func decodeIt(_ data:Data) -> MatchAndPlayDTO{
        let teamData = try! PropertyListDecoder.init().decode(MatchAndPlayDTO.self, from: data)
        return teamData
    }
}
