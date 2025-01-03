package main

import (
	"fmt"
	"time"

	"github.com/farukbey09/mobil-backend/models"
	"github.com/golang-jwt/jwt/v5"
	"golang.org/x/crypto/bcrypt"
)

const (
    JWTSecret    = "saturn" 
    TokenExpiry  = time.Hour * 24 
)

type Service struct {
	Repository *Repository
}

func NewService(repository *Repository) *Service {
	return &Service{
		Repository: repository,
	}
}

// Register registers a new user
func (s *Service) Register(req *models.RegisterRequest) error {
	// Check if user exists
	existingUser, _ := s.Repository.FindUserByEmail(req.Email)
	if existingUser != nil {
		return fmt.Errorf("user already exists")
	}

	// Hash password
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(req.Password), bcrypt.DefaultCost)
	if err != nil {
		return err
	}

	// Create user
	user := &models.User{
		Email:    req.Email,
		Password: string(hashedPassword),
	}

	return s.Repository.CreateUser(user)
}

func (s *Service) Login(req *models.LoginRequest) (*models.TokenResponse, error) {
	user, err := s.Repository.FindUserByEmail(req.Email)
	if err != nil {
		return nil, fmt.Errorf("invalid credentials")
	}

	if err := bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(req.Password)); err != nil {
		return nil, fmt.Errorf("invalid credentials")
	}

	token, err := s.GenerateToken(user)
	if err != nil {
		return nil, err
	}

	return &models.TokenResponse{Token: token}, nil
}

func (s *Service) GenerateToken(user *models.User) (string, error) {
	claims := &models.JWTClaims{
		UserID: user.ID.Hex(),
		Email:  user.Email,
		RegisteredClaims: jwt.RegisteredClaims{
			ExpiresAt: jwt.NewNumericDate(time.Now().Add(TokenExpiry)),
		},
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	return token.SignedString([]byte(JWTSecret))
}

func (s *Service) ValidateToken(tokenString string) (*models.JWTClaims, error) {
	token, err := jwt.ParseWithClaims(tokenString, &models.JWTClaims{}, func(t *jwt.Token) (interface{}, error) {
		return []byte(JWTSecret), nil
	})

	if err != nil {
		return nil, err
	}

	if claims, ok := token.Claims.(*models.JWTClaims); ok && token.Valid {
		return claims, nil
	}

	return nil, fmt.Errorf("invalid token")
}
