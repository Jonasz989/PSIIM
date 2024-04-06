package backend.server.repository;

import backend.server.model.db.AppUser;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface AppUserRepository extends JpaRepository<AppUser, Long> {
    Optional<AppUser> findByEmail(String email);
    Optional<AppUser> findByNameOrEmail(String username, String email);
    Optional<AppUser> findByName(String name);
    Boolean existsByName(String username);
    Boolean existsByEmail(String email);
}