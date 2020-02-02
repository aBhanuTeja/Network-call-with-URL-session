//  Copyright © 2020 annam. All rights reserved.

import Foundation

struct GETMethodModel: Codable {
    let items: [Item]?
    let hasMore: Bool?
    let quotaMax, quotaRemaining: Int?

    enum CodingKeys: String, CodingKey {
        case items
        case hasMore = "has_more"
        case quotaMax = "quota_max"
        case quotaRemaining = "quota_remaining"
    }
}

// MARK: - Item
struct Item: Codable {
    let tags: [String]?
    let owner: Owner?
    let isAnswered: Bool?
    let viewCount, protectedDate: Int?
    let acceptedAnswerID: Int?
    let answerCount, score, lastActivityDate, creationDate: Int?
    let lastEditDate, questionID: Int?
    let link: String?
    let title: String?
    let communityOwnedDate, lockedDate: Int?

    enum CodingKeys: String, CodingKey {
        case tags, owner
        case isAnswered = "is_answered"
        case viewCount = "view_count"
        case protectedDate = "protected_date"
        case acceptedAnswerID = "accepted_answer_id"
        case answerCount = "answer_count"
        case score
        case lastActivityDate = "last_activity_date"
        case creationDate = "creation_date"
        case lastEditDate = "last_edit_date"
        case questionID = "question_id"
        case link, title
        case communityOwnedDate = "community_owned_date"
        case lockedDate = "locked_date"
    }
}

// MARK: - Owner
struct Owner: Codable {
    let reputation, userID: Int?
    let userType: UserType?
    let acceptRate: Int?
    let profileImage: String?
    let displayName: String?
    let link: String?

    enum CodingKeys: String, CodingKey {
        case reputation
        case userID = "user_id"
        case userType = "user_type"
        case acceptRate = "accept_rate"
        case profileImage = "profile_image"
        case displayName = "display_name"
        case link
    }
}

enum UserType: String, Codable {
    case registered = "registered"
}
