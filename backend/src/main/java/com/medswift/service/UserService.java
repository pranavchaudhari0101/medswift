package com.medswift.service;

import com.medswift.dto.UserDto;
import com.medswift.exception.ResourceNotFoundException;
import com.medswift.model.Address;
import com.medswift.model.User;
import com.medswift.repository.AddressRepository;
import com.medswift.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final AddressRepository addressRepository;

    public UserService(UserRepository userRepository, AddressRepository addressRepository) {
        this.userRepository = userRepository;
        this.addressRepository = addressRepository;
    }

    public UserDto.UserResponse getProfile(Long userId) {
        User user = findUserById(userId);
        return mapToResponse(user);
    }

    public UserDto.UserResponse updateProfile(Long userId, UserDto.UpdateProfileRequest request) {
        User user = findUserById(userId);

        if (request.getName() != null)
            user.setName(request.getName());
        if (request.getEmail() != null)
            user.setEmail(request.getEmail());
        if (request.getDob() != null)
            user.setDob(LocalDate.parse(request.getDob()));
        if (request.getGender() != null)
            user.setGender(User.Gender.valueOf(request.getGender().toUpperCase()));

        user = userRepository.save(user);
        return mapToResponse(user);
    }

    public List<UserDto.AddressResponse> getAddresses(Long userId) {
        return addressRepository.findByUserId(userId).stream()
                .map(this::mapAddressToResponse)
                .collect(Collectors.toList());
    }

    public UserDto.AddressResponse addAddress(Long userId, UserDto.AddAddressRequest request) {
        User user = findUserById(userId);

        Address address = Address.builder()
                .user(user)
                .label(request.getLabel())
                .addressLine(request.getAddressLine())
                .landmark(request.getLandmark())
                .city(request.getCity())
                .state(request.getState())
                .pincode(request.getPincode())
                .latitude(request.getLatitude())
                .longitude(request.getLongitude())
                .isDefault(request.isDefault())
                .build();

        address = addressRepository.save(address);
        return mapAddressToResponse(address);
    }

    private User findUserById(Long userId) {
        return userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
    }

    private UserDto.UserResponse mapToResponse(User user) {
        return UserDto.UserResponse.builder()
                .id(user.getId())
                .name(user.getName())
                .email(user.getEmail())
                .phone(user.getPhone())
                .dob(user.getDob() != null ? user.getDob().toString() : null)
                .gender(user.getGender() != null ? user.getGender().name() : null)
                .profileImageUrl(user.getProfileImageUrl())
                .build();
    }

    private UserDto.AddressResponse mapAddressToResponse(Address address) {
        return UserDto.AddressResponse.builder()
                .id(address.getId())
                .label(address.getLabel())
                .addressLine(address.getAddressLine())
                .landmark(address.getLandmark())
                .city(address.getCity())
                .state(address.getState())
                .pincode(address.getPincode())
                .latitude(address.getLatitude())
                .longitude(address.getLongitude())
                .isDefault(address.isDefault())
                .build();
    }
}
