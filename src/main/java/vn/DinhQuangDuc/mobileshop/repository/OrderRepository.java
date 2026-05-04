package vn.DinhQuangDuc.mobileshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.DinhQuangDuc.mobileshop.domain.Order;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {

}
