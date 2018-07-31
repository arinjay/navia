//
//  Health.swift
//  Navia_Project
//
//  Created by Arinjay on 26/07/18.
//  Copyright © 2018 Arinjay. All rights reserved.
//
import Foundation




struct Health : Codable {
    let week_diet_data : day
}

struct day: Codable {
    let monday: [customDay]
    let wednesday: [customDay]
    let thursday : [customDay]
}

struct customDay: Codable {
    let food: String
}
