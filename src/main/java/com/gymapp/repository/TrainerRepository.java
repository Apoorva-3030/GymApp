package com.gymapp.repository;

import com.gymapp.entity.Trainer;

import org.springframework.data.jpa.repository.JpaRepository;

public interface TrainerRepository extends JpaRepository<Trainer, Long> {
	Trainer findByEmailAndPassword(String email, String password);
}
