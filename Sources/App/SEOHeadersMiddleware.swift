import Vapor

final class SEOHeadersMiddleware: Middleware {
    func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        next.respond(to: request).map { response in
            let langQuery = request.query[String.self, at: "lang"]?.lowercased()
            let acceptLanguage = request.headers.first(name: .acceptLanguage)?.lowercased() ?? ""
            let language = (langQuery == "en" || acceptLanguage.contains("en")) ? "en" : "es"

            response.headers.replaceOrAdd(name: .contentLanguage, value: language == "en" ? "en-US" : "es-ES")
            response.headers.replaceOrAdd(name: .init("X-Robots-Tag"), value: "index, follow, max-snippet:-1, max-image-preview:large, max-video-preview:-1")
            response.headers.replaceOrAdd(name: .init("Referrer-Policy"), value: "strict-origin-when-cross-origin")

            let baseURL = "https://jle-escola-portfolio-2c4df8d68d6b.herokuapp.com"
            let path = request.url.path.isEmpty ? "/" : request.url.path
            let canonical = "\(baseURL)\(path)?lang=\(language)"
            let alternateES = "\(baseURL)\(path)?lang=es"
            let alternateEN = "\(baseURL)\(path)?lang=en"

            response.headers.replaceOrAdd(
                name: .link,
                value: "<\(canonical)>; rel=\"canonical\", <\(alternateES)>; rel=\"alternate\"; hreflang=\"es\", <\(alternateEN)>; rel=\"alternate\"; hreflang=\"en\", <\(baseURL)\(path)>; rel=\"alternate\"; hreflang=\"x-default\""
            )

            return response
        }
    }
}
