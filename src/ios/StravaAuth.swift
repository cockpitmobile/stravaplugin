import Foundation

@objc(StravaAuth) class StravaAuth: CDVPlugin {
    @objc(authorize:) func authorize(command: CDVInvokedUrlCommand) {
        let state = command.arguments[0]
        let callbackUri = command.arguments[1]

        let appOAuthUrlStravaScheme = URL(string: "strava://oauth/mobile/authorize?client_id=45576&redirect_uri=\(callbackUri)&response_type=code&approval_prompt=auto&scope=activity:read_all&state=\(state)")!
        
        if UIApplication.shared.canOpenURL(appOAuthUrlStravaScheme) {
            UIApplication.shared.open(appOAuthUrlStravaScheme, options: [:])
            let pluginResult = CDVPluginResult(
                status: CDVCommandStatus_OK
            )
            self.commandDelegate!.send(
                pluginResult,
                callbackId: command.callbackId
            )
        } else {
            let pluginResult = CDVPluginResult(
                status: CDVCommandStatus_ERROR
            )
            
            self.commandDelegate!.send(
                pluginResult,
                callbackId: command.callbackId
            )
        }
    }
}
