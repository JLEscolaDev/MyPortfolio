//
//  LanguageMiddleware.swift
//  MyPortfolio
//
//  Created by Jose Luis Escolá García on 24/9/24.
//


import Vapor

final class LanguageMiddleware: Middleware {
    func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        // Intentar obtener el parámetro 'lang' de la URL
        let languageQueryParam = request.query[String.self, at: "lang"]
        
        // Si no se proporciona el parámetro 'lang', usar el valor predeterminado de los encabezados
        let preferredLanguage = languageQueryParam ?? request.headers["Accept-Language"].first?.lowercased() ?? "es" // Default a español

        // Guardar el idioma seleccionado en el almacenamiento de la solicitud
        request.storage[SelectedLanguageKey.self] = preferredLanguage.contains("en") ? "en" : "es"

        // Continuar con la siguiente respuesta
        return next.respond(to: request)
    }
}

private struct SelectedLanguageKey: StorageKey {
    typealias Value = String
}

extension Request {
    var selectedLanguage: String {
        self.storage[SelectedLanguageKey.self] ?? "es" // Idioma predeterminado
    }
}
