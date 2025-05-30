package com.example.demo.controller;

import com.example.demo.model.User;
import com.example.demo.repository.UserRepository;
import com.example.demo.model.UserRequest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@RestController
@RequestMapping("/api")
public class SignUpRestController {

    private final UserRepository userRepository;
    private final BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

    public SignUpRestController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @PostMapping("/signup")
    public String register(@ModelAttribute UserRequest request, RedirectAttributes redirectAttributes) {
        try {
            System.out.println("=== ПОЧАТОК РЕЄСТРАЦІЇ ===");
            System.out.println("Отримані дані:");
            System.out.println("Username: " + request.getUsername());
            System.out.println("Password: " + request.getPassword());
            System.out.println("Role: " + request.getRole());

            // Перевірка чи користувач вже існує
            boolean userExists = userRepository.existsByUsername(request.getUsername());
            System.out.println("Користувач існує: " + userExists);

            if (userExists) {
                System.out.println("Користувач уже існує!");
                redirectAttributes.addAttribute("error", "Користувач уже існує!");
                return "redirect:/signup";
            }

            // Створення нового користувача
            User user = new User();
            user.setUsername(request.getUsername());

            String encodedPassword = encoder.encode(request.getPassword());
            System.out.println("Закодований пароль: " + encodedPassword);
            user.setPassword(encodedPassword);

            user.setRole(request.getRole());

            System.out.println("Створений об'єкт User: " + user);

            // Збереження в базі даних
            User savedUser = userRepository.save(user);
            System.out.println("Збережений користувач: " + savedUser);
            System.out.println("ID збереженого користувача: " + savedUser.getId());

            // Перевірка чи користувач справді збережений
            long totalUsers = userRepository.count();
            System.out.println("Загальна кількість користувачів в БД: " + totalUsers);

            System.out.println("=== РЕЄСТРАЦІЯ ЗАВЕРШЕНА УСПІШНО ===");

            redirectAttributes.addAttribute("success", "Користувач успішно зареєстрований!");
            return "redirect:/signup";

        } catch (Exception e) {
            System.out.println("=== ПОМИЛКА РЕЄСТРАЦІЇ ===");
            System.out.println("Помилка: " + e.getMessage());
            e.printStackTrace();

            redirectAttributes.addAttribute("error", "Помилка реєстрації: " + e.getMessage());
            return "redirect:/signup";
        }
    }
}