package com.medswift.service;

import com.medswift.dto.AuthDto;
import com.medswift.exception.BadRequestException;
import com.medswift.model.User;
import com.medswift.repository.UserRepository;
import com.medswift.security.JwtTokenProvider;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AuthService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtTokenProvider tokenProvider;

    public AuthService(UserRepository userRepository, PasswordEncoder passwordEncoder, JwtTokenProvider tokenProvider) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.tokenProvider = tokenProvider;
    }

    public AuthDto.AuthResponse register(AuthDto.RegisterRequest request) {
        if (userRepository.existsByPhone(request.getPhone())) {
            throw new BadRequestException("Phone number already registered");
        }

        User user = User.builder()
                .name(request.getName())
                .phone(request.getPhone())
                .email(request.getEmail())
                .password(passwordEncoder.encode(request.getPassword()))
                .role(User.Role.USER)
                .build();

        user = userRepository.save(user);
        String token = tokenProvider.generateToken(user.getPhone(), user.getId());

        return AuthDto.AuthResponse.builder()
                .token(token)
                .tokenType("Bearer")
                .userId(user.getId())
                .name(user.getName())
                .phone(user.getPhone())
                .role(user.getRole().name())
                .build();
    }

    public AuthDto.AuthResponse login(AuthDto.LoginRequest request) {
        User user = userRepository.findByPhone(request.getPhone())
                .orElseThrow(() -> new BadRequestException("Invalid phone or password"));

        if (!passwordEncoder.matches(request.getPassword(), user.getPassword())) {
            throw new BadRequestException("Invalid phone or password");
        }

        String token = tokenProvider.generateToken(user.getPhone(), user.getId());

        return AuthDto.AuthResponse.builder()
                .token(token)
                .tokenType("Bearer")
                .userId(user.getId())
                .name(user.getName())
                .phone(user.getPhone())
                .role(user.getRole().name())
                .build();
    }
}
