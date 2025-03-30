//
//  Tasks.swift
//  MachineCodingRound
//
//  Created by Priyanshu Singh on 29/03/25.
//

import Foundation

struct Tasks : Identifiable , Codable{
    var id =  UUID()
    let task : String
    let description : String?
}


// This one is created in testing branch.
// Now this one is created in again testing branch which is outdates and should create an error.
// This one is created in the develop branch.
