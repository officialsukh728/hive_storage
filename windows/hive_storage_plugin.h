#ifndef FLUTTER_PLUGIN_HIVE_STORAGE_PLUGIN_H_
#define FLUTTER_PLUGIN_HIVE_STORAGE_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace hive_storage {

class HiveStoragePlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  HiveStoragePlugin();

  virtual ~HiveStoragePlugin();

  // Disallow copy and assign.
  HiveStoragePlugin(const HiveStoragePlugin&) = delete;
  HiveStoragePlugin& operator=(const HiveStoragePlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace hive_storage

#endif  // FLUTTER_PLUGIN_HIVE_STORAGE_PLUGIN_H_
