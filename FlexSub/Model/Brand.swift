//
//  Brand.swift
//  FlexSub
//
//  Created by Theo Marie on 26/10/2024.
//

enum Brand: String, CaseIterable {
    case basicFit = "Basic fit"
    case pathe = "Pathe"
    case ugc = "UGC"
    case jeudepaume = "Jeu de paume"
    case madparis = "Mad Paris"
    case tempmachines = "Le Temp Machines"
    
    var logo: String {
        switch self {
        case .basicFit:
            return "basic_fit_logo"
        case .pathe:
            return "pathe_logo"
        case .ugc:
            return "ugc_logo"
        case .jeudepaume:
            return "jeudepaume_logo"
            case .madparis:
            return "madparis_logo"
        case .tempmachines:
            return "le_temp_machines_logo"
            
     
            
        }
    }
    
    
    func normalizeString(_ input: String) -> String {
        return input.lowercased().replacingOccurrences(of: " ", with: "_")
    }

    func findBrandLogo(for input: String) -> String? {
        let normalizedInput = normalizeString(input)
       
        if normalizedInput.contains(normalizeString(rawValue)) {
            return logo 
        }
        
        return nil // Aucun logo trouvé
    }
    
}


