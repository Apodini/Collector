
public enum ContextPropagation {

    public enum Key {
        public static var spanID = "trace-span-id"
        public static var traceID = "trace-id"
        public static var isSampled = "trace-sampling"
    }

    public enum Value {
        public static var `true` = "1"
        public static var `false` = "0"
    }

}
