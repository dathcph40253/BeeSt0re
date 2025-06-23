package com.example.demo.controller;

import com.example.demo.Dto.InfoDto;
import com.example.demo.Entity.Customer;
import com.example.demo.Entity.User;
import com.example.demo.service.CustomerService.CustomerService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/BeeStore")
public class ProfileController {

    private final CustomerService customerService;

    public ProfileController(CustomerService customerService) {
        this.customerService = customerService;
    }

    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        Customer customer = (Customer) session.getAttribute("customer");
        if (customer == null) {
            return "redirect:/BeeStore/Home";
        }
        Customer customer1 = customerService.findCustomerById(customer.getId());
        if( customer1.getEmail() == null || customer1.getPhoneNumber() == null
            || customer1.getName() == null ) {
            InfoDto dto  = new InfoDto();
            dto.setName(customer1.getName());
            dto.setPhoneNumber( customer1.getPhoneNumber() );
            model.addAttribute("InfoDto", dto);
            return "profile";
        }
        model.addAttribute("customer", customer1);
        return "fullprofile";
    }
    @PostMapping("/postFile")
    public String postFile(@ModelAttribute("InfoDto") @Valid InfoDto infoDto,BindingResult result,HttpSession session, RedirectAttributes redirectAttributes, Model model) {
        if(result.hasErrors()){
            redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.InfoDto", result);
            redirectAttributes.addFlashAttribute("InfoDto", infoDto);
            return "profile";
        }
        Customer customer = (Customer) session.getAttribute("customer");
        if (customer == null) { return "redirect:/BeeStore/Home"; }
        customer.setName(infoDto.getName());
        customer.setPhoneNumber(infoDto.getPhoneNumber());
        Customer newCustomer = customerService.saveCustomer(customer);
        session.setAttribute("customer", newCustomer);
        customerService.saveCustomer(newCustomer);
        if(newCustomer.getEmail() != null || customer.getEmail() != null){ model.addAttribute("customer", newCustomer); return "fullprofile";}
        redirectAttributes.addFlashAttribute("message", "vui long dien du tt");
        return "redirect:/BeeStore/profile";
    }

}
