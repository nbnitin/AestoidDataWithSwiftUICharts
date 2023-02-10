//
//  AestroidModel.swift
//  Asteroid
//
//  Created by Nitin Bhatia on 09/02/23.
//

import Foundation


struct AestroidModel : Decodable {
    let links : Links?
    let elementCount : Int?
    let nearEarthObjects : [String:[ObjectDateData]]?
    
    init() {
        links = nil
        elementCount = nil
        nearEarthObjects = nil
    }
    
    enum CodingKeys : String, CodingKey {
        case links = "links"
        case elementCount = "element_count"
        case nearEathObjects = "near_earth_objects"
    }
    
    init(from decoder: Decoder) throws {
        let decoderKey = try? decoder.container(keyedBy: CodingKeys.self)
        links = try? decoderKey?.decodeIfPresent(Links.self, forKey: .links)
        elementCount = try? decoderKey?.decodeIfPresent(Int.self, forKey: .elementCount)
        nearEarthObjects = try? decoderKey?.decodeIfPresent([String:[ObjectDateData]].self, forKey: .nearEathObjects)
    }
}


struct Links : Decodable {
    let next : String?
    let previous : String?
    let selfLink: String?
    
    init() {
        next = nil
        previous = nil
        selfLink = nil
    }
    
    enum CodingKeys : String, CodingKey {
        case next = "next"
        case previous = "previous"
        case selfLink = "self"
    }
    
    init(from decoder: Decoder) throws {
        let decoderKey = try? decoder.container(keyedBy: CodingKeys.self)
        next = try? decoderKey?.decodeIfPresent(String.self, forKey: .next)
        previous = try? decoderKey?.decodeIfPresent(String.self, forKey: .previous)
        selfLink = try? decoderKey?.decodeIfPresent(String.self, forKey: .selfLink)
    }
}

struct ObjectDateData : Decodable {
    let links : Links?
    let id,neoReferenceId,name,nasaJplUrl : String?
    let estimatedDiameter : EstimatedDiameter?
    let isPotentiallyHazardousAsteroid : Bool?
    let closeApproachData : [CloseApproachData]?
    let isSentryObject: Bool?
    let absoluteMagnitudeH : Double?
    
    init() {
        links = nil
        id = nil
        neoReferenceId = nil
        name = nil
        nasaJplUrl = nil
        absoluteMagnitudeH = nil
        estimatedDiameter = nil
        isPotentiallyHazardousAsteroid = nil
        closeApproachData = nil
        isSentryObject = nil
    }
    
    enum CodingKeys : String, CodingKey {
        case links
        case id
        case neoReferenceId = "neo_reference_id"
        case name
        case nasaJplUrl = "nasa_jpl_url"
        case absoluteMagnitudeH = "absolute_magnitude_h"
        case estimatedDiameter = "estimated_diameter"
        case isPotentiallyHazardousAsteroid = "is_potentially_hazardous_asteroid"
        case closeApproachData = "close_approach_data"
        case isSentryObject = "is_sentry_object"
    }
    
    init(from decoder: Decoder) throws {
        let decoderKey = try? decoder.container(keyedBy: CodingKeys.self)
        links = try? decoderKey?.decodeIfPresent(Links.self, forKey: .links)
        id = try? decoderKey?.decodeIfPresent(String.self, forKey: .id)
        neoReferenceId = try? decoderKey?.decodeIfPresent(String.self, forKey: .neoReferenceId)
        name = try? decoderKey?.decodeIfPresent(String.self, forKey: .name)
        nasaJplUrl = try? decoderKey?.decodeIfPresent(String.self, forKey: .nasaJplUrl)
        absoluteMagnitudeH = try? decoderKey?.decodeIfPresent(Double.self, forKey: .absoluteMagnitudeH)
        estimatedDiameter = try? decoderKey?.decodeIfPresent(EstimatedDiameter.self, forKey: .estimatedDiameter)
        isPotentiallyHazardousAsteroid = try? decoderKey?.decodeIfPresent(Bool.self, forKey: .isPotentiallyHazardousAsteroid)
        closeApproachData = try? decoderKey?.decodeIfPresent([CloseApproachData].self, forKey: .closeApproachData)
        isSentryObject = try? decoderKey?.decodeIfPresent(Bool.self, forKey: .isSentryObject)
    }
}

struct EstimatedDiameter : Decodable {
    let kilometers, meters, miles, feet : Diameters?
}

struct Diameters : Decodable {
    let estimatedDiameterMin,estimatedDiameterMax : Double?
    
    init() {
        estimatedDiameterMin = nil
        estimatedDiameterMax = nil
    }
    
    enum CodingKeys : String, CodingKey {
        case estimatedDiameterMin = "estimated_diameter_min"
        case estimatedDiameterMax = "estimated_diameter_max"
        
    }
    
    init(from decoder: Decoder) throws {
        let decoderKey = try? decoder.container(keyedBy: CodingKeys.self)
        estimatedDiameterMin = try? decoderKey?.decodeIfPresent(Double.self, forKey: .estimatedDiameterMin)
        estimatedDiameterMax = try? decoderKey?.decodeIfPresent(Double.self, forKey: .estimatedDiameterMax)
        
    }
}

struct CloseApproachData : Decodable {
    let closeApproachDate,closeApproachDateFull,epochDateCloseApproach : String?
    let relativeVelocity: Velocity?
    let missDistance : MissDistance?
    let orbitingBody : String?
    
    init() {
        closeApproachDate = nil
        closeApproachDateFull = nil
        epochDateCloseApproach = nil
        relativeVelocity = nil
        missDistance = nil
        orbitingBody = nil
    }
    
    enum CodingKeys : String, CodingKey {
        case closeApproachDate = "close_approach_date"
        case closeApproachDateFull = "close_approach_date_full"
        case epochDateCloseApproach = "epoch_date_close_approach"
        case relativeVelocity = "relative_velocity"
        case missDistance = "miss_distance"
        case orbitingBody = "orbiting_body"
    }
    
    init(from decoder: Decoder) throws {
        let decoderKey = try? decoder.container(keyedBy: CodingKeys.self)
        closeApproachDate = try? decoderKey?.decodeIfPresent(String.self, forKey: .closeApproachDate)
        closeApproachDateFull = try? decoderKey?.decodeIfPresent(String.self, forKey: .closeApproachDateFull)
        epochDateCloseApproach = try? decoderKey?.decodeIfPresent(String.self, forKey: .epochDateCloseApproach)
        relativeVelocity = try? decoderKey?.decodeIfPresent(Velocity.self, forKey: .relativeVelocity)
        missDistance = try? decoderKey?.decodeIfPresent(MissDistance.self, forKey: .missDistance)
        orbitingBody = try? decoderKey?.decodeIfPresent(String.self, forKey: .orbitingBody)
    }
}

struct Velocity : Decodable {
    let kilometersPerSecond,kilometersPerHour,milesPerHour : String?
    
    init() {
        kilometersPerSecond = nil
        kilometersPerHour = nil
        milesPerHour = nil
    }
    
    enum CodingKeys : String, CodingKey {
        case kilometersPerSecond = "kilometers_per_second"
        case kilometersPerHour = "kilometers_per_hour"
        case milesPerHour = "miles_per_hour"
    }
    
    init(from decoder: Decoder) throws {
        let decoderKey = try? decoder.container(keyedBy: CodingKeys.self)
        kilometersPerSecond = try? decoderKey?.decodeIfPresent(String.self, forKey: .kilometersPerSecond)
        kilometersPerHour = try? decoderKey?.decodeIfPresent(String.self, forKey: .kilometersPerHour)
        milesPerHour = try? decoderKey?.decodeIfPresent(String.self, forKey: .milesPerHour)
    }
}

struct MissDistance : Decodable {
    let astronomical,lunar,kilometers,miles : String?
}
