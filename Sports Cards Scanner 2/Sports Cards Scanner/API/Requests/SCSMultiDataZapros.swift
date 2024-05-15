import Foundation

struct SportivinieKartiMultiDataZapros {
    private let boundary: String = UUID().uuidString
    private var httpBody = NSMutableData()
    let url: URL

    init(url: URL) {
        self.url = url
    }

    func dobavitTextPole(named name: String, value: String) {
        httpBody.dobavitStroky(textFormaPole(named: name, value: value))
    }

    func dobavitDataPole(named name: String, filename: String, data: Data, mimeType: String) {

        httpBody.append(dataFormaPole(named: name, filename: filename, data: data, mimeType: mimeType))
    }

    func asURLRequest() -> URLRequest {
        var request = URLRequest(url: url)

        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        httpBody.dobavitStroky("--\(boundary)--")
        request.httpBody = httpBody as Data
        return request
    }

    private func textFormaPole(named name: String, value: String) -> String {
        var fieldString = "--\(boundary)\r\n"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
        fieldString += "Content-Type: text/plain; charset=ISO-8859-1\r\n"
        fieldString += "Content-Transfer-Encoding: 8bit\r\n"
        fieldString += "\r\n"
        fieldString += "\(value)\r\n"

        return fieldString
    }

    private func dataFormaPole(
        named name: String,
        filename: String,
        data: Data,
        mimeType: String
    ) -> Data {
        let fieldData = NSMutableData()

        fieldData.dobavitStroky("--\(boundary)\r\n")
        fieldData.dobavitStroky("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(filename)\"\r\n")
        fieldData.dobavitStroky("Content-Type: \(mimeType)\r\n")
        fieldData.dobavitStroky("\r\n")
        fieldData.append(data)
        fieldData.dobavitStroky("\r\n")

        return fieldData as Data
    }
}

extension NSMutableData {
    func dobavitStroky(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
