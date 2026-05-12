package vn.DinhQuangDuc.mobileshop.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import vn.DinhQuangDuc.mobileshop.domain.Role;
import vn.DinhQuangDuc.mobileshop.domain.User;
import vn.DinhQuangDuc.mobileshop.dto.RegisterDTO;
import vn.DinhQuangDuc.mobileshop.dto.UserSearchDTO;
import vn.DinhQuangDuc.mobileshop.repository.OrderRepository;
import vn.DinhQuangDuc.mobileshop.repository.ProductRepository;
import vn.DinhQuangDuc.mobileshop.repository.RoleRepository;
import vn.DinhQuangDuc.mobileshop.repository.UserRepository;
import org.springframework.security.crypto.password.PasswordEncoder;

@Service
public class UserService {
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final ProductRepository productRepository;
    private final OrderRepository orderRepository;

    public UserService(UserRepository userRepository, RoleRepository roleRepository,
            ProductRepository productRepository, OrderRepository orderRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.productRepository = productRepository;
        this.orderRepository = orderRepository;
    }

    public String handleHello() {
        return "Hello from Service";
    }

    public List<User> getAllUsers() {
        return this.userRepository.findAll();
    }

    public List<User> getAllUsersByEmail(String email) {
        return this.userRepository.findOneByEmail(email);
    }

    public User handleSaveUser(User user) {
        User cen = this.userRepository.save(user);
        // System.out.println(cen);
        return cen;
    }

    public User getUserByID(long id) {
        return this.userRepository.findById(id);
    }

    public void deleteUser(long id) {
        this.userRepository.deleteById(id);
    }

    public Role getRoleByName(String name) {
        return this.roleRepository.findByName(name);
    }

    public User registerDTOtoUser(RegisterDTO registerDTO) {
        User user = new User();
        user.setFullName(registerDTO.getFirstName() + " " + registerDTO.getLastName());
        user.setEmail(registerDTO.getEmail());
        user.setPassword(registerDTO.getPassword());
        user.setAddress(registerDTO.getAddress());
        user.setPhone(registerDTO.getPhone());
        user.setGender(registerDTO.getGender());
        user.setDateOfBirth(registerDTO.getDateOfBirth());
        return user;
    }

    public boolean checkEmailExist(String email) {
        return this.userRepository.existsByEmail(email);
    }

    public User getUserByEmail(String email) {
        return this.userRepository.findByEmail(email);
    }

    public long countUsers() {
        return this.userRepository.count();
    }

    public long countProducts() {
        return this.productRepository.count();
    }

    public long countOrders() {
        return this.orderRepository.count();
    }

    public void updateUserProfile(User user) {
        User currentUser = this.getUserByID(user.getId());
        if (currentUser != null) {
            currentUser.setFullName(user.getFullName());
            currentUser.setPhone(user.getPhone());
            currentUser.setAddress(user.getAddress());
            currentUser.setGender(user.getGender());
            currentUser.setDateOfBirth(user.getDateOfBirth());
            this.userRepository.save(currentUser);
        }
    }

    public boolean checkOldPassword(User user, String oldPassword, PasswordEncoder passwordEncoder) {
        return passwordEncoder.matches(oldPassword, user.getPassword());
    }

    public void changePassword(User user, String newPassword, PasswordEncoder passwordEncoder) {
        user.setPassword(passwordEncoder.encode(newPassword));
        this.userRepository.save(user);
    }

    public List<User> searchUser(String keyword) {
        return userRepository.searchByKeyword(keyword);
    }

    public List<UserSearchDTO> searchUserAjax(String keyword) {
        List<User> users = keyword.isEmpty() ? userRepository.findAll() : userRepository.searchByKeyword(keyword);
        return users.stream().map(u -> new UserSearchDTO(
                u.getId(), u.getEmail(), u.getFullName(),
                u.getPhone(), // Truyền thêm phone
                u.getRole() != null ? u.getRole().getName() : "USER")).collect(Collectors.toList());
    }
}
