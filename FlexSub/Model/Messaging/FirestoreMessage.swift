//
//  FirestoreMessage.swift
//  FlexSub
//
//  Created by Theo Marie on 05/11/2024.
//

import Firebase
import FirebaseFirestore
import Foundation
import ExyteChat

public struct FirestoreMessage: Codable, Hashable {
    @DocumentID public var id: String?
    public var userId: String
    @ServerTimestamp public var createdAt: Date?
    public var text: String
    public var replyMessage: ReplyMessage?
    public var attachments: [Attachment]
}
