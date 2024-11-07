//
//  Message.swift
//  FlexSub
//
//  Created by Theo Marie on 05/11/2024.
//

import SwiftUI
import FirebaseFirestore
import ExyteChat

 struct Conversation: Codable, Identifiable {
     let id: String
     let title: String
     let userMessaging: [ChatParticipant]
 }
