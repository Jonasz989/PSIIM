package backend.server.repository;

import backend.server.model.db.MonumentPoi;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MonumentPoiRepository extends JpaRepository<MonumentPoi, Integer> {

}
