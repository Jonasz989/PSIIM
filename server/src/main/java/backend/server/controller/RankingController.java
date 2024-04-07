package backend.server.controller;

import backend.server.model.payload.RankingDto;
import backend.server.service.impl.AchievementServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api")
public class RankingController {

    private AchievementServiceImpl achievementServiceImpl;

    @Autowired
    public RankingController(AchievementServiceImpl achievementServiceImpl) {
        this.achievementServiceImpl = achievementServiceImpl;
    }


    @GetMapping("/ranking")
    public Optional<List<RankingDto>> getRanking() {
        return Optional.ofNullable(achievementServiceImpl.getTop10UsersByTotalPoints());
    }

}
