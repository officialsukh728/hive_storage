//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <hive_storage/hive_storage_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) hive_storage_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "HiveStoragePlugin");
  hive_storage_plugin_register_with_registrar(hive_storage_registrar);
}
