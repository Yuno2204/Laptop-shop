package vn.DinhQuangDuc.mobileshop.domain;

import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import vn.DinhQuangDuc.mobileshop.service.validator.StrongPassword;

@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    @NotNull
    @NotBlank(message = "Email không được để trống")
    @Email(message = "Email không hợp lệ")
    private String email;

    @NotBlank(message = "Mật khẩu không được để trống")
    // @Size(min = 6, max = 100, message = "Mật khẩu phải từ 6 đến 100 ký tự")
    @StrongPassword(message = "Phai co 8 ki tu")
    private String password;

    // @NotBlank(message = "Họ và tên không được để trống")
    // @Size(min = 3, max = 100, message = "Họ và tên phải từ 3 đến 100 ký tự")
    private String fullName;

    // @NotBlank(message = "Địa chỉ không được để trống")
    // @Size(max = 255, message = "Địa chỉ tối đa 255 ký tự")
    private String address;

    // @NotBlank(message = "Số điện thoại không được để trống")
    // @Pattern(regexp = "^(0|\\+84)\\d{9}$", message = "Số điện thoại không hợp
    // lệ")
    private String phone;
    private String avatar;

    private String gender;
    private String dateOfBirth;

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(String dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    // user id
    // many user to one role
    @ManyToOne
    @JoinColumn(name = "role_id")
    private Role role;

    @OneToMany(mappedBy = "user")
    private List<Order> orders;

    @OneToOne(mappedBy = "user")
    private Cart cart;

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public List<Order> getOrders() {
        return orders;
    }

    public void setOrders(List<Order> orders) {
        this.orders = orders;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public Cart getCart() {
        return cart;
    }

    public void setCart(Cart cart) {
        this.cart = cart;
    }

    @Override
    public String toString() {
        return "User [id=" + id + ", email=" + email + ", password=" + password +
                ", fullName=" + fullName + ", address=" + address +
                ", phone=" + phone + ", avatar=" + avatar +
                ", gender=" + gender + ", dateOfBirth=" + dateOfBirth + "]";
    }

}
