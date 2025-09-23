package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.Entity.Bill;
import com.example.demo.repository.BillRepository;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
@RequestMapping("/admin/bills")
public class AdminBillController {
    @Autowired
    private BillRepository billRepository;

    @GetMapping
    public String getAllBills(@RequestParam(required = false) String status, Model model){
        List<Bill> bills;
        if (status != null && !status.isEmpty()) {
            bills = billRepository.findByStatusOrderByCreateDateDesc(status);
        } else {
            bills = billRepository.findAll();
        }

        model.addAttribute("recentBills", bills);
        model.addAttribute("selectedStatus", status);
        return "admin/bills";
    }
}
    

