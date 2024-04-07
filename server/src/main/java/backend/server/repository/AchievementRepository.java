package backend.server.repository;

import backend.server.model.db.Achievement;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;


public interface AchievementRepository extends JpaRepository<Achievement, Integer> {

    boolean existsAchievementByUserIdAndMonumentPoi_Id(long userId, long monumentId);

    @Query("SELECT u.name, SUM(a.points) as totalPoints " +
            "FROM achievements a " +
            "JOIN a.user u " +
            "GROUP BY u.name " +
            "ORDER BY totalPoints DESC " +
            "LIMIT 10")
    List<Object[]> getTop10UsersByTotalPoints();

}
