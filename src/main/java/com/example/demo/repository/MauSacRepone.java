package com.example.demo.repository;

import com.example.demo.Entity.MauSac;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface MauSacRepone extends JpaRepository<MauSac, UUID> {
    
    @Query("SELECT ms FROM MauSac ms WHERE ms.maMauSac LIKE %?1% OR ms.tenMauSac LIKE %?1%")
    List<MauSac> search(String keyword);
    
    boolean existsByMaMauSac(String maMauSac);
    
    boolean existsByMaMauSacAndIdNot(String maMauSac, UUID id);
}