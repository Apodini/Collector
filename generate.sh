# Download the .proto files from GitHub
curl https://raw.githubusercontent.com/jaegertracing/jaeger-idl/master/proto/api_v2/collector.proto \
    --output ./Sources/JaegerCollector/Generated/collector.proto
curl https://raw.githubusercontent.com/jaegertracing/jaeger-idl/master/proto/api_v2/model.proto \
    --output ./Sources/JaegerCollector/Generated/model.proto

# Download the imports:
mkdir ./Sources/JaegerCollector/Generated/gogoproto
curl https://raw.githubusercontent.com/gogo/protobuf/master/gogoproto/gogo.proto \
    --output ./Sources/JaegerCollector/Generated/gogoproto/gogo.proto
    
mkdir ./Sources/JaegerCollector/Generated/google
mkdir ./Sources/JaegerCollector/Generated/google/api
curl https://raw.githubusercontent.com/googleapis/googleapis/master/google/api/annotations.proto \
    --output ./Sources/JaegerCollector/Generated/google/api/annotations.proto
curl https://raw.githubusercontent.com/googleapis/googleapis/master/google/api/http.proto \
    --output ./Sources/JaegerCollector/Generated/google/api/http.proto

# Run the protobuf compiler
protoc ./Sources/JaegerCollector/Generated/collector.proto \
    --proto_path=./Sources/JaegerCollector/Generated \
    --swift_out=./Sources/JaegerCollector/Generated \
    --grpc-swift_out=./Sources/JaegerCollector/Generated

protoc ./Sources/JaegerCollector/Generated/model.proto \
    --proto_path=./Sources/JaegerCollector/Generated \
    --swift_out=./Sources/JaegerCollector/Generated \
    --grpc-swift_out=./Sources/JaegerCollector/Generated
