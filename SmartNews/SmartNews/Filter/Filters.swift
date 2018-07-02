//
//  Filters.swift
//  SmartNews
//
//  Created by Raul Bude on 25/06/2018.
//  Copyright © 2018 Raul Bude. All rights reserved.
//

import Foundation

enum Filters: String {
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology

    static let allValues = [business, entertainment, general, health, science, sports, technology]
}

