package vn.hoidanit.laptopshop.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import vn.hoidanit.laptopshop.domain.User;

@Repository
public interface UserRepository extends CrudRepository<User, Long> {
    User save(User cen);

    List<User> findByEmail(String email);
}