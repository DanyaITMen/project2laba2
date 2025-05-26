package com.example.demo.controller;

import com.example.demo.repository.MatchResultRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MatchController {

    private final MatchResultRepository matchResultRepository;

    public MatchController(MatchResultRepository matchResultRepository) {
        this.matchResultRepository = matchResultRepository;
    }

    @GetMapping("/")
    public String showMatches(Model model) {
        var matches = matchResultRepository.findAll();
        model.addAttribute("matches", matches);
        return "matches";
    }
}
