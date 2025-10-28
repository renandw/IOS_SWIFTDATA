
// MARK: - Usuário (autor/criador de registros)

@Model
final class User {
    @Attribute(.unique) var uid: String          // ID estável usado em createdBy/updatedBy
    var name: String
    var crm: String?
    var rqe: String?
    var telefone: String?
    @Attribute(.unique) var email: String?

    init(
        uid: String,
        name: String,
        crm: String? = nil,
        rqe: String? = nil,
        telefone: String? = nil,
        email: String? = nil
    ) {
        self.uid = uid
        self.name = name
        self.crm = crm
        self.rqe = rqe
        self.telefone = telefone
        self.email = email
    }
}
