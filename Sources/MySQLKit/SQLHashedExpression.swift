import enum Crypto.Insecure
import Foundation

/// Hashes an expression
struct SQLHashedExpression: SQLExpression {
    let expression: SQLExpression

    init(_ expression: SQLExpression) {
        self.expression = expression
    }

    func serialize(to serializer: inout SQLSerializer) {
        var temp = SQLSerializer(database: serializer.database)
        self.expression.serialize(to: &temp)
        let hashed = String(describing: Insecure.SHA1.hash(data: Data(temp.sql.utf8)))
        serializer.write(hashed)
    }
}