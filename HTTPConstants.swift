//
//  APIConstants.swift
//  Saloon User
//
//  Created by Shivang Mishra on 01/04/17.
//  Copyright Â© 2017 Code Brew. All rights reserved.
//

import Foundation
import Alamofire

let timezone = /DateTimeManager.shared.localTimeZoneName
let phoneCode = /LocaleManager.shared.phoneCode
let deviceId = /UUID().uuidString
let deviceToken = /LocalStore.deviceToken
let currency = /LocaleManager.shared.currencySymbol
let sharedAppDelegate = (UIApplication.shared.delegate as? AppDelegate)
let appVersion = DeviceManager.shared.appVersioning

//MARK: - API Method
public enum APIMethod {
    case get
    case post
    case postWithImage
    case put
    
    // Conversion to Alamofire's HTTPMethod
    func associatedHttpMethod() -> HTTPMethod {
        switch self {
        case .get:
            return HTTPMethod.get
        case .post:
            return HTTPMethod.post
        case .put:
            return HTTPMethod.put
        case .postWithImage:
            return HTTPMethod.post
        }
    }
}

//MARK: - API Url
public enum APIUrl : CustomStringConvertible {
    
    case base
    public var description : String {
        switch self {
        case .base : return "http://ec2-34-197-116-80.compute-1.amazonaws.com/Saloon/public/Api/V1/"
        }
    }
}

//MARK: - API Resource Path
public enum APIResourcePath : CustomStringConvertible {
    
    case login
    case register
    case forgot_password
    case other_data
    case category_data
    case logout
    case vendor_profile
    case profile_update
    case password_update
    case employee_add
    case employee_detail
    case employees
    case employee_delete
    case employee_update
    case service_add
    case service_details
    case service_delete
    case services_all
    case service_update
    case reviews_all
    case booking_accept
    case booking_reject
    case booking_complete
    case bookings_vendors
    case bookings_requests
    case revenue_api
    case plans
    case bought_plan
    case profile_pic
    case api_version
    
    public var description : String {
        
        switch self {
            
        case .login : return "Vendor/login"
        case .register : return "Vendor/register"
        case .forgot_password : return "Vendor/forgot_password"
        case .other_data : return "other_data"
        case .category_data: return "category_data"
        case .logout : return "Vendor/logout"
        case .vendor_profile : return "Vendor/vendor_profile"
        case .profile_update : return "Vendor/profile_update"
        case .password_update : return "Vendor/password_update"
        case .employee_add : return "Vendor/employee_add"
        case .employee_detail : return "Vendor/employee_detail"
        case .employees : return "Vendor/employees"
        case .employee_delete : return "Vendor/employee_delete"
        case .employee_update : return "Vendor/employee_update"
        case .service_add : return "Vendor/service_add"
        case .service_details : return "Vendor/service_details"
        case .service_delete : return "Vendor/service_delete"
        case .services_all : return "Vendor/services_all"
        case .service_update : return "Vendor/service_update"
        case .reviews_all : return "Vendor/reviews_all"
        case .booking_accept : return "Vendor/booking_accept"
        case .booking_reject : return "Vendor/booking_reject"
        case .booking_complete : return "Vendor/booking_complete"
        case .bookings_vendors : return "Vendor/bookings_vendors"
        case .bookings_requests : return "Vendor/bookings_requests"
        case .revenue_api : return "Vendor/revenue_api"
        case .plans: return "Vendor/plans"
        case .bought_plan: return "Vendor/bought_plan"
        case .profile_pic: return "Vendor/profile_pic"
        case .api_version: return "Vendor/api_version"
        }
    }
}

//MARK: - API Keys
public enum APIKeys : CustomStringConvertible {
    
    case statuscode
    case msg
    case success
    case access_token
    case web_access_token
    case name
    case profile_pic
    case email
    case phone_code
    case phone_number
    case experience
    case currency
    case device_id
    case address
    case address_latitude
    case address_longitude
    case timezone
    case timezonez
    case approved
    case blocked
    case profile_pic_url
    case id
    case vendor
    case image_url
    case image
    case category_id
    case category_base_images
    case category_images
    case category_subs
    case categories
    case vendor_images
    case timing_id
    case starting_timings
    case ending_timings
    case day_name
    case vendor_employee_timings
    case employee_id
    case active
    case vendor_service_employees
    case vendor_service_id
    case service_id
    case service_name
    case service_description
    case service_price
    case service_minutes
    case category_name
    case category_image
    case category_image_url
    case category_sub_id
    case category_sub_name
    case employee
    case employees
    case description
    case price
    case minutes
    case service
    case user_id
    case vendor_id
    case booking_id
    case rating
    case comments
    case user_name
    case user_profile_pic_url
    case reviews
    case price_formated
    case services
    case day_only
    case starting_date_formated
    case count
    case bookings
    case starting_dt
    case ending_dt
    case status
    case accepted
    case ordering
    case starting_time_formated
    case timings
    case service_type
    case user
    case vendor_employee
    case booking_services
    case all_bookings
    case month_only
    case short_name
    case dt2
    case graph_data
    case vendor_employee_subcats
    case subcat_id
    case plans
    case bought
    case start_dt
    case end_dt
    case type
    case start
    case data
    case day_only1
    case day_number
    case day_name1
    case price1
    case dt3
    case dt4
    case dt5
    case ending_date_formated
    case ending_time_formated
    case subcat_count
    case selected
    case image_count
    case distance
    case ratings
    
    public var description : String { return self.string }
    
    var string: String {
        
        switch self {
            
        case .statuscode : return "statuscode"
        case .msg : return  "msg"
        case .success : return "success"
        case .access_token : return "access_token"
        case .web_access_token : return "web_access_token"
        case .name : return "name"
        case .email : return "email"
        case .experience : return "experience"
        case .currency : return "currency"
        case .profile_pic : return "profile_pic"
        case .address : return "address"
        case .phone_code : return "phone_code"
        case .phone_number : return "phone_number"
        case .device_id : return "device_id"
        case .address_latitude : return "address_latitude"
        case .address_longitude : return "address_longitude"
        case .timezone : return "timezone"
        case .timezonez : return "timezonez"
        case .approved : return "approved"
        case .blocked : return "blocked"
        case .profile_pic_url : return "profile_pic_url"
        case .id : return "id"
        case .vendor : return "vendor"
        case .image_url : return "image_url"
        case .image : return "image"
        case .category_id : return "category_id"
        case .category_base_images : return "category_base_images"
        case .category_images : return "category_images"
        case .category_subs : return "category_subs"
        case .categories : return "categories"
        case .vendor_images : return "vendor_images"
        case .timing_id: return "timing_id"
        case .starting_timings: return "starting_timings"
        case .ending_timings: return "ending_timings"
        case .day_name: return "day_name"
        case .vendor_employee_timings: return "vendor_employee_timings"
        case .employee_id: return "employee_id"
        case .active: return "active"
        case .vendor_service_employees: return "vendor_service_employees"
        case .vendor_service_id: return "vendor_service_id"
        case .service_id: return "service_id"
        case .service_name: return "service_name"
        case .service_description: return "service_description"
        case .service_price: return "service_price"
        case .service_minutes: return "service_minutes"
        case .category_name: return "category_name"
        case .category_image: return "category_image"
        case .category_image_url: return "category_image_url"
        case .category_sub_id: return "category_sub_id"
        case .category_sub_name: return "category_sub_name"
        case .employee: return "employee"
        case .employees: return "employees"
        case .description: return "description"
        case .price: return "price"
        case .minutes: return "minutes"
        case .service: return "service"
        case .user_id: return "user_id"
        case .vendor_id: return "vendor_id"
        case .booking_id: return "booking_id"
        case .rating: return "rating"
        case .comments: return "comments"
        case .user_name: return "user_name"
        case .user_profile_pic_url: return "user_profile_pic_url"
        case .reviews: return "reviews"
        case .price_formated: return "price_formated"
        case .services: return "services"
        case .day_only: return "day_only"
        case .starting_date_formated: return "starting_date_formated"
        case .count: return "count"
        case .bookings: return "bookings"
        case .starting_dt: return "starting_dt"
        case .ending_dt: return "ending_dt"
        case .status: return "status"
        case .accepted: return "accepted"
        case .ordering: return "ordering"
        case .starting_time_formated: return "starting_time_formated"
        case .timings: return "timings"
        case .service_type: return "service_type"
        case .user: return "user"
        case .vendor_employee: return "vendor_employee"
        case .booking_services: return "booking_services"
        case .all_bookings: return "bookings"
        case .month_only: return "month_only"
        case .short_name: return "short_name"
        case .dt2: return "dt2"
        case .graph_data: return "graph_data"
        case .vendor_employee_subcats: return "vendor_employee_subcats"
        case .subcat_id: return "subcat_id"
        case .plans: return "plans"
        case .bought: return "bought"
        case .start_dt: return "start_dt"
        case .end_dt: return "end_dt"
        case .type: return "type"
        case .start: return "start"
        case .data: return "data"
        case .day_only1: return "day_only1"
        case .day_number: return "day_number"
        case .day_name1 : return "day_name1"
        case .price1: return "price1"
        case .dt3: return "dt3"
        case .dt4: return "dt4"
        case .dt5: return "dt5"
        case .ending_time_formated: return "ending_time_formated"
        case .ending_date_formated: return "ending_date_formated"
        case .subcat_count: return "subcat_count"
        case .selected: return "selected"
        case .image_count: return "image_count"
        case .distance: return "distance"
        case .ratings: return "ratings"
        }
    }
}
