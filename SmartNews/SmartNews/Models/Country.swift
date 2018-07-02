//
//  Country.swift
//  SmartNews
//
//  Created by Raul Bude on 06/06/2018.
//  Copyright © 2018 Raul Bude. All rights reserved.
//

import Foundation

enum Country: String, Collection {

    public static var allCountries: [Country] {
        return Array(self.countries())
    }

    case Argentina = "ar"
    case Australia = "au"
    case Austria = "at"
    case Belgium = "be"
    case Brazil = "br"
    case Bulgaria = "bg"
    case Canada = "ca"
    case China = "cn"
    case Colombie = "co"
    case Cuba = "cu"
    case CzechRepublic = "cz"
    case France = "fr"
    case Greece = "gr"
    case Hungary = "hu"
    case India = "in"
    case Indonesia = "id"
    case Ireland = "ie"
    case Israel = "il"
    case Italy = "it"
    case Japan = "jp"
    case Latvia = "lv"
    case Lithuania = "lt"
    case Mexico = "mx"
    case Morocco = "ma"
    case Netherlands = "nl"
    case NewZealand = "nz"
    case Nigeria = "ng"
    case Norway = "no"
    case Philippines = "ph"
    case Poland = "pl"
    case Portugal = "pt"
    case Romania = "ro"
    case Russia = "ru"
    case SaudiArabia = "sa"
    case Serbia = "rs"
    case Singapore = "sg"
    case Slovakia = "sk"
    case Slovenia = "si"
    case SouthAfrica = "za"
    case SouthKorea = "kr"
    case Sweden = "se"
    case Switzerland = "ch"
    case Thailand = "th"
    case Turkey = "tr"
    case Ukraine = "ua"
    case UnitedKingdom = "gb"
    case UnitedStates = "us"
    case Venezuela = "ve"

    var description: String {
        switch self {
        case .Argentina, .Australia, .Austria, .Belgium, .Brazil, .Bulgaria, .Canada, .China, .Colombie, .Cuba, .CzechRepublic, .France , .Greece, .Hungary, .India, .Indonesia, .Ireland, .Israel, .Italy, .Japan, .Latvia, .Lithuania, .Mexico, .Morocco, .Netherlands, .NewZealand, .Nigeria, .Norway, .Philippines, .Poland, .Portugal, .Romania, .Russia, .SaudiArabia, .Serbia, .Singapore, .Slovakia, .Slovenia, .SouthAfrica, .SouthKorea, .Sweden, .Switzerland, .Thailand, .Turkey, .Ukraine, .UnitedKingdom, .UnitedStates, .Venezuela:

            return "\(self)".camelCaps
        }
    }

    static func getCountryKey(from string: String) -> String {
        for ctry in Country.allCountries {
            let countryString = ctry.description
            if countryString == string {
                return ctry.rawValue
            }
        }
        return "No Country"
    }

    static func countries() -> AnySequence<Country> {
        return AnySequence { () -> AnyIterator<Country> in
            var raw = 0
            return AnyIterator {
                let current: Country = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else {
                    return nil
                }
                raw += 1
                return current
            }
        }
    }
}

extension String {
    var camelCaps: String {
        var newString: String = ""

        let upperCase = CharacterSet.uppercaseLetters
        for scalar in self.unicodeScalars {
            if upperCase.contains(scalar) {
                newString.append(" ")
            }
            let character = Character(scalar)
            newString.append(character)
        }

        return newString
    }
}

protocol Collection: Hashable {
    static func countries() -> AnySequence<Self>
    static func getCountryKey(from string: String) -> String
    static var allCountries: [Self] { get }
}

