package backend.server.service.impl;

import backend.server.location.LocationService;
import backend.server.model.db.Achievement;
import backend.server.model.payload.GetAchievementDto;
import backend.server.repository.AchievementRepository;
import backend.server.repository.AppUserRepository;
import backend.server.repository.MonumentPoiRepository;
import backend.server.service.AchievementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class AchievementServiceImpl implements AchievementService {

    private final AchievementRepository achievementRepository;

    private final MonumentPoiRepository monumentPoiRepository;

    private final AppUserRepository appUserRepository;

    private final LocationService locationService;

    @Autowired
    public AchievementServiceImpl(AchievementRepository achievementRepository, MonumentPoiRepository monumentPoiRepository, LocationService locationService, AppUserRepository appUserRepository) {
        this.achievementRepository = achievementRepository;
        this.monumentPoiRepository = monumentPoiRepository;
        this.appUserRepository = appUserRepository;
        this.locationService = locationService;
    }

    @Override
    public List<Achievement> findAll() {
        return achievementRepository.findAll();
    }

    @Override
    public Optional<Achievement> findById(Integer theId) {
        return achievementRepository.findById(theId);
    }

    @Override
    public Achievement save(Achievement achievement) {
        return achievementRepository.save(achievement);
    }

    @Override
    public void deleteById(Integer theId) {
        achievementRepository.deleteById(theId);
    }

    @Override
    public Achievement getAchievement(GetAchievementDto achievement) {

        Achievement achievementToSave = new Achievement();
        monumentPoiRepository.findById((int) achievement.getMonumentId()).ifPresent(monumentPoi -> {

            if (locationService.calculateDistance(achievement.getCurrentLocation().getX(), achievement.getCurrentLocation().getY(), monumentPoi.getLocalization().getX(), monumentPoi.getLocalization().getY()) < 100) {

                achievementToSave.setMonumentPoi(monumentPoi);
                achievementToSave.setName("OSIAGNIECIE - " + monumentPoi.getName());
                achievementToSave.setDescription("Opis twojego zabytku - " + monumentPoi.getDescription());
                achievementToSave.setPoints(100);
                achievementToSave.setPhoto(achievement.getPhoto());
                achievementToSave.setDate(LocalDateTime.now());
                appUserRepository.findById(achievement.getUserId()).ifPresent(achievementToSave::setUser);

            } else {
                throw new IllegalArgumentException("Nie jestes w poblizu zabytku");
            }
        });

        return achievementRepository.save(achievementToSave);
    }

}
