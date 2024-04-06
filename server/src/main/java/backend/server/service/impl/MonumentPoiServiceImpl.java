package backend.server.service.impl;

import backend.server.repository.MonumentPoiRepository;
import backend.server.model.db.MonumentPoi;
import backend.server.service.MonumentPoiService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class MonumentPoiServiceImpl implements MonumentPoiService {

    private MonumentPoiRepository monumentPoiRepository;

    @Autowired
    public MonumentPoiServiceImpl(MonumentPoiRepository monumentPoiRepository) {
        this.monumentPoiRepository = monumentPoiRepository;
    }

    @Override
    public List<MonumentPoi> findAll() {
        return monumentPoiRepository.findAll();
    }

    @Override
    public Optional<MonumentPoi> findById(int theId) {
        return monumentPoiRepository.findById(theId);
    }
    @Transactional

    @Override
    public MonumentPoi save(MonumentPoi theMonumentPoi) {
        return monumentPoiRepository.save(theMonumentPoi);
    }
    @Transactional

    @Override
    public void deleteById(int theId) {
        monumentPoiRepository.deleteById(theId);
    }


}
