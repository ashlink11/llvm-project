//===- DialectTransform.cpp - 'transform' dialect submodule ---------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "mlir-c/Dialect/Transform.h"
#include "mlir-c/IR.h"
#include "mlir-c/Support.h"
#include "mlir/Bindings/Python/PybindAdaptors.h"
#include <pybind11/cast.h>
#include <pybind11/detail/common.h>
#include <pybind11/pybind11.h>
#include <pybind11/pytypes.h>
#include <string>

namespace py = pybind11;
using namespace mlir;
using namespace mlir::python;
using namespace mlir::python::adaptors;

void populateDialectTransformSubmodule(const pybind11::module &m) {
  //===-------------------------------------------------------------------===//
  // AnyOpType
  //===-------------------------------------------------------------------===//

  auto anyOpType =
      mlir_type_subclass(m, "AnyOpType", mlirTypeIsATransformAnyOpType,
                         mlirTransformAnyOpTypeGetTypeID);
  anyOpType.def_classmethod(
      "get",
      [](py::object cls, MlirContext ctx) {
        return cls(mlirTransformAnyOpTypeGet(ctx));
      },
      "Get an instance of AnyOpType in the given context.", py::arg("cls"),
      py::arg("context") = py::none());

  //===-------------------------------------------------------------------===//
  // AnyParamType
  //===-------------------------------------------------------------------===//

  auto anyParamType =
      mlir_type_subclass(m, "AnyParamType", mlirTypeIsATransformAnyParamType,
                         mlirTransformAnyParamTypeGetTypeID);
  anyParamType.def_classmethod(
      "get",
      [](py::object cls, MlirContext ctx) {
        return cls(mlirTransformAnyParamTypeGet(ctx));
      },
      "Get an instance of AnyParamType in the given context.", py::arg("cls"),
      py::arg("context") = py::none());

  //===-------------------------------------------------------------------===//
  // AnyValueType
  //===-------------------------------------------------------------------===//

  auto anyValueType =
      mlir_type_subclass(m, "AnyValueType", mlirTypeIsATransformAnyValueType,
                         mlirTransformAnyValueTypeGetTypeID);
  anyValueType.def_classmethod(
      "get",
      [](py::object cls, MlirContext ctx) {
        return cls(mlirTransformAnyValueTypeGet(ctx));
      },
      "Get an instance of AnyValueType in the given context.", py::arg("cls"),
      py::arg("context") = py::none());

  //===-------------------------------------------------------------------===//
  // OperationType
  //===-------------------------------------------------------------------===//

  auto operationType =
      mlir_type_subclass(m, "OperationType", mlirTypeIsATransformOperationType,
                         mlirTransformOperationTypeGetTypeID);
  operationType.def_classmethod(
      "get",
      [](py::object cls, const std::string &operationName, MlirContext ctx) {
        MlirStringRef cOperationName =
            mlirStringRefCreate(operationName.data(), operationName.size());
        return cls(mlirTransformOperationTypeGet(ctx, cOperationName));
      },
      "Get an instance of OperationType for the given kind in the given "
      "context",
      py::arg("cls"), py::arg("operation_name"),
      py::arg("context") = py::none());
  operationType.def_property_readonly(
      "operation_name",
      [](MlirType type) {
        MlirStringRef operationName =
            mlirTransformOperationTypeGetOperationName(type);
        return py::str(operationName.data, operationName.length);
      },
      "Get the name of the payload operation accepted by the handle.");

  //===-------------------------------------------------------------------===//
  // ParamType
  //===-------------------------------------------------------------------===//

  auto paramType =
      mlir_type_subclass(m, "ParamType", mlirTypeIsATransformParamType,
                         mlirTransformParamTypeGetTypeID);
  paramType.def_classmethod(
      "get",
      [](py::object cls, MlirType type, MlirContext ctx) {
        return cls(mlirTransformParamTypeGet(ctx, type));
      },
      "Get an instance of ParamType for the given type in the given context.",
      py::arg("cls"), py::arg("type"), py::arg("context") = py::none());
  paramType.def_property_readonly(
      "type",
      [](MlirType type) {
        MlirType paramType = mlirTransformParamTypeGetType(type);
        return paramType;
      },
      "Get the type this ParamType is associated with.");
}

PYBIND11_MODULE(_mlirDialectsTransform, m) {
  m.doc() = "MLIR Transform dialect.";
  populateDialectTransformSubmodule(m);
}
