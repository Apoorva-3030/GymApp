package com.gymapp.controller;



import com.gymapp.entity.AdminMessage;
import com.gymapp.entity.Member;
import com.gymapp.repository.AdminMessageRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDateTime;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
public class MessagesControllerTest {

    @Autowired
    private AdminMessageRepository messageRepo;

    @Test
    void testMemberCommunicationWithAdmin() {
        // Create a new member object to simulate a member communicating with the admin
        Member member = new Member();
        member.setId(20L);
        member.setName("Communicating Member");

        // Create a new message object
        AdminMessage msg = new AdminMessage();
        msg.setSenderId(member.getId());
        msg.setSenderName(member.getName());
        msg.setSenderRole("Member");
        msg.setMessage("Need support");
        msg.setSentAt(LocalDateTime.now());

        // Save the message in the repository
        AdminMessage savedMessage = messageRepo.save(msg);

        // Assertions to verify that the message is saved correctly
        assertThat(savedMessage.getId()).isNotNull();  // Verify message is saved (ID should be generated)
        assertThat(savedMessage.getMessage()).isEqualTo("Need support");  // Verify the message content
        assertThat(savedMessage.getSenderRole()).isEqualTo("Member");  // Verify sender's role
        assertThat(savedMessage.getSenderId()).isEqualTo(member.getId());  // Verify the sender's ID
        assertThat(savedMessage.getSenderName()).isEqualTo(member.getName());  // Verify the sender's name
        assertThat(savedMessage.getSentAt()).isNotNull();  // Verify the timestamp is set correctly
    }
}
