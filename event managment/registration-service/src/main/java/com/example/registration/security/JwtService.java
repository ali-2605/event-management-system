package com.example.registration.security;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.security.Keys;
import java.nio.charset.StandardCharsets;
import java.util.UUID;
import javax.crypto.SecretKey;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class JwtService {

    private final SecretKey secretKey;

    public JwtService(@Value("${security.jwt.secret}") String secret) {
        this.secretKey = Keys.hmacShaKeyFor(secret.getBytes(StandardCharsets.UTF_8));
    }

    public AuthenticatedUser parseToken(String token) {
        Jws<Claims> claims = Jwts.parser().verifyWith(secretKey).build().parseSignedClaims(token);
        String subject = claims.getPayload().getSubject();
        String role = claims.getPayload().get("role", String.class);
        if (subject == null || role == null) {
            throw new JwtException("Missing required claims.");
        }
        return new AuthenticatedUser(UUID.fromString(subject), UserRole.valueOf(role));
    }
}
