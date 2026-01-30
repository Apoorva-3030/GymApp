package com.gymapp.controller;

import com.gymapp.controller.AdminExportController;
import com.gymapp.entity.Member;
import com.gymapp.repository.MemberRepository;
import com.gymapp.repository.TrainerRepository;
import com.gymapp.repository.PlanRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.web.servlet.MockMvc;

import java.util.List;

import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.header;

@WebMvcTest(AdminExportController.class)
public class AdminExportPdfTest {

	@Autowired
	private MockMvc mockMvc;

	@MockBean
	private MemberRepository memberRepo;

	@MockBean
	private TrainerRepository trainerRepo;

	@MockBean
	private PlanRepository planRepo;

	@Test
	void testExportMembersPDF() throws Exception {
		// Prepare mock data: Assuming you have a Member entity with name and ID
		Member member = new Member();
		member.setId(1L);
		member.setName("John Doe");

		// Mock the repository to return a list of members
		when(memberRepo.findAll()).thenReturn(List.of(member));

		// Perform GET request to trigger PDF export
		mockMvc.perform(get("/admin/export/members/pdf")).andExpect(status().isOk()) // Expecting a 200 OK status
				.andExpect(content().contentType("application/pdf")) // Expecting the response to be of type PDF
				// Update the expected header to match actual response (no quotes around
				// filename)
				.andExpect(header().string("Content-Disposition", "attachment; filename=members.pdf"));

		// Verify the interaction with the repository
		verify(memberRepo, times(1)).findAll();
	}
}
