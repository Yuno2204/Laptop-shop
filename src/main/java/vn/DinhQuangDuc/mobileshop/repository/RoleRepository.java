package vn.DinhQuangDuc.mobileshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.DinhQuangDuc.mobileshop.domain.Role;

@Repository

public interface RoleRepository extends JpaRepository<Role, Long> {

    Role findByName(String name);

}
