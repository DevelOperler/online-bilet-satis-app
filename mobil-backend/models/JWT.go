package models

import (
	"github.com/golang-jwt/jwt/v5"
)

type JWTClaims struct {
	UserID string `json:"user_id"`

	Email string `json:"email"`

	jwt.RegisteredClaims
}

func (c *JWTClaims) GetAudience() (jwt.ClaimStrings, error) {

	return c.Audience, nil

}

type TokenResponse struct {
	Token string `json:"token"`
}
