#include "include/hive_storage/hive_storage_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "hive_storage_plugin.h"

void HiveStoragePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  hive_storage::HiveStoragePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
