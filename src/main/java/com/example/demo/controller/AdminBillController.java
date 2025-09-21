package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.Entity.Bill;
import com.example.demo.repository.BillRepository;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
@RequestMapping("/admin/bills")
public class AdminBillController {
    @Autowired
    private BillRepository billRepository;

    @GetMapping
    public String getRecentBill(Model model){
        List<Bill> recentBills = billRepository.findTop10ByOrderByCreateDateDesc();
        model.addAttribute("recentBills", recentBills);
        return "admin/bills";
    }
}
    

