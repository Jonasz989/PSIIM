package backend.server.repository;

import backend.server.model.db.Achievement;
import org.springframework.data.jpa.repository.JpaRepository;


public interface AchievementRepository extends JpaRepository<Achievement, Integer> {

    boolean existsAchievementByUserIdAndMonumentPoi_Id(long userId, long monumentId);

}
