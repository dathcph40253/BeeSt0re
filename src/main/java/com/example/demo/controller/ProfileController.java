package com.example.demo.controller;

import com.example.demo.Dto.InfoDto;
import com.example.demo.Entity.AddressShipping;
import com.example.demo.Entity.Customer;
import com.example.demo.service.AddressService;
import com.example.demo.service.CustomerService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
public class ProfileController {

    private final CustomerService customerService;
    private final AddressService addressService;

    public ProfileController(CustomerService customerService, AddressService addressService) {
        this.customerService = customerService;
        this.addressService = addressService;
    }

    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        Customer customer = (Customer) session.getAttribute("customer");
        if (customer == null) {
            return "redirect:/Home";
        }
        Customer customer1 = customerService.findCustomerById(customer.getId());
        List<AddressShipping> address = customer1.getAddressShipping();
        if( customer1.getEmail() == null || customer1.getPhoneNumber() == null
            || customer1.getName() == null || address == null || address.isEmpty() ) {
            InfoDto dto  = new InfoDto();
            dto.setName(customer1.getName());
            dto.setPhoneNumber( customer1.getPhoneNumber() );
            if(address != null && !address.isEmpty()) {
                dto.setAddress(address.get(0).getAddress());
            }
            model.addAttribute("InfoDto", dto);
            return "profile";
        }
        model.addAttribute("customer", customer1);
        model.addAttribute("address", address.get(0));
        return "fullprofile";
    }
    @PostMapping("/fullProFile")
    public String postFile(@ModelAttribute("InfoDto") @Valid InfoDto infoDto,BindingResult result,HttpSession session, RedirectAttributes redirectAttributes, Model model) {
        if(result.hasErrors()){
            redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.InfoDto", result);
            redirectAttributes.addFlashAttribute("InfoDto", infoDto);
            return "profile";
        }
        Customer customer = (Customer) session.getAttribute("customer");
        if (customer == null) { return "redirect:/BeeStore/Home"; }
        AddressShipping address = new AddressShipping();
        address.setAddress(infoDto.getAddress());
        customer.setName(infoDto.getName());
        customer.setPhoneNumber(infoDto.getPhoneNumber());
        Customer newCustomer = customerService.saveCustomer(customer);
        address.setCustomer(newCustomer);
        session.setAttribute("customer", newCustomer);
        AddressShipping newAddress = addressService.saveAddress(address);
        session.setAttribute("address", newAddress);
        if(newCustomer.getEmail() != null || customer.getEmail() != null){ model.addAttribute("customer", newCustomer); return "fullprofile";}
        redirectAttributes.addFlashAttribute("message", "vui long dien du tt");
        return "redirect:profile";
    }
    @PostMapping("/fullProFile/update")
    public String updateProFile(@ModelAttribute InfoDto infoDto, Model model){
        customerService.updateCustomer(infoDto);
        model.addAttribute("InfoDto", infoDto);
        return "fullprofile";
    }
}
