package com.gymapp.repository;

import com.gymapp.entity.AdminMessage;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface AdminMessageRepository extends JpaRepository<AdminMessage, Long> {
	// Fetch all messages for a specific sender (Member or Trainer)
	List<AdminMessage> findBySenderIdAndSenderRole(Long senderId, String senderRole);

}
