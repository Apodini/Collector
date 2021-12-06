//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: collector.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import GRPC
import NIO
import SwiftProtobuf


/// Usage: instantiate `Jaeger_ApiV2_CollectorServiceClient`, then call methods of this protocol to make API calls.
internal protocol Jaeger_ApiV2_CollectorServiceClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Jaeger_ApiV2_CollectorServiceClientInterceptorFactoryProtocol? { get }

  func postSpans(
    _ request: Jaeger_ApiV2_PostSpansRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Jaeger_ApiV2_PostSpansRequest, Jaeger_ApiV2_PostSpansResponse>
}

extension Jaeger_ApiV2_CollectorServiceClientProtocol {
  internal var serviceName: String {
    return "jaeger.api_v2.CollectorService"
  }

  /// Unary call to PostSpans
  ///
  /// - Parameters:
  ///   - request: Request to send to PostSpans.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func postSpans(
    _ request: Jaeger_ApiV2_PostSpansRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Jaeger_ApiV2_PostSpansRequest, Jaeger_ApiV2_PostSpansResponse> {
    return self.makeUnaryCall(
      path: "/jaeger.api_v2.CollectorService/PostSpans",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makePostSpansInterceptors() ?? []
    )
  }
}

internal protocol Jaeger_ApiV2_CollectorServiceClientInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when invoking 'postSpans'.
  func makePostSpansInterceptors() -> [ClientInterceptor<Jaeger_ApiV2_PostSpansRequest, Jaeger_ApiV2_PostSpansResponse>]
}

internal final class Jaeger_ApiV2_CollectorServiceClient: Jaeger_ApiV2_CollectorServiceClientProtocol {
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Jaeger_ApiV2_CollectorServiceClientInterceptorFactoryProtocol?

  /// Creates a client for the jaeger.api_v2.CollectorService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Jaeger_ApiV2_CollectorServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

/// To build a server, implement a class that conforms to this protocol.
internal protocol Jaeger_ApiV2_CollectorServiceProvider: CallHandlerProvider {
  var interceptors: Jaeger_ApiV2_CollectorServiceServerInterceptorFactoryProtocol? { get }

  func postSpans(request: Jaeger_ApiV2_PostSpansRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Jaeger_ApiV2_PostSpansResponse>
}

extension Jaeger_ApiV2_CollectorServiceProvider {
  internal var serviceName: Substring { return "jaeger.api_v2.CollectorService" }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "PostSpans":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Jaeger_ApiV2_PostSpansRequest>(),
        responseSerializer: ProtobufSerializer<Jaeger_ApiV2_PostSpansResponse>(),
        interceptors: self.interceptors?.makePostSpansInterceptors() ?? [],
        userFunction: self.postSpans(request:context:)
      )

    default:
      return nil
    }
  }
}

internal protocol Jaeger_ApiV2_CollectorServiceServerInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when handling 'postSpans'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makePostSpansInterceptors() -> [ServerInterceptor<Jaeger_ApiV2_PostSpansRequest, Jaeger_ApiV2_PostSpansResponse>]
}