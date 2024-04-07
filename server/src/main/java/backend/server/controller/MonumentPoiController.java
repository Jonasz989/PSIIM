package backend.server.controller;

import backend.server.model.db.Comment;
import backend.server.model.db.MonumentPoi;
import backend.server.service.impl.CommentServiceImpl;
import backend.server.service.impl.MonumentPoiServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api")
public class MonumentPoiController {


    private final MonumentPoiServiceImpl monumentPoiServiceImpl;
    private final CommentServiceImpl commentServiceImpl;

    @Autowired
    public MonumentPoiController(MonumentPoiServiceImpl monumentPoiServiceImpl, CommentServiceImpl commentServiceImpl) {
        this.monumentPoiServiceImpl = monumentPoiServiceImpl;
        this.commentServiceImpl = commentServiceImpl;
    }

    @GetMapping("/pois")
    public List<MonumentPoi> findAll() {
        return monumentPoiServiceImpl.findAll();
    }

    @GetMapping("/pois/{poiId}")
    public Optional<MonumentPoi> findById(@PathVariable Integer poiId) {
        return monumentPoiServiceImpl.findById(poiId);
    }

    @PostMapping("/pois")
    public MonumentPoi save(@RequestBody MonumentPoi monumentPoi) {
        return monumentPoiServiceImpl.save(monumentPoi);
    }

    @DeleteMapping("/pois/{poiId}")
    public void deleteById(@PathVariable Integer poiId) {
        monumentPoiServiceImpl.deleteById(poiId);
    }

    @GetMapping("/pois/{poiId}/comments")
    public List<Comment> findCommentsUnderPoi(@PathVariable Integer poiId) {
        return commentServiceImpl.getCommentsByMonumentPoiId(poiId);
    }

    @GetMapping("/pois/{poiId}/comments/{commentId}")
    public Optional<Comment> findCommentUnderPoi(@PathVariable Integer poiId, @PathVariable Integer commentId  ) {
        return commentServiceImpl.getCommentByIdAndMonumentId(commentId, poiId);
    }


}
