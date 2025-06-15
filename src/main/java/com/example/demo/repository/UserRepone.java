package com.example.demo.repository;

import com.example.demo.Entity.User;
import java.util.*;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepone extends JpaRepository<User, Integer > {
    Optional<User> findByNameAndPassword(String name, String password);

    List<User> findByIdIn(List<Integer> id);
}
