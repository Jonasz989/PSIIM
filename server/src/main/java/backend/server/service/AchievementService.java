package backend.server.service;

import backend.server.model.db.Achievement;
import backend.server.model.payload.GetAchievementDto;

import java.util.List;
import java.util.Optional;

public interface AchievementService {

    List<Achievement> findAll();
    Optional<Achievement> findById(Integer theId);
    Achievement save(Achievement achievement);
    void deleteById(Integer theId);

    Achievement getAchievement(GetAchievementDto achievement);
}
