package com.gymapp.repository;

import com.gymapp.entity.Member;
import com.gymapp.entity.Trainer;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MemberRepository extends JpaRepository<Member, Long> {
	Member findByEmailAndPassword(String email, String password);

	List<Member> findByTrainer(Trainer trainer);
}
