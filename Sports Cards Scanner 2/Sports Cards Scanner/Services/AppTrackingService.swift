import Foundation
import AppTrackingTransparency

final class AppTrackingService {
    @discardableResult
    func requestTracking() async -> ATTrackingManager.AuthorizationStatus {
        await ATTrackingManager.requestTrackingAuthorization()
    }
}
