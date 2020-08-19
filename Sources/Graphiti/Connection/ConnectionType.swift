public final class ConnectionType<Resolver, Context, ObjectType : Encodable> : Component<Resolver, Context> {    
    override func update(typeProvider: SchemaTypeProvider) throws {
        if !typeProvider.contains(type: PageInfo.self) {
            let pageInfo = Type<Resolver, Context, PageInfo>(PageInfo.self) {
                Field("hasPreviousPage", at: \.hasPreviousPage)
                Field("hasNextPage", at: \.hasNextPage)
                Field("startCursor", at: \.startCursor)
                Field("endCursor", at: \.endCursor)
            }
        
            try pageInfo.update(typeProvider: typeProvider)
        }

        let edge = Type<Resolver, Context, Edge<ObjectType>>(Edge<ObjectType>.self) {
            Field("node", at: \.node)
            Field("cursor", at: \.cursor)
        }
        
        try edge.update(typeProvider: typeProvider)

        let connection = Type<Resolver, Context, Connection<ObjectType>>(Connection<ObjectType>.self) {
            Field("edges", at: \.edges)
            Field("pageInfo", at: \.pageInfo)
        }
        
        try connection.update(typeProvider: typeProvider)
    }
    
    private init(type: ObjectType.Type) {
        super.init(name: "")
    }
}

public extension ConnectionType {
    convenience init(_ type: ObjectType.Type) {
        self.init(type: type)
    }
}
