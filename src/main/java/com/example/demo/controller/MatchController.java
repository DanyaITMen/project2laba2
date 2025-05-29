package com.example.demo.controller;

import com.example.demo.model.MatchResult;
import com.example.demo.model.Team;
import com.example.demo.repository.MatchResultRepository;
import com.example.demo.repository.TeamRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDate;
import java.util.List;

@Controller
public class MatchController {

    private final MatchResultRepository matchResultRepository;
    private final TeamRepository teamRepository;

    public MatchController(MatchResultRepository matchResultRepository, TeamRepository teamRepository) {
        this.matchResultRepository = matchResultRepository;
        this.teamRepository = teamRepository;
    }

    @GetMapping("/")
    public String showMatches(Model model) {
        model.addAttribute("matches", matchResultRepository.findAll());
        return "matches";
    }

    @GetMapping("/matches/add")
    public String showAddForm(Model model) {
        model.addAttribute("teams", teamRepository.findAll());
        return "add-match";
    }

    @PostMapping("/matches/add")
    public String addMatch(@RequestParam String stadium,
                           @RequestParam String matchDate,
                           @RequestParam Long homeTeamId,
                           @RequestParam Long awayTeamId,
                           @RequestParam int homeScore,
                           @RequestParam int awayScore) {
        MatchResult match = new MatchResult();
        match.setStadium(stadium);
        match.setMatchDate(LocalDate.parse(matchDate));
        match.setHomeTeam(teamRepository.findById(homeTeamId).orElseThrow());
        match.setAwayTeam(teamRepository.findById(awayTeamId).orElseThrow());
        match.setHomeScore(homeScore);
        match.setAwayScore(awayScore);

        matchResultRepository.save(match);
        return "redirect:/";
    }

    @GetMapping("/matches/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        MatchResult match = matchResultRepository.findById(id).orElseThrow();
        model.addAttribute("match", match);
        model.addAttribute("teams", teamRepository.findAll());
        return "edit-match";
    }

    @PostMapping("/matches/update")
    public String updateMatch(@RequestParam Long id,
                              @RequestParam String stadium,
                              @RequestParam String matchDate,
                              @RequestParam Long homeTeamId,
                              @RequestParam Long awayTeamId,
                              @RequestParam int homeScore,
                              @RequestParam int awayScore) {
        MatchResult match = matchResultRepository.findById(id).orElseThrow();

        match.setStadium(stadium);
        match.setMatchDate(LocalDate.parse(matchDate));
        match.setHomeTeam(teamRepository.findById(homeTeamId).orElseThrow());
        match.setAwayTeam(teamRepository.findById(awayTeamId).orElseThrow());
        match.setHomeScore(homeScore);
        match.setAwayScore(awayScore);

        matchResultRepository.save(match);
        return "redirect:/";
    }

    @GetMapping("/matches/delete")
    public String showDeleteMatchesPage(Model model) {
        List<MatchResult> matches = (List<MatchResult>) matchResultRepository.findAll();
        model.addAttribute("matches", matches);
        return "delete-match";
    }


    @PostMapping("/matches/delete")
    public String deleteMatch(@RequestParam Long id) {
        matchResultRepository.deleteById(id);
        return "redirect:/matches/delete";
    }

}
