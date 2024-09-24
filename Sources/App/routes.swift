//import Vapor
//
//func routes(_ app: Application) throws {
//    app.get { req async throws in
//        try await req.view.render("index", ["title": "Hello Vapor!"])
//    }
//
//    app.get("hello") { req async -> String in
//        "Hello, world!"
//    }
//}

import Leaf
import Vapor

import Vapor

struct Project: Codable, Identifiable {
    var id = UUID()
    let name: String
    let description: String
    let image: String
    let link: String
}

struct ViewContext: Encodable {
    let projects: [Project]
    let language: String
}



func routes(_ app: Application) throws {

    let projects: [Project] = [
        Project(name: "Steam Machine", description: "Approach to a business idea from the conception of the idea to the tragic end. “The best MVP is the one that tells you it's not going to work before you've invested your money in it. The paper holds everything, if on paper the accounts don't work out...", image: "/Images/SteamMachine.jpg", link: "steamMachine"),
        Project(name: "VR Entrepreneurship Hub", description: "Step into a revolutionary virtual reality hub that merges cutting-edge technology with real-world solutions. Designed to empower businesses and users alike, this state-of-the-art VR center offers fully immersive experiences through VR and AR hardware. Whether for team-building sessions or innovative problem-solving, our platform unlocks new dimensions in engagement and efficiency.", image: "/Images/VR-ConceptArt.webp", link: "VR_EntrepreneurshipProject"),
        Project(name: "TFG - Loquo App", description: "Centered on the development of a native application in Swift focused on internal business communication. This includes the creation, prototyping, and testing of a comprehensive software product, designed specifically for Animal Care Technologies S.A. The project highlights the feasibility and practicality of using Swift for iOS app development within a business context, emphasizing efficient communication between employees./n/nThis project demonstrates both technical and organizational skills, from designing the app architecture to developing a viable business solution for internal communication .", image: "/Images/iphoneBackground.jpg", link: "loquo"),
        Project(name: "AI Designed merch - Ecommerce on demand", description: "This innovative project explored the potential of artificial intelligence in the world of on-demand merchandising. By integrating AI-generated designs and patterns with a print-on-demand service, the project demonstrated the ability to rapidly create and scale unique abstract art products for sale on Etsy. Every aspect of the product listings, from the designs to the titles and descriptions, was generated through AI, with the goal of testing the commercial viability of AI-created artwork./n/nThrough targeted ads and strategic listing optimization, also powered by AI, the project pushed the boundaries of e-commerce by blending creativity, technology, and automation, offering a glimpse into the future of digital entrepreneurship.", image: "/Images/eCommerceOnDemandAI.webp", link: "merchOnDemand"),
        Project(name: "Baretos Baratos iOS App Design", description: "An app that centralizes leisure activities in Zaragoza, allowing users to access services like taxis and bus schedules through Zaragoza's open API. It also offers the ability to purchase drink packages and access exclusive deals at participating venues. The app features a modern interface, supports both light and dark modes, and is focused on user-friendly design.", image: "/Images/BaretosBaratos/BBPreview.png", link: "baretosBaratos"),
        Project(name: "+Ocio iOS App Design", description: "+Ocio evolved from Baretos Baratos, initially focused on bars and restaurants, but after a viability study, it shifted towards being an app for low-cost social plans. In response to economic hardship and increasing social isolation among young people, +Ocio offers a way to boost social life. The app helps users plan affordable activities, allowing the new generation to connect and enjoy themselves without worrying about financial constraints.", image: "/Images/+Ocio/+OcioMainLogo.svg", link: "+Ocio"),
        Project(name: "The Good Programming - Logo redesign", description: "During my tenure at The Good Programming, I recognized an opportunity to enhance the company’s brand image by redesigning its original logo, created in the early days of the business. Leveraging my interest in design and marketing, I developed a proposal that reflects the company’s evolution and current values. This project allowed me to reciprocate the confidence placed in me as a developer by contributing a strategic renewal to the visual identity beyond my usual responsibilities.", image: "/Images/TGP/tgp_officialLogo.png", link: "tgpLogoRedesign"),
        Project(name: "Doom Kanban VisionOS App", description: "Doom Kanban Board is a gamified task management app using an interactive Kanban board with Apple Game Center integration. Users can track tasks, compete on leaderboards, unlock achievements in a 3D space, and experience a virtual office reacting to game events. It features immersive simulations with particles generated in Reality Composer Pro and a fictional chat between the PM and developer.", image: "/Images/DoomKanban/DoomKanbanPreview.webp", link: "doomKanban")
    ]

    // Middleware to handle language selection (this should be added to the app configuration)
        app.middleware.use(LanguageMiddleware())

        // Main route with language parameter
        app.get { req in
            let language = req.selectedLanguage // Aquí obtienes "en" o "es"
            
            // Cambiar el template según el idioma
            let template = "index_\(language)" // index_es o index_en
            
            let context = ViewContext(projects: projects, language: language)
            
            return req.view.render(template, context)
        }


        app.get("steamMachine") { req in
            let language = req.selectedLanguage
            return req.view.render("steamMachine_\(language)") // Serve language-specific template
        }

        app.get("VR_EntrepreneurshipProject") { req in
            let language = req.selectedLanguage
            return req.view.render("VR_EntrepreneurshipProject_\(language)") // Serve language-specific template
        }

        // Repeat this pattern for other routes
        app.get("loquo") { req in
            let language = req.selectedLanguage
            return req.view.render("loquo_\(language)")
        }

        app.get("merchOnDemand") { req in
            let language = req.selectedLanguage
            return req.view.render("merchOnDemand_\(language)")
        }

        app.get("baretosBaratos") { req in
            let language = req.selectedLanguage
            return req.view.render("baretosBaratos_\(language)")
        }

        app.get("+Ocio") { req in
            let language = req.selectedLanguage
            return req.view.render("+Ocio_\(language)")
        }

        app.get("tgpLogoRedesign") { req in
            let language = req.selectedLanguage
            return req.view.render("tgpLogoRedesign_\(language)")
        }

        app.get("doomKanban") { req in
            let language = req.selectedLanguage
            return req.view.render("doomKanban_\(language)")
        }
}
