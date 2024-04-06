package backend.server.controller;

import backend.server.model.db.Achievement;
import backend.server.model.payload.GetAchievementDto;
import backend.server.service.AchievementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api")
public class AchievementController {

    private AchievementService achievementService;

    @Autowired
    public AchievementController(AchievementService achievementService) {
        this.achievementService = achievementService;
    }

    @GetMapping("/achievements")
    public List<Achievement> findAll() {
        return achievementService.findAll();
    }

    @GetMapping("/achievements/{achievementId}")
    public Optional<Achievement> findById(@PathVariable Integer achievementId) {
        return achievementService.findById(achievementId);
    }

    @PostMapping("/achievements")
    public Achievement save(@RequestBody Achievement achievement) {

        Achievement dbAchievement = achievement;
        return achievementService.save(dbAchievement);
    }

    @DeleteMapping("/achievements/{achievementId}")
    public void deleteById(@PathVariable Integer achievementId) {
        achievementService.deleteById(achievementId);
    }

    @PostMapping("/get-achievement")
    public Achievement getAchievement(@RequestBody GetAchievementDto achievement) {
        return achievementService.getAchievement(achievement);
    }

}
