@obj(StravaAuth) class StravaAuth: CDVPlugin {
    func authorize(command: CDVInvokedUrlCommand) {
        let state = command.arguments[0]
        let callbackUri = command.arguments[1]

        let appOAuthUrlStravaScheme = URL(string: "strava://oauth/mobile/authorize?client_id=45576&redirect_uri=\(callbackUri)&response_type=code&approval_prompt=auto&scope=read_all&state=\(state)")!

        let webOAuthUrl = URL(string: "https://www.strava.com/oauth/mobile/authorize?client_id=45576&redirect_uri=\(callbackUri)&response_type=code&approval_prompt=auto&scope=read_all&state=\(state)")!
        
        if UIApplication.shared.canOpenURL(appOAuthUrlstravaScheme) {
            UIApplication.shared.open(appOAuthUrlstravaScheme, options: [:])
        } else {
            authSession = SFAuthenticationSession(url: webOAuthUrl, callbackURLScheme: "com.CockpitMobile.VirtualRace://") { url, error in

            }

            authSession?.start()
        }
        
        let pluginResult = CDVPluginResult(
            status: CDVCommandStatus_OK
        )
        
        self.commandDelegate!.sendPluginResult(
        pluginResult,
        callbackId: command.callbackId
        )

    }
}
