//
//  HTTPService.swift
//  testapp Watch App
//
//  Created by Tal Taub on 26/03/2024.
//

import Foundation

public class HttpService{
    
    static func getMatchNumberAndPlay(completion:@escaping ([Int]) -> ()) {
        let url = URL(string: "http://\(K.connection.BASE_URL)/FieldMonitor/MatchNumberAndPlay")!

        URLSession.shared.dataTask(with: url) { data,_,_ in
            if(data != nil){
                let data  = try! JSONDecoder().decode([Int].self, from: data!)
                
                DispatchQueue.main.async {
                    completion(data)
                }
            }
        }.resume()
    }
}
