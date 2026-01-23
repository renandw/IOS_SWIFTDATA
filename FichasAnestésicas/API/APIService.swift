import Foundation

/// Represents a calendar date (no time / no timezone) encoded as "YYYY-MM-DD".
struct DateOnly: Codable, Equatable {
    let date: Date

    private static let formatter: DateFormatter = {
        let df = DateFormatter()
        df.calendar = Calendar(identifier: .gregorian)
        df.locale = Locale(identifier: "en_US_POSIX")
        df.timeZone = TimeZone(secondsFromGMT: 0)
        df.dateFormat = "yyyy-MM-dd"
        return df
    }()

    init(_ date: Date) {
        self.date = date
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let str = try container.decode(String.self)
        guard let d = Self.formatter.date(from: str) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date-only string: \(str)")
        }
        self.date = d
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(Self.formatter.string(from: date))
    }
}

class APIService {
    static let shared = APIService()
    
    // ⚠️ TROQUE pelo IP do seu homelab!
    private let baseURL = "http://fichasanestesicas.bomsucessoserver.com"
    
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()

        // Contrato do servidor: timestamps sempre em ISO8601 UTC
        // Ex: 2026-01-23T02:58:23.954Z
        let isoWithFractional: ISO8601DateFormatter = {
            let f = ISO8601DateFormatter()
            f.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            return f
        }()
        let isoBasic = ISO8601DateFormatter()

        decoder.dateDecodingStrategy = .custom { dec in
            let container = try dec.singleValueContainer()
            let str = try container.decode(String.self)

            if let d = isoWithFractional.date(from: str) { return d }
            if let d = isoBasic.date(from: str) { return d }

            // Fallback for date-only strings (YYYY-MM-DD)
            let df = DateFormatter()
            df.calendar = Calendar(identifier: .gregorian)
            df.locale = Locale(identifier: "en_US_POSIX")
            df.timeZone = TimeZone(secondsFromGMT: 0)
            df.dateFormat = "yyyy-MM-dd"
            if let d = df.date(from: str) { return d }

            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Expected ISO8601 timestamp or yyyy-MM-dd date string, but got: \(str)"
            )
        }

        return decoder
    }()
    
    private let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }()

    private func addAuthHeader(to request: inout URLRequest) throws {
        guard let token = UserDefaults.standard.string(forKey: "authToken"), !token.isEmpty else {
            throw APIError.unauthorized
        }
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }
    
    private init() {}
    
    // MARK: - Register
    func register(userId: String? = nil, name: String, crm: String, rqe: String?, phone: String?, emailAddress: String, password: String) async throws -> String {
        let url = URL(string: "\(baseURL)/register")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept") // ✅
        
        let body: [String: Any?] = [
            "userId": userId,
            "name": name,
            "crm": crm,
            "rqe": rqe,
            "phone": phone,
            "emailAddress": emailAddress,
            "password": password
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body.compactMapValues { $0 })
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.networkError
        }
        
        // ✅ Aceita 200 e 201
        if httpResponse.statusCode != 200 && httpResponse.statusCode != 201 {
            // ✅ Usa o mesmo decoder
            if let errorResponse = try? decoder.decode(ErrorResponse.self, from: data) {
                throw APIError.serverError(message: errorResponse.error)
            }
            throw APIError.serverError(message: "Erro desconhecido")
        }
        
        let result = try decoder.decode(RegisterResponse.self, from: data)
        return result.userId
    }
    
    // MARK: - Login
    func login(emailAddress: String, password: String) async throws -> LoginResponse {
        let url = URL(string: "\(baseURL)/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept") // ✅
        
        let body = [
            "emailAddress": emailAddress,
            "password": password
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.networkError
        }
        
        if httpResponse.statusCode == 401 {
            throw APIError.invalidCredentials
        }
        
        if httpResponse.statusCode != 200 {
            // ✅ Usa o mesmo decoder
            if let errorResponse = try? decoder.decode(ErrorResponse.self, from: data) {
                throw APIError.serverError(message: errorResponse.error)
            }
            throw APIError.serverError(message: "Erro desconhecido")
        }
        
        let result = try decoder.decode(LoginResponse.self, from: data)
        return result
    }
    
    // MARK: - Patients
    func createPatient(_ patient: PatientCreateRequest) async throws {
        let url = URL(string: "\(baseURL)/patients")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        try addAuthHeader(to: &request)

        request.httpBody = try encoder.encode(patient)

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else { throw APIError.networkError }

        if httpResponse.statusCode == 401 { throw APIError.unauthorized }
        if httpResponse.statusCode != 200 && httpResponse.statusCode != 201 {
            if let errorResponse = try? decoder.decode(ErrorResponse.self, from: data) {
                throw APIError.serverError(message: errorResponse.error)
            }
            throw APIError.serverError(message: "Erro desconhecido")
        }
    }

    func listPatients() async throws -> [PatientDTO] {
        let url = URL(string: "\(baseURL)/patients")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        try addAuthHeader(to: &request)

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else { throw APIError.networkError }

        if httpResponse.statusCode == 401 { throw APIError.unauthorized }
        if httpResponse.statusCode == 204 {
            return []
        }
        if httpResponse.statusCode != 200 && httpResponse.statusCode != 204 {
            if let errorResponse = try? decoder.decode(ErrorResponse.self, from: data) {
                throw APIError.serverError(message: errorResponse.error)
            }
            throw APIError.serverError(message: "Erro desconhecido")
        }

        return try decoder.decode(PatientsListResponse.self, from: data).patients
    }

    func getPatient(patientId: String) async throws -> PatientDTO {
        let url = URL(string: "\(baseURL)/patients/\(patientId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        try addAuthHeader(to: &request)

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else { throw APIError.networkError }

        if httpResponse.statusCode == 401 { throw APIError.unauthorized }
        if httpResponse.statusCode != 200 && httpResponse.statusCode != 204 {
            if let errorResponse = try? decoder.decode(ErrorResponse.self, from: data) {
                throw APIError.serverError(message: errorResponse.error)
            }
            throw APIError.serverError(message: "Erro desconhecido")
        }

        return try decoder.decode(PatientSingleResponse.self, from: data).patient
    }

    func updatePatient(patientId: String, cns: String? = nil, name: String? = nil, birthDate: Date? = nil, sex: String? = nil) async throws {
        let url = URL(string: "\(baseURL)/patients/\(patientId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        try addAuthHeader(to: &request)

        struct Body: Codable {
            let cns: String?
            let name: String?
            let birthDate: DateOnly?
            let sex: String?
        }

        request.httpBody = try encoder.encode(
            Body(cns: cns, name: name, birthDate: birthDate.map(DateOnly.init), sex: sex)
        )

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else { throw APIError.networkError }

        if httpResponse.statusCode == 401 { throw APIError.unauthorized }
        if httpResponse.statusCode != 200 && httpResponse.statusCode != 204 {
            if let errorResponse = try? decoder.decode(ErrorResponse.self, from: data) {
                throw APIError.serverError(message: errorResponse.error)
            }
            throw APIError.serverError(message: "Erro desconhecido")
        }
    }
    
    func deletePatient(patientId: String) async throws {
        let url = URL(string: "\(baseURL)/patients/\(patientId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        try addAuthHeader(to: &request)

        let (_, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.networkError
        }

        if httpResponse.statusCode == 401 { throw APIError.unauthorized }
        if httpResponse.statusCode != 200 && httpResponse.statusCode != 204 {
            throw APIError.serverError(message: "Erro ao deletar paciente")
        }
    }
    
    func syncPatientsChanges(lastSyncedAt: Date?) async throws -> PatientsSyncResponse {
        var urlString = "\(baseURL)/patients/sync/changes"
        
        if let lastSync = lastSyncedAt {
            let isoDate = ISO8601DateFormatter().string(from: lastSync)
            urlString += "?lastSyncedAt=\(isoDate)"
        }
        
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        try addAuthHeader(to: &request)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else { throw APIError.networkError }
        print("🌐 syncPatientsChanges HTTP:", httpResponse.statusCode)
        let bodyPreview = String(data: data, encoding: .utf8) ?? "<sem body>"
        print("🌐 syncPatientsChanges BODY:", bodyPreview.isEmpty ? "<vazio>" : bodyPreview)
        
        if httpResponse.statusCode == 401 { throw APIError.unauthorized }
        if httpResponse.statusCode == 204 {
            return PatientsSyncResponse(patients: [], serverTime: ISO8601DateFormatter().string(from: Date()))
        }
        if httpResponse.statusCode != 200 {
            if let errorResponse = try? decoder.decode(ErrorResponse.self, from: data) {
                throw APIError.serverError(message: errorResponse.error)
            }
            let bodyText = String(data: data, encoding: .utf8) ?? "<sem body>"
            throw APIError.serverError(message: "Erro desconhecido (HTTP \(httpResponse.statusCode)) - \(bodyText)")
        }
        
        return try decoder.decode(PatientsSyncResponse.self, from: data)
    }

    // MARK: - Sync Response
    struct PatientsSyncResponse: Codable {
        let patients: [PatientDTO]
        let serverTime: String
    }
}

// MARK: - Response Models
struct RegisterResponse: Codable {
    let success: Bool
    let userId: String
}

struct LoginResponse: Codable {
    let token: String
    let mustResetPassword: Bool?
    let user: UserData
}

struct UserData: Codable {
    let userId: String
    let name: String
    let crm: String
    let rqe: String?
    let phone: String?
    let emailAddress: String
    let createdAt: Date
}

struct ErrorResponse: Codable {
    let error: String
}

// MARK: - Patient Models
struct PatientCreateRequest: Codable {
    let patientId: String
    let cns: String
    let name: String
    let birthDate: DateOnly
    let sex: String

    init(patientId: String, cns: String, name: String, birthDate: Date, sex: String) {
        self.patientId = patientId
        self.cns = cns
        self.name = name
        self.birthDate = DateOnly(birthDate)
        self.sex = sex
    }
}

struct PatientDTO: Codable {
    let patientId: String
    let cns: String
    let name: String
    let birthDate: Date
    let sex: String
    let createdByUserId: String
    let updatedByUserId: String?
    let createdAt: Date
    let updatedAt: Date?
    let lastActivityAt: Date

    private enum CodingKeys: String, CodingKey {
        case patientId, cns, name, birthDate, sex, createdByUserId, updatedByUserId, createdAt, updatedAt, lastActivityAt
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        patientId = try c.decode(String.self, forKey: .patientId)
        cns = try c.decode(String.self, forKey: .cns)
        name = try c.decode(String.self, forKey: .name)
        birthDate = try c.decode(DateOnly.self, forKey: .birthDate).date
        sex = try c.decode(String.self, forKey: .sex)
        createdByUserId = try c.decode(String.self, forKey: .createdByUserId)
        updatedByUserId = try c.decodeIfPresent(String.self, forKey: .updatedByUserId)
        createdAt = try c.decode(Date.self, forKey: .createdAt)
        updatedAt = try c.decodeIfPresent(Date.self, forKey: .updatedAt)
        lastActivityAt = try c.decode(Date.self, forKey: .lastActivityAt)
    }

    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encode(patientId, forKey: .patientId)
        try c.encode(cns, forKey: .cns)
        try c.encode(name, forKey: .name)
        try c.encode(DateOnly(birthDate), forKey: .birthDate)
        try c.encode(sex, forKey: .sex)
        try c.encode(createdByUserId, forKey: .createdByUserId)
        try c.encodeIfPresent(updatedByUserId, forKey: .updatedByUserId)
        try c.encode(createdAt, forKey: .createdAt)
        try c.encodeIfPresent(updatedAt, forKey: .updatedAt)
        try c.encode(lastActivityAt, forKey: .lastActivityAt)
    }
}

struct PatientsListResponse: Codable {
    let patients: [PatientDTO]
}

struct PatientSingleResponse: Codable {
    let patient: PatientDTO
}

// MARK: - Errors
enum APIError: LocalizedError {
    case networkError
    case serverError(message: String)
    case invalidCredentials
    case unauthorized
    
    var errorDescription: String? {
        switch self {
        case .networkError:
            return "Erro de conexão. Verifique sua internet."
        case .serverError(let message):
            return message
        case .invalidCredentials:
            return "Email ou senha inválidos"
        case .unauthorized:
            return "Sessão expirada. Faça login novamente."
        }
    }
}
