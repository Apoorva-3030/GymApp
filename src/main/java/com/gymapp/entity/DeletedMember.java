package com.gymapp.entity;

import java.time.LocalDate;
import java.time.LocalDateTime;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "deleted_members")
public class DeletedMember {

	@Id
	private Long id;

	private String name;
	private String email;

	@ManyToOne
	private Plan plan;

	@ManyToOne
	private Trainer trainer;

	private LocalDate planStartDate;
	private LocalDate planExpiryDate;

	private LocalDateTime deletedAt;

	// Getters and setters
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

	public Plan getPlan() {
		return plan;
	}

	public void setPlan(Plan plan) {
		this.plan = plan;
	}

	public Trainer getTrainer() {
		return trainer;
	}

	public void setTrainer(Trainer trainer) {
		this.trainer = trainer;
	}

	public LocalDate getPlanStartDate() {
		return planStartDate;
	}

	public void setPlanStartDate(LocalDate planStartDate) {
		this.planStartDate = planStartDate;
	}

	public LocalDate getPlanExpiryDate() {
		return planExpiryDate;
	}

	public void setPlanExpiryDate(LocalDate planExpiryDate) {
		this.planExpiryDate = planExpiryDate;
	}

	public LocalDateTime getDeletedAt() {
		return deletedAt;
	}

	public void setDeletedAt(LocalDateTime deletedAt) {
		this.deletedAt = deletedAt;
	}

	public String getTrainerName() {
		return trainer != null ? trainer.getName() : "";
	}

	public String getPlanName() {
		return plan != null ? plan.getName() : "";
	}

}
