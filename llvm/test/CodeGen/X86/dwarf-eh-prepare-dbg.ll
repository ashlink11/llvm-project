; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -mtriple=x86_64-linux-gnu -dwarf-eh-prepare < %s | FileCheck %s
; RUN: opt -S -mtriple=x86_64-linux-gnu -passes=dwarf-eh-prepare < %s | FileCheck %s

; PR57469: If _Unwind_Resume is defined in the same module and we have debug
; info, then the inserted _Unwind_Resume calls also need to have a dummy debug
; location to satisfy inlining requirements.

define void @_Unwind_Resume(ptr %ptr) !dbg !4 {
; CHECK-LABEL: @_Unwind_Resume(
; CHECK-NEXT:    ret void, !dbg [[DBG11:![0-9]+]]
;
  ret void, !dbg !11
}

declare i32 @__gxx_personality_v0(...)
declare void @might_throw()

define void @simple_cleanup_catch() personality ptr @__gxx_personality_v0 !dbg !12 {
; CHECK-LABEL: @simple_cleanup_catch(
; CHECK-NEXT:    invoke void @might_throw()
; CHECK-NEXT:    to label [[EXIT:%.*]] unwind label [[LANDINGPAD:%.*]], !dbg [[DBG15:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
; CHECK:       landingpad:
; CHECK-NEXT:    [[EX:%.*]] = landingpad { ptr, i32 }
; CHECK-NEXT:    cleanup
; CHECK-NEXT:    [[EXN_OBJ:%.*]] = extractvalue { ptr, i32 } [[EX]], 0
; CHECK-NEXT:    call void @_Unwind_Resume(ptr [[EXN_OBJ]]) #[[ATTR0:[0-9]+]], !dbg [[DBG16:![0-9]+]]
; CHECK-NEXT:    unreachable
;
  invoke void @might_throw()
  to label %exit unwind label %landingpad, !dbg !15

exit:
  ret void

landingpad:
  %ex = landingpad { ptr, i32 }
  cleanup
  resume { ptr, i32 } %ex
}

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 16.0.0 (https://github.com/llvm/llvm-project.git a4c8fb9d1f46f30c66a9ca0dd07c7933f338bb34)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/app/example.c", directory: "/app")
!2 = !{i32 7, !"Dwarf Version", i32 4}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = distinct !DISubprogram(name: "_Unwind_Resume", scope: !5, file: !5, line: 1, type: !6, scopeLine: 1, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !9)
!5 = !DIFile(filename: "example.c", directory: "/app")
!6 = !DISubroutineType(types: !7)
!7 = !{null, !8}
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!9 = !{!10}
!10 = !DILocalVariable(name: "exception", arg: 1, scope: !4, file: !5, line: 1, type: !8)
!11 = !DILocation(line: 2, column: 1, scope: !4)
!12 = distinct !DISubprogram(name: "test", scope: !5, file: !5, line: 4, type: !13, scopeLine: 4, flags: DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!13 = !DISubroutineType(types: !14)
!14 = !{null}
!15 = !DILocation(line: 6, column: 1, scope: !12)

; CHECK: [[DBG_SCOPE:![0-9]+]] = distinct !DISubprogram(name: "test"
; CHECK: [[DBG16]] = !DILocation(line: 0, scope: [[DBG_SCOPE]])
