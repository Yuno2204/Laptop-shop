package vn.DinhQuangDuc.mobileshop.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import vn.DinhQuangDuc.mobileshop.domain.Role;
import vn.DinhQuangDuc.mobileshop.service.validator.StrongPassword;

public class UserDTO {

    private long id;

    @NotNull
    @NotBlank(message = "Email không được để trống")
    @Email(message = "Email không hợp lệ")
    private String email;
    private Role role;
    @NotBlank(message = "Mật khẩu không được để trống")
    @StrongPassword(message = "Mật khẩu phải có ít nhất 8 ký tự")
    private String password;

    @NotBlank(message = "Họ và tên không được để trống")
    @Pattern(regexp = "^$|^.{3,36}$", message = "Họ và tên phải từ 3 đến 36 ký tự")
    private String fullName;

    @NotBlank(message = "Địa chỉ không được để trống")
    private String address;

    @NotBlank(message = "Số điện thoại không được để trống")
    @Pattern(regexp = "^$|^(0|\\+84)\\d{9}$", message = "Số điện thoại không hợp lệ ")
    private String phone;

    private String avatar;

    @NotBlank(message = "Vui lòng chọn giới tính")
    private String gender;

    @NotBlank(message = "Vui lòng nhập ngày sinh")
    private String dateOfBirth;

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
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
}