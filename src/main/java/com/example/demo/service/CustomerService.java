package com.example.demo.service;

import com.example.demo.Entity.Customer;
import com.example.demo.repository.CustomerRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CustomerService {
    @Autowired
    private CustomerRepo repo;

    public Customer saveCustomer(Customer customer) {
        return repo.save(customer);
    }
    public Customer findCustomerById(Long id) {
        return repo.findById(id).orElse(null);
    }
    public String generateCustomerCode(){
        List<Customer> newCode = repo.findByCodeStartingWithOrderByCodeDesc("KH");
        int nextNumber =1;
        if(!newCode.isEmpty()){
            String lastCoded =  newCode.get(0).getCode();
            String code = lastCoded.substring(2);
            try{
                nextNumber = Integer.parseInt(code) +1;
            }catch(NumberFormatException e){
                nextNumber = 1;
            }
        }
        return String.format("KH%04d", nextNumber);
    }
}
