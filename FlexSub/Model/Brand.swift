//
//  Brand.swift
//  FlexSub
//
//  Created by Theo Marie on 26/10/2024.
//

enum Brand: String, CaseIterable {
    case basicFit = "Basic fit"
    case pathe = "Pathé"
    case ugc = "UGC"
    
    var logo: String {
        switch self {
        case .basicFit:
            return "basic_fit_logo"
        case .pathe:
            return "pathe_logo"
        case .ugc:
            return "ugc_logo"
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


