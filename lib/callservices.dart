import 'package:chat/constant.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class Callservices {
  /// on App's user login
void onUserLogin( String id, String password) {
  /// 1.2.1. initialized ZegoUIKitPrebuiltCallInvitationService
  /// when app's user is logged in or re-logged in
  /// We recommend calling this method as soon as the user logs in to your app.
  ZegoUIKitPrebuiltCallInvitationService().init(
    appID: Constant.appID /*input your AppID*/,
    appSign: Constant.appSign /*input your AppSign*/,
    userID: id,
    userName: password,
    plugins: [ZegoUIKitSignalingPlugin()],
  );
}

/// on App's user logout
void onUserLogout() {
  /// 1.2.2. de-initialization ZegoUIKitPrebuiltCallInvitationService
  /// when app's user is logged out
  ZegoUIKitPrebuiltCallInvitationService().uninit();
}

}