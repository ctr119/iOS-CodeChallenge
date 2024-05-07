//
//  ProfileViewModel.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 7/5/24.
//

import Foundation
import SwiftUI

@Observable
class ProfileViewModel {
    struct UserDisplay {
        let name: String
        let phone: String
        let website: String
        
        static let any: UserDisplay = .init(name: "", phone: "", website: "")
    }
    
    var userDisplay: UserDisplay = .any
    
    private let getProfileUseCase: GetProfileInformationUseCase
    
    init(getProfileUseCase: GetProfileInformationUseCase) {
        self.getProfileUseCase = getProfileUseCase
    }
    
    func fetchInfo() async {
        let userId = "4"
        if let user = try? await getProfileUseCase(userId: userId) {
            await MainActor.run {
                userDisplay = .init(name: user.name, phone: user.phone, website: user.website)
            }
        }
    }
}
