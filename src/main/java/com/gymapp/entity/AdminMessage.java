package com.gymapp.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "admin_messages")
public class AdminMessage {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	private String senderRole; // MEMBER or TRAINER
	private Long senderId;
	private String senderName;

	@Column(length = 2000)
	private String message;

	private LocalDateTime sentAt;

	// ADMIN REPLY
	@Column(length = 2000)
	private String adminReply;

	private LocalDateTime repliedAt;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getSenderRole() {
		return senderRole;
	}

	public void setSenderRole(String senderRole) {
		this.senderRole = senderRole;
	}

	public Long getSenderId() {
		return senderId;
	}

	public void setSenderId(Long senderId) {
		this.senderId = senderId;
	}

	public String getSenderName() {
		return senderName;
	}

	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public LocalDateTime getSentAt() {
		return sentAt;
	}

	public void setSentAt(LocalDateTime sentAt) {
		this.sentAt = sentAt;
	}

	public String getAdminReply() {
		return adminReply;
	}

	public void setAdminReply(String adminReply) {
		this.adminReply = adminReply;
	}

	public LocalDateTime getRepliedAt() {
		return repliedAt;
	}

	public void setRepliedAt(LocalDateTime repliedAt) {
		this.repliedAt = repliedAt;
	}

	// getters & setters
}
