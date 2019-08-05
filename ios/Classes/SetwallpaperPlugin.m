#import "SetwallpaperPlugin.h"
#import <setwallpaper/setwallpaper-Swift.h>

@implementation SetwallpaperPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSetwallpaperPlugin registerWithRegistrar:registrar];
}
@end
