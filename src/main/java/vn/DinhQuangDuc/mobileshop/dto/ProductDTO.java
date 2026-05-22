package vn.DinhQuangDuc.mobileshop.dto;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;

public class ProductDTO {

    private long id;

    @NotBlank(message = "Tên sản phẩm không được để trống")
    private String name;

    @NotNull(message = "Giá không được để trống")
    @DecimalMin(value = "0.0", inclusive = false, message = "Giá phải lớn hơn 0")
    private Double price;

    private String image;

    @NotBlank(message = "Mô tả chi tiết không được để trống")
    private String detailDesc;

    @NotBlank(message = "Mô tả ngắn không được để trống")
    private String shortDesc;

    @NotNull(message = "Số lượng không được để trống")
    @Min(value = 0, message = "Số lượng không được âm")
    private Long quantity;

    private String factory;

    private String target;

    private String os;

    private String rom;

    private String ram;

    private String refreshRate;

    @NotBlank(message = "Chip không được để trống")
    private String cpu;

    @NotBlank(message = "Kích thước màn hình không được để trống")
    @Pattern(regexp = "^$|^\\d+(\\.\\d+)?\\s?(inch|''|\")$", message = "Kích thước màn hình phải theo định dạng. VD: 6.1 inch, 6.7\"")
    private String screenSize;

    @NotBlank(message = "Dung lượng pin không được để trống")
    @Pattern(regexp = "^$|^\\d+\\s?mAh$", message = "Dung lượng pin phải theo định dạng. VD: 5000mAh")
    private String battery;

    @NotBlank(message = "Công suất sạc nhanh không được để trống")
    @Pattern(regexp = "^$|^\\d+\\s?W$", message = "Sạc nhanh phải theo định dạng. VD: 20W, 120W")
    private String fastCharge;

    // Các hàm Getters và Setters cơ bản
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDetailDesc() {
        return detailDesc;
    }

    public void setDetailDesc(String detailDesc) {
        this.detailDesc = detailDesc;
    }

    public String getShortDesc() {
        return shortDesc;
    }

    public void setShortDesc(String shortDesc) {
        this.shortDesc = shortDesc;
    }

    public Long getQuantity() {
        return quantity;
    }

    public void setQuantity(Long quantity) {
        this.quantity = quantity;
    }

    public String getFactory() {
        return factory;
    }

    public void setFactory(String factory) {
        this.factory = factory;
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    public String getOs() {
        return os;
    }

    public void setOs(String os) {
        this.os = os;
    }

    public String getRom() {
        return rom;
    }

    public void setRom(String rom) {
        this.rom = rom;
    }

    public String getRam() {
        return ram;
    }

    public void setRam(String ram) {
        this.ram = ram;
    }

    public String getRefreshRate() {
        return refreshRate;
    }

    public void setRefreshRate(String refreshRate) {
        this.refreshRate = refreshRate;
    }

    public String getCpu() {
        return cpu;
    }

    public void setCpu(String cpu) {
        this.cpu = cpu;
    }

    public String getScreenSize() {
        return screenSize;
    }

    public void setScreenSize(String screenSize) {
        this.screenSize = screenSize;
    }

    public String getBattery() {
        return battery;
    }

    public void setBattery(String battery) {
        this.battery = battery;
    }

    public String getFastCharge() {
        return fastCharge;
    }

    public void setFastCharge(String fastCharge) {
        this.fastCharge = fastCharge;
    }
}