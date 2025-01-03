package main

import (
    "log"

    "github.com/gofiber/fiber/v2"
)

func main() {
    app := fiber.New()
    
    repo, err := NewRepository()
    if err != nil {
        log.Fatal(err)
    }
    defer repo.Close()
    
    service := NewService(repo)
    api := NewAPI(service)

    apiGroup := app.Group("/api")
    
    apiGroup.Post("/register", api.Register)
    apiGroup.Post("/login", api.Login)

    log.Fatal(app.Listen(":8080"))
}