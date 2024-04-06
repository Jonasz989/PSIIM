package backend.server.service;

import backend.server.model.db.MonumentPoi;

import java.util.List;
import java.util.Optional;

public interface MonumentPoiService {

    List<MonumentPoi> findAll();
    Optional<MonumentPoi> findById(int theId);
    MonumentPoi save(MonumentPoi theMonumentPoi);
    void deleteById(int theId);
}
