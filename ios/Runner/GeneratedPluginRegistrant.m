//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<emoji_picker_flutter/EmojiPickerFlutterPlugin.h>)
#import <emoji_picker_flutter/EmojiPickerFlutterPlugin.h>
#else
@import emoji_picker_flutter;
#endif

#if __has_include(<flutter_ringtone_player/FlutterRingtonePlayerPlugin.h>)
#import <flutter_ringtone_player/FlutterRingtonePlayerPlugin.h>
#else
@import flutter_ringtone_player;
#endif

#if __has_include(<permission_handler_apple/PermissionHandlerPlugin.h>)
#import <permission_handler_apple/PermissionHandlerPlugin.h>
#else
@import permission_handler_apple;
#endif

#if __has_include(<resonance/ResonancePlugin.h>)
#import <resonance/ResonancePlugin.h>
#else
@import resonance;
#endif

#if __has_include(<shared_preferences_ios/FLTSharedPreferencesPlugin.h>)
#import <shared_preferences_ios/FLTSharedPreferencesPlugin.h>
#else
@import shared_preferences_ios;
#endif

#if __has_include(<sms_advanced/UssdAdvancedPlugin.h>)
#import <sms_advanced/UssdAdvancedPlugin.h>
#else
@import sms_advanced;
#endif

#if __has_include(<telephony/TelephonyPlugin.h>)
#import <telephony/TelephonyPlugin.h>
#else
@import telephony;
#endif

#if __has_include(<url_launcher_ios/FLTURLLauncherPlugin.h>)
#import <url_launcher_ios/FLTURLLauncherPlugin.h>
#else
@import url_launcher_ios;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [EmojiPickerFlutterPlugin registerWithRegistrar:[registry registrarForPlugin:@"EmojiPickerFlutterPlugin"]];
  [FlutterRingtonePlayerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterRingtonePlayerPlugin"]];
  [PermissionHandlerPlugin registerWithRegistrar:[registry registrarForPlugin:@"PermissionHandlerPlugin"]];
  [ResonancePlugin registerWithRegistrar:[registry registrarForPlugin:@"ResonancePlugin"]];
  [FLTSharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharedPreferencesPlugin"]];
  [UssdAdvancedPlugin registerWithRegistrar:[registry registrarForPlugin:@"UssdAdvancedPlugin"]];
  [TelephonyPlugin registerWithRegistrar:[registry registrarForPlugin:@"TelephonyPlugin"]];
  [FLTURLLauncherPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTURLLauncherPlugin"]];
}

@end
