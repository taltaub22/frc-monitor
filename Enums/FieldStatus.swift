//
//  FieldStatus.swift
//  testapp Watch App
//
//  Created by Tal Taub on 24/03/2024.
//

import Foundation

enum FieldStatus {
    case WAITING_PRESTART
    case PRESTARTING
    case READY
    case MATCH_RUNNING_AUTO
    case MATCH_RUNNING_TELEOP
    case MATCH_END
}
