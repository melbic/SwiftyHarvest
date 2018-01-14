//
//  User.swift
//  Harvest
//
//  Created by Samuel Bichsel on 29.12.17.
//

import Foundation

public struct User: Codable {
    let firstName: String
    let lastName: String
    let id:Int
    let email:String
    let telephone:String
    let timezone:String?
    let weeklyCapacity:Int
    let hasAccessToAllFutureProjects:Bool
    let isContractor:Bool
    let isAdmin:Bool
    let isProjectManager:Bool
    let canSeeRates:Bool
    let canCreateProjects:Bool
    let canCreateInvoices:Bool
    let isActive:Bool
    let createdAt:Date
    let updatedAt:Date
    let defaultHourlyRate: Int?
    let costRate: Int?
    let avatarUrl:URL
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case id
        case email="email"
        case telephone="telephone"
        case timezone="timezone"
        case weeklyCapacity="weekly_capacity"
        case hasAccessToAllFutureProjects="has_access_to_all_future_projects"
        case isContractor="is_contractor"
        case isAdmin="is_admin"
        case isProjectManager="is_project_manager"
        case canSeeRates="can_see_rates"
        case canCreateProjects="can_create_projects"
        case canCreateInvoices="can_create_invoices"
        case isActive="is_active"
        case createdAt="created_at"
        case updatedAt="updated_at"
        case defaultHourlyRate="default_hourly_rate"
        case costRate="cost_rate"
        case avatarUrl="avatar_url"
    }
}

extension User:PageContent {
    static var key: String = "users"
}
