package com.example.demo.Custom;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;

import java.lang.annotation.*;

@Documented
@Constraint(validatedBy = IntegerOnlyValidator.class)
@Target({ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
public @interface IntegerOnly {
    String message()  default "Phải là số nguyên";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}
