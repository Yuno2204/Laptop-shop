package vn.DinhQuangDuc.mobileshop.dto;

public class ProductSearchDTO {
    private Long id;
    private String name;
    private double price;
    private long quantity;
    private String factory; // Bổ sung

    public ProductSearchDTO(Long id, String name, double price, long quantity, String factory) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
        this.factory = factory;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public long getQuantity() {
        return quantity;
    }

    public void setQuantity(long quantity) {
        this.quantity = quantity;
    }

    public String getFactory() {
        return factory;
    }

    public void setFactory(String factory) {
        this.factory = factory;
    }
}