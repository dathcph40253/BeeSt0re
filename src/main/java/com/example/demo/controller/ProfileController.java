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
import org.springframework.web.bind.annotation.RequestParam;
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
        if( customer1.getPhoneNumber() == null || customer1.getName() == null
            || address == null || address.isEmpty() ) {
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
        // Kiểm tra thông tin cần thiết để chuyển sang fullprofile (không yêu cầu email)
        if(newCustomer.getPhoneNumber() != null && newCustomer.getName() != null && newAddress != null) {
            model.addAttribute("customer", newCustomer);
            model.addAttribute("address", newAddress);
            return "fullprofile";
        }

        redirectAttributes.addFlashAttribute("message", "Vui lòng điền đầy đủ thông tin");
        return "redirect:profile";
    }

    @PostMapping("/updateProfile")
    public String updateProfile(@RequestParam("email") String email,
                               @RequestParam("name") String name,
                               @RequestParam("phoneNumber") String phoneNumber,
                               @RequestParam("address") String address,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        Customer customer = (Customer) session.getAttribute("customer");
        if (customer == null) {
            return "redirect:/Home";
        }

        // Cập nhật thông tin customer
        customer.setEmail(email.trim().isEmpty() ? null : email.trim());
        customer.setName(name);
        customer.setPhoneNumber(phoneNumber);
        Customer updatedCustomer = customerService.saveCustomer(customer);

        // Cập nhật địa chỉ
        List<AddressShipping> addresses = updatedCustomer.getAddressShipping();
        AddressShipping addressShipping;
        if (addresses != null && !addresses.isEmpty()) {
            // Cập nhật địa chỉ hiện có
            addressShipping = addresses.get(0);
            addressShipping.setAddress(address);
        } else {
            // Tạo địa chỉ mới
            addressShipping = new AddressShipping();
            addressShipping.setAddress(address);
            addressShipping.setCustomer(updatedCustomer);
        }
        AddressShipping updatedAddress = addressService.saveAddress(addressShipping);

        // Cập nhật session
        session.setAttribute("customer", updatedCustomer);
        session.setAttribute("address", updatedAddress);

        redirectAttributes.addFlashAttribute("message", "Cập nhật thông tin thành công!");
        return "redirect:/profile";
    }

}
