package com.gymapp.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
public class Member {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String name;
	private String email;
	private String password;

	@ManyToOne
	@JoinColumn(name = "trainer_id")
	private Trainer trainer;

	@ManyToOne
	@JoinColumn(name = "plan_id")
	private Plan plan;

	private LocalDate planExpiryDate;

	public LocalDate getPlanExpiryDate() {
		return planExpiryDate;
	}

	public void setPlanExpiryDate(LocalDate planExpiryDate) {
		this.planExpiryDate = planExpiryDate;
	}

	private LocalDate planStartDate;

	public LocalDate getPlanStartDate() {
		return planStartDate;
	}

	public void setPlanStartDate(LocalDate planStartDate) {
		this.planStartDate = planStartDate;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Trainer getTrainer() {
		return trainer;
	}

	public void setTrainer(Trainer trainer) {
		this.trainer = trainer;
	}

	public Plan getPlan() {
		return plan;
	}

	public void setPlan(Plan plan) {
		this.plan = plan;
	}

}
