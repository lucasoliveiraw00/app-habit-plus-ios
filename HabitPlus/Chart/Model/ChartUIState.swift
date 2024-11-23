//
//  ChartUIState.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 23/11/24.
//

import Foundation

enum ChartUIState: Equatable {
    case loading
    case emptyChart
    case fullChart
    case error(String)
}
