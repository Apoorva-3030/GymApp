package com.gymapp.controller;

import com.gymapp.controller.AdminExportController;
import com.gymapp.entity.Member;
import com.gymapp.repository.MemberRepository;
import com.gymapp.repository.PlanRepository;
import com.gymapp.repository.TrainerRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.web.servlet.MockMvc;

import java.util.List;

import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(AdminExportController.class)
class ExportMembersExcelTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private MemberRepository memberRepo;

    @MockBean
    private TrainerRepository trainerRepo;

    @MockBean
    private PlanRepository planRepo;

    @Test
    void testExportMembersExcel() throws Exception {

        // ✅ FULLY INITIALIZED MEMBER
        Member member = new Member();
        member.setId(1L);
        member.setName("John Doe");
        member.setEmail("john@test.com");

        when(memberRepo.findAll()).thenReturn(List.of(member));

        mockMvc.perform(get("/admin/export/members/excel"))
                .andExpect(status().isOk())
                .andExpect(header().exists("Content-Disposition"))
                .andExpect(header().string(
                        "Content-Disposition",
                        "attachment; filename=members.xlsx"
                ));

        verify(memberRepo, times(1)).findAll();
    }
}
