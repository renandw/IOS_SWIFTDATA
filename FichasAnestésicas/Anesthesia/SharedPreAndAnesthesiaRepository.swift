import Foundation
import SwiftData

protocol SharedPreAndAnesthesiaRepository {
    /// Returns the SharedPreAndAnesthesia associated with the given surgery, if any.
    func get(for surgery: Surgery) -> SharedPreAndAnesthesia?
    /// Ensures a SharedPreAndAnesthesia exists for the given surgery, creating and inserting one if necessary.
    @discardableResult
    func ensure(for surgery: Surgery) -> SharedPreAndAnesthesia
    /// Updates the given SharedPreAndAnesthesia with optional techniques and ASA classification, then saves the context.
    func update(_ shared: SharedPreAndAnesthesia, techniques: [AnesthesiaTechniqueKind]?, asa: ASAClassification?) throws
}

final class SwiftDataSharedPreAndAnesthesiaRepository: SharedPreAndAnesthesiaRepository {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func get(for surgery: Surgery) -> SharedPreAndAnesthesia? {
        surgery.shared
    }
    
    @discardableResult
    func ensure(for surgery: Surgery) -> SharedPreAndAnesthesia {
        if let existing = surgery.shared {
            return existing
        }
        
        let shared = SharedPreAndAnesthesia(techniquesRaw: [])
        shared.surgery = surgery
        surgery.shared = shared
        
        context.insert(shared)
        
        return shared
    }
    
    func update(_ shared: SharedPreAndAnesthesia, techniques: [AnesthesiaTechniqueKind]?, asa: ASAClassification?) throws {
        if let techniques = techniques {
            shared.techniques = techniques
        }
        if let asa = asa {
            shared.asa = asa
        }
        try context.save()
    }
}
