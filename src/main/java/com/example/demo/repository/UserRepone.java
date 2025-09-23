package com.example.demo.repository;

import com.example.demo.Entity.User;
import java.util.*;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepone extends JpaRepository<User, Long> {
    Optional<User> findByEmail(String email);

    List<User> findByCodeStartingWithOrderByCodeDesc(String code);

    List<User> findByIdIn(List<Long> id);

}
