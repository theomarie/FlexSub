//
//  UserMessage.swift
//  FlexSub
//
//  Created by Theo Marie on 05/11/2024.
//
import Foundation
import ExyteChat


public struct UserMessaging: Codable, Identifiable, Hashable {
    public let id: String
    public let name: String
    public let avatarURL: URL?
    public let isCurrentUser: Bool
}
