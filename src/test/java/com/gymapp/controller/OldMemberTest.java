package com.gymapp.controller;


import com.gymapp.entity.Member;
import com.gymapp.repository.MemberRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDate;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
public class OldMemberTest {

    @Autowired
    private MemberRepository memberRepo;

    @Test
    void testOldMemberStorage() {
        // Create a new member object with the specified details
        Member member = new Member();
        member.setName("Old Member");
        member.setEmail("old@member.com");
        member.setPlanExpiryDate(LocalDate.of(2025, 1, 1));

        // Save the member to the repository
        Member savedMember = memberRepo.save(member);

        // Assert that the member ID is not null (meaning it was saved properly)
        assertThat(savedMember.getId()).isNotNull();

        // Assert that the plan expiry date is correct
        assertThat(savedMember.getPlanExpiryDate()).isEqualTo(LocalDate.of(2025, 1, 1));

        // Optional: Fetch the saved member again from the database and verify the values
        Member fetchedMember = memberRepo.findById(savedMember.getId()).orElse(null);
        assertThat(fetchedMember).isNotNull();
        assertThat(fetchedMember.getName()).isEqualTo("Old Member");
        assertThat(fetchedMember.getEmail()).isEqualTo("old@member.com");
        assertThat(fetchedMember.getPlanExpiryDate()).isEqualTo(LocalDate.of(2025, 1, 1));
    }
}
