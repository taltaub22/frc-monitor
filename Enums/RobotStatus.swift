//
//  RobotStatus.swift
//  testapp Watch App
//
//  Created by Tal Taub on 24/03/2024.
//

import Foundation

enum DSStatus {
    case DISCONNECTED
    case COMPUTER_CONNECTED_NO_SOFTWARE
    case CONNECTED
}

enum RioStatus {
    case DISCONNECTED
    case NO_CODE
    case CONNECTED
}

enum RadioStatus {
    case DISCONNECTED
    case CONNECTED
}

enum EnableStatus {
    case DISABLED_AUTO
    case ENABLED_AUTO
    case DISABLED_TELEOP
    case ENABLED_TELEOP
    case ESTOP
    case ASTOP
    case BYPASSED
}
