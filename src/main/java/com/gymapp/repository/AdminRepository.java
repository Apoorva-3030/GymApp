package com.gymapp.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.gymapp.entity.Admin;

public interface AdminRepository extends JpaRepository<Admin, Long> {
	Admin findByEmailAndPassword(String email, String password);
}
