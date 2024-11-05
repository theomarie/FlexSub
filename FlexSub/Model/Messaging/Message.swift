//
//  Message.swift
//  FlexSub
//
//  Created by Theo Marie on 05/11/2024.
//


import SwiftUI
import FirebaseFirestore
import ExyteChat

public struct Message: Identifiable, Hashable, Encodable {
    
    public enum StatusMessage: Hashable, Equatable, Encodable {
           case sending
           case sent
           case read
          // case error(DraftMessage)
         
       }
    
    public var id: String
    var userMessage: UserMessaging
    var status: StatusMessage?
    public var createdAt: Date
    public var text: String
    public var attachments: [Attachment]
    
    
}
