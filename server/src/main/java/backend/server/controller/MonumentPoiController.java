package backend.server.controller;

import backend.server.model.db.MonumentPoi;
import backend.server.service.MonumentPoiService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api")
public class MonumentPoiController {

    private MonumentPoiService monumentPoiService;

    @Autowired
    public MonumentPoiController(MonumentPoiService monumentPoiService) {
        this.monumentPoiService = monumentPoiService;
    }

    @GetMapping("/pois")
    public List<MonumentPoi> findAll() {
        return monumentPoiService.findAll();
    }

    @GetMapping("/pois/{poiId}")
    public Optional<MonumentPoi> findById(int poiId) {
        return monumentPoiService.findById(poiId);
    }

    @PostMapping("/pois")
    public MonumentPoi save(@RequestBody MonumentPoi monumentPoi) {

        MonumentPoi dbMonumentPoi = monumentPoi;
        return monumentPoiService.save(dbMonumentPoi);
    }

    @DeleteMapping("/pois/{poiId}")
    public void deleteById(int poiId) {
        monumentPoiService.deleteById(poiId);
    }

}
