// RUN: rm -rf %t
// RUN: mkdir -p %t
//
// RUN: %swift -emit-module -module-name FooSwiftModule %S/Inputs/foo_swift_module.swift -o %t
// RUN: %swift -emit-module -module-name FooSwiftModuleOverlay %S/Inputs/foo_swift_module_overlay.swift -I %t -o %t
//
// RUN: %swift-ide-test -code-completion -source-filename %s -code-completion-token=TOP_LEVEL_1 -I %t > %t.txt
// RUN: FileCheck %s -check-prefix=TOP_LEVEL_1 < %t.txt
// RUN: FileCheck %s -check-prefix=NO_DUPLICATES < %t.txt

// TOP_LEVEL_1: Decl[FreeFunction]/OtherModule:     overlayedFoo()[#Void#]{{$}}
// TOP_LEVEL_1: Decl[FreeFunction]/OtherModule:     onlyInFooOverlay()[#Void#]{{$}}

// NO_DUPLICATES: overlayedFoo
// NO_DUPLICATES-NOT: overlayedFoo

import FooSwiftModuleOverlay

#^TOP_LEVEL_1^#

