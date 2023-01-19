//
//  Errors.swift
//  StarWars
//
//  Created by Nov Petrović on 19/01/2023.
//

import Foundation

enum BUError: String, Error {
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case invalidUrl = "Well this is embarrasing... The url you're trying to send data to is invalid. Please report this to our team."
}
