import UIKit
import Vision

final class MagicCardIdentifier {

    func identifyCard(data: Data) async throws -> MagicCardParams {
        guard let image = UIImage(data: data),
              let cgImage = image.cgImage
        else { throw IdentifyCardError.notIdentified }

        return try await withCheckedThrowingContinuation { continuation in
            let request = VNRecognizeTextRequest { request, error in
                do {
                    let cardParams = try self.handleDetectedText(request: request, error: error)
                    continuation.resume(returning: cardParams)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
            request.recognitionLevel = .accurate
            request.recognitionLanguages = ["en_GB"]

            let requests = [request]
            let imageRequestHandler = VNImageRequestHandler(cgImage: cgImage, orientation: .right)

            do {
                try imageRequestHandler.perform(requests)
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }

}

private extension MagicCardIdentifier {
    class CardComponent: NSObject {
        var xPos: CGFloat = 0
        var yPos: CGFloat = 0
        var text = ""
    }

    func handleDetectedText(request: VNRequest?, error: Error?) throws -> MagicCardParams {
        if let error = error {
            throw error
        }
        guard let results = request?.results, results.count > 0 else {
            throw IdentifyCardError.notIdentified
        }

        var components = [CardComponent]()

        for result in results {
            if let observation = result as? VNRecognizedTextObservation {
                for text in observation.topCandidates(1) {
                    let component = CardComponent()
                    component.xPos = observation.boundingBox.origin.x
                    component.yPos = observation.boundingBox.origin.y
                    component.text = text.string
                    components.append(component)
                }
            }
        }

        guard let firstComponent = components.first else {
            throw IdentifyCardError.notIdentified
        }

        let nameComponent = firstComponent
        var numberComponent = firstComponent
        var setComponent = firstComponent
        for component in components {
            if component.xPos < (numberComponent.xPos + 0.05) && component.yPos < numberComponent.yPos {
                numberComponent = setComponent
                setComponent = component
            }
        }

        let cardName = nameComponent.text
        let cardSetCode = String(setComponent.text.prefix(3))
        let cardNumber = String(numberComponent.text.prefix(3))

        let cardParams = MagicCardParams(
            name: cardName,
            setCode: cardSetCode,
            number: cardNumber
        )

        return cardParams
    }
}
