package main

import (
	"database/sql"
	"log"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
	_ "github.com/lib/pq"
)

type User struct {
	ID    int    `json:"id"`
	Name  string `json:"name"`
	Email string `json:"email"`
}

type Response struct {
	Message string      `json:"message"`
	Status  string      `json:"status,omitempty"`
	Service string      `json:"service,omitempty"`
	Users   []User      `json:"users,omitempty"`
	Data    interface{} `json:"data,omitempty"`
}

func main() {
	r := gin.Default()

	// Database connection
	db, err := sql.Open("postgres", os.Getenv("DATABASE_URL"))
	if err != nil {
		log.Printf("Failed to connect to database: %v", err)
	}
	defer db.Close()

	// Routes
	r.GET("/", func(c *gin.Context) {
		response := Response{
			Message: "Go API is running!",
			Status:  "ok",
		}
		c.JSON(http.StatusOK, response)
	})

	r.GET("/health", func(c *gin.Context) {
		response := Response{
			Status:  "healthy",
			Service: "go",
		}
		c.JSON(http.StatusOK, response)
	})

	r.GET("/users", func(c *gin.Context) {
		if db == nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Database not connected"})
			return
		}

		rows, err := db.Query("SELECT id, name, email FROM users LIMIT 10")
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}
		defer rows.Close()

		var users []User
		for rows.Next() {
			var user User
			if err := rows.Scan(&user.ID, &user.Name, &user.Email); err != nil {
				c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
				return
			}
			users = append(users, user)
		}

		response := Response{Users: users}
		c.JSON(http.StatusOK, response)
	})

	r.POST("/users", func(c *gin.Context) {
		var user User
		if err := c.ShouldBindJSON(&user); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		if db == nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Database not connected"})
			return
		}

		err := db.QueryRow("INSERT INTO users (name, email) VALUES ($1, $2) RETURNING id", user.Name, user.Email).Scan(&user.ID)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}

		response := Response{
			Message: "User created successfully",
			Data:    user,
		}
		c.JSON(http.StatusOK, response)
	})

	log.Fatal(r.Run(":8081"))
}
