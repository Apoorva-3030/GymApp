package com.gymapp.service;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gymapp.entity.DeletedMember;
import com.gymapp.entity.Member;
import com.gymapp.repository.DeletedMemberRepository;
import com.gymapp.repository.MemberRepository;

@Service
public class MemberService {

	@Autowired
	private MemberRepository memberRepository;

	@Autowired
	private DeletedMemberRepository deletedMemberRepository;

	public void deleteMember(Long memberId) {
		Member member = memberRepository.findById(memberId).orElseThrow(() -> new RuntimeException("Member not found"));

		// create DeletedMember object
		DeletedMember deleted = new DeletedMember();
		deleted.setId(member.getId());
		deleted.setName(member.getName());
		deleted.setEmail(member.getEmail());
		deleted.setPlan(member.getPlan());
		deleted.setTrainer(member.getTrainer());
		deleted.setPlanStartDate(member.getPlanStartDate());
		deleted.setPlanExpiryDate(member.getPlanExpiryDate());
		deleted.setDeletedAt(LocalDateTime.now());

		deletedMemberRepository.save(deleted); // save to deleted_members

		memberRepository.delete(member); // delete from members
	}

}
