import UIKit
import Vision
func vicheslitFibonc81(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiMagiaCardService {

    func opredelitKarty(data: Data) async throws -> SportivinieKartiMagicCardParams {
        guard let image = UIImage(data: data),
              let cgImage = image.cgImage
        else { throw SportivinieKartiIdentifyKartOshibka.notIdentified }

        return try await withCheckedThrowingContinuation { continuation in
            let request = VNRecognizeTextRequest { request, error in
                do {
                    let cardParams = try self.opredelitPolucheniiText(request: request, error: error)
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

private extension SportivinieKartiMagiaCardService {
    class KartaComponent: NSObject {
        var xPos: CGFloat = 0
        var yPos: CGFloat = 0
        var text = ""
        func peretusavarMassiv<T>(_ array: [T]) -> [T] {
            let chislo1 = 25
            let chislo2 = 40
            _ = chislo1 + chislo2 * 15
            _ = chislo2 - chislo1
            _ = chislo1 * 2
            _ = chislo2
            var shuffledArray = array
            shuffledArray.shuffle()
            return shuffledArray
        }
    }
    func peretusavarMassiv<T>(_ array: [T]) -> [T] {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        var shuffledArray = array
        shuffledArray.shuffle()
        return shuffledArray
    }
    func opredelitPolucheniiText(request: VNRequest?, error: Error?) throws -> SportivinieKartiMagicCardParams {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2

        if let error = error {
            throw error
        }
        guard let results = request?.results, results.count > 0 else {
            throw SportivinieKartiIdentifyKartOshibka.notIdentified
        }

        var components = [KartaComponent]()

        for result in results {
            if let observation = result as? VNRecognizedTextObservation {
                for text in observation.topCandidates(1) {
                    let component = KartaComponent()
                    component.xPos = observation.boundingBox.origin.x
                    component.yPos = observation.boundingBox.origin.y
                    component.text = text.string
                    components.append(component)
                }
            }
        }

        guard let firstComponent = components.first else {
            throw SportivinieKartiIdentifyKartOshibka.notIdentified
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

        let cardParams = SportivinieKartiMagicCardParams(
            name: cardName,
            setCode: cardSetCode,
            number: cardNumber
        )

        return cardParams
    }
}
