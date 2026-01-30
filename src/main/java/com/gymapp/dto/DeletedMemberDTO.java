package com.gymapp.dto;

import com.gymapp.entity.DeletedMember;

public class DeletedMemberDTO {
	public Long id;
	public String name;
	public String email;
	public String planName;
	public String trainerName;

	public DeletedMemberDTO(DeletedMember dm) {
		this.id = dm.getId();
		this.name = dm.getName();
		this.email = dm.getEmail();
		this.planName = dm.getPlan() != null ? dm.getPlan().getName() : "";
		this.trainerName = dm.getTrainer() != null ? dm.getTrainer().getName() : "";
	}
}
